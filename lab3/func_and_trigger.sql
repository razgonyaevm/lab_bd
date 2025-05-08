CREATE OR REPLACE FUNCTION validate_call_from_number_and_token()
RETURNS TRIGGER AS $$
    BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM PHONE_NUMBER
        WHERE NUMBER = NEW.FROM_NUMBER
    ) THEN
        RAISE EXCEPTION 'Invalid FROM_NUMBER: % is not registered in PHONE_NUMBER', NEW.FROM_NUMBER;
    END IF;

    IF NEW.TOKEN IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1
            FROM PHONE_NUMBER PN
            JOIN SUBSCRIBER_CREDIT_TOKEN SCT ON PN.SUBSCRIBER = SCT.SUBSCRIBER_ID
            WHERE PN.NUMBER = NEW.FROM_NUMBER AND SCT.TOKEN_ID = NEW.TOKEN
        ) THEN
            RAISE EXCEPTION 'Token ID % is not assigned to the subscriber for phone number %', NEW.TOKEN, NEW.FROM_NUMBER;
        END IF;
    END IF;
    RETURN NEW;
END;

$$ LANGUAGE plpgsql;

CREATE TRIGGER check_call_from_number_and_token
BEFORE INSERT OR UPDATE ON CALL
FOR EACH ROW
EXECUTE FUNCTION validate_call_from_number_and_token();