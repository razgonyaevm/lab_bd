CREATE INDEX idx_ведомости_ид ON "Н_ВЕДОМОСТИ" USING btree ("ИД");
CREATE INDEX idx_ведомости_тв_ид ON "Н_ВЕДОМОСТИ" USING hash ("ТВ_ИД");



