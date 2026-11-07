-- Criacao da sequence da auditoria

CREATE SEQUENCE SEQ_AUD
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Criacao da sequence de evento (agrupa as linhas geradas por uma mesma operacao sobre um registro)

CREATE SEQUENCE SEQ_AUD_EVENTO
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Criacao do trigger da auditoria

CREATE OR REPLACE TRIGGER TG_SEQ_AUD
BEFORE INSERT ON AUDITORIA
FOR EACH ROW
BEGIN
    :NEW.aud_id := SEQ_AUD.NEXTVAL;
END;
/