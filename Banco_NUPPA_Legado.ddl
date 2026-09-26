-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2026-09-25 23:07:35 PDT
--   site:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE H_BOLETIM 
    ( 
     hblt_id         NUMBER (6) 
         CONSTRAINT ck_nn_hblt_01 NOT NULL , 
     hblt_numero     NUMBER (6) 
         CONSTRAINT ck_nn_hblt_02 NOT NULL , 
     hblt_ano        NUMBER (4) 
         CONSTRAINT ck_nn_hblt_03 NOT NULL , 
     hblt_data_lev   DATE 
         CONSTRAINT ck_nn_hblt_04 NOT NULL , 
     hblt_data_cad   DATE , 
     hblt_dt_entrada DATE 
         CONSTRAINT ck_nn_hblt_05 NOT NULL 
    ) 
;

COMMENT ON COLUMN H_BOLETIM.hblt_data_lev IS 'Data em que o levantamento foi realizado' 
;

COMMENT ON COLUMN H_BOLETIM.hblt_data_cad IS 'Data em que o levantamento foi cadastrado' 
;

ALTER TABLE H_BOLETIM 
    ADD CONSTRAINT pk_hblt PRIMARY KEY ( hblt_id, hblt_dt_entrada ) ;

CREATE TABLE BOLETIM 
    ( 
     blt_id       NUMBER (6) 
         CONSTRAINT ck_blt_nn_01 NOT NULL , 
     blt_numero   NUMBER (6) 
         CONSTRAINT ck_blt_nn_02 NOT NULL , 
     blt_ano      NUMBER (4) 
         CONSTRAINT ck_blt_nn_03 NOT NULL , 
     blt_data_lev DATE 
         CONSTRAINT ck_blt_nn_04 NOT NULL , 
     blt_data_cad DATE 
    ) 
;

COMMENT ON COLUMN BOLETIM.blt_data_lev IS 'Data em que o levantamento foi realizado' 
;

COMMENT ON COLUMN BOLETIM.blt_data_cad IS 'Data em que o levantamento foi cadastrado' 
;
CREATE OR REPLACE TRIGGER tg_hblt BEFORE
	DELETE OR UPDATE ON BOLETIM
	FOR EACH ROW
BEGIN
	insert into H_BOLETIM values (:old.blt_id, :old.blt_numero, :old.blt_ano, :old.blt_data_lev, :old.blt_data_cad, sysdate);
END
;

ALTER TABLE BOLETIM 
    ADD CONSTRAINT pk_blt PRIMARY KEY ( blt_id ) ;

ALTER TABLE BOLETIM 
    ADD CONSTRAINT uk_blt_num_ano UNIQUE ( blt_numero , blt_ano ) ;

CREATE TABLE H_CATEGORIA 
    ( 
     hcat_id         NUMBER (6) 
         CONSTRAINT ck_nn_hcat_01 NOT NULL , 
     hcat_grp_id     NUMBER (6) 
         CONSTRAINT ck_nn_hcat_02 NOT NULL , 
     hcat_nome       VARCHAR2 (50) 
         CONSTRAINT ck_nn_hcat_02 NOT NULL , 
     hcat_desc       VARCHAR2 (200) , 
     hcat_dt_entrada DATE 
         CONSTRAINT ck_nn_hcat_04 NOT NULL 
    ) 
;

ALTER TABLE H_CATEGORIA 
    ADD CONSTRAINT pk_hcat PRIMARY KEY ( hcat_id, hcat_dt_entrada ) ;

CREATE TABLE CATEGORIA 
    ( 
     cat_id     NUMBER (6) 
         CONSTRAINT ck_cat_nn_01 NOT NULL , 
     cat_grp_id NUMBER (6) 
         CONSTRAINT ck_cat_nn_02 NOT NULL , 
     cat_nome   VARCHAR2 (50) 
         CONSTRAINT ck_cat_nn_03 NOT NULL , 
     cat_desc   VARCHAR2 (200) 
    ) 
;
CREATE OR REPLACE TRIGGER tg_hcat BEFORE
	DELETE OR UPDATE ON CATEGORIA
	FOR EACH ROW
BEGIN
	insert into H_CATEGORIA values (:old.cat_id, :old.cat_grp_id, :old.cat_nome, :old.cat_desc, sysdate);
END
;

ALTER TABLE CATEGORIA 
    ADD CONSTRAINT pk_cat PRIMARY KEY ( cat_id ) ;

ALTER TABLE CATEGORIA 
    ADD CONSTRAINT uk_cat_grp_nome UNIQUE ( cat_grp_id , cat_nome ) ;

CREATE TABLE H_COTACAO 
    ( 
     hcot_id          NUMBER (6) 
         CONSTRAINT ck_nn_hcot_01 NOT NULL , 
     hcot_blt_id      NUMBER (6) 
         CONSTRAINT ck_nn_hcot_02 NOT NULL , 
     hcot_pap_id      NUMBER (6) 
         CONSTRAINT ck_nn_hcot_03 NOT NULL , 
     hcot_prc_comum   NUMBER (6,2) , 
     hcot_prc_min     NUMBER (6,2) 
         CONSTRAINT ck_nn_hcot_04 NOT NULL , 
     hcot_prc_max     NUMBER (6,2) 
         CONSTRAINT ck_nn_hcot_05 NOT NULL , 
     hcot_prc_med     NUMBER (6,2) 
         CONSTRAINT ck_nn_hcot_06 NOT NULL , 
     hcot_prc_mediana NUMBER (6,2) 
         CONSTRAINT ck_nn_hcot_07 NOT NULL , 
     hcot_dt_entrada  DATE 
         CONSTRAINT ck_nn_hcot_08 NOT NULL 
    ) 
;

COMMENT ON COLUMN H_COTACAO.hcot_prc_comum IS 'preço comum' 
;

COMMENT ON COLUMN H_COTACAO.hcot_prc_min IS 'preço minimo' 
;

COMMENT ON COLUMN H_COTACAO.hcot_prc_max IS 'preço maximo' 
;

ALTER TABLE H_COTACAO 
    ADD CONSTRAINT ck_hcot_prc 
    CHECK ((cot_prc_comum IS NULL OR cot_prc_comum >= 0)
AND hcot_prc_min >= 0
AND hcot_prc_max >= hcot_prc_min
AND hcot_prc_med >= hcot_prc_min
AND hcot_prc_med <= hcot_prc_max
AND hcot_prc_mediana >= hcot_prc_min
AND hcot_prc_mediana <= hcot_prc_max)
;
ALTER TABLE H_COTACAO 
    ADD CONSTRAINT pk_hcot PRIMARY KEY ( hcot_id, hcot_dt_entrada ) ;

CREATE TABLE COTACAO 
    ( 
     cot_id          NUMBER (6) 
         CONSTRAINT ck_cot_nn_01 NOT NULL , 
     cot_blt_id      NUMBER (6) 
         CONSTRAINT ck_cot_nn_02 NOT NULL , 
     cot_pap_id      NUMBER (6) 
         CONSTRAINT ck_cot_nn_03 NOT NULL , 
     cot_prc_comum   NUMBER (6,2) , 
     cot_prc_min     NUMBER (6,2) 
         CONSTRAINT ck_cot_nn_04 NOT NULL , 
     cot_prc_max     NUMBER (6,2) 
         CONSTRAINT ck_cot_nn_05 NOT NULL , 
     cot_prc_med     NUMBER (6,2) 
         CONSTRAINT ck_cot_nn_06 NOT NULL , 
     cot_prc_mediana NUMBER (6,2) 
         CONSTRAINT ck_cot_nn_07 NOT NULL 
    ) 
;

COMMENT ON COLUMN COTACAO.cot_prc_comum IS 'preço comum' 
;

COMMENT ON COLUMN COTACAO.cot_prc_min IS 'preço minimo' 
;

COMMENT ON COLUMN COTACAO.cot_prc_max IS 'preço maximo' 
;
CREATE OR REPLACE TRIGGER tg_hcot BEFORE
	DELETE OR UPDATE ON COTACAO
	FOR EACH ROW
BEGIN
	insert into H_COTACAO values (:old.cot_id, :old.cot_blt_id, :old.cot_pap_id, :old.cot_prc_comum, :old.cot_prc_min, :old.cot_prc_max, :old.cot_prc_med, :old.cot_prc_mediana, sysdate);
END
;

ALTER TABLE COTACAO 
    ADD CONSTRAINT ck_cot_prc 
    CHECK ((cot_prc_comum IS NULL OR cot_prc_comum >= 0)
AND cot_prc_min >= 0
AND cot_prc_max >= cot_prc_min
AND cot_prc_med >= cot_prc_min
AND cot_prc_med <= cot_prc_max
AND cot_prc_mediana >= cot_prc_min
AND cot_prc_mediana <= cot_prc_max)
;
ALTER TABLE COTACAO 
    ADD CONSTRAINT pk_cot PRIMARY KEY ( cot_id ) ;

ALTER TABLE COTACAO 
    ADD CONSTRAINT uk_cot_blt_pap UNIQUE ( cot_blt_id , cot_pap_id ) ;

CREATE TABLE H_GRUPO_ALIMENTAR 
    ( 
     hgrp_id         NUMBER (6) 
         CONSTRAINT ck_nn_hgrp_01 NOT NULL , 
     hgrp_nome       VARCHAR2 (30) 
         CONSTRAINT ck_nn_hgrp_02 NOT NULL , 
     hgrp_desc       VARCHAR2 (300) , 
     hgrp_dt_entrada DATE 
         CONSTRAINT ck_nn_hgrp_03 NOT NULL 
    ) 
;

ALTER TABLE H_GRUPO_ALIMENTAR 
    ADD CONSTRAINT pk_hgrp PRIMARY KEY ( hgrp_id, hgrp_dt_entrada ) ;

CREATE TABLE GRUPO_ALIMENTAR 
    ( 
     grp_id   NUMBER (6) 
         CONSTRAINT ck_grp_nn_01 NOT NULL , 
     grp_nome VARCHAR2 (30) 
         CONSTRAINT ck_grp_nn_02 NOT NULL , 
     grp_desc VARCHAR2 (300) 
    ) 
;
CREATE OR REPLACE TRIGGER tg_hgrp BEFORE
	DELETE OR UPDATE ON GRUPO_ALIMENTAR
	FOR EACH ROW
BEGIN
	insert into H_GRUPO_ALIMENTAR values (:old.grp_id, :old.grp_nome, :old.grp_desc, sysdate);
END
;

ALTER TABLE GRUPO_ALIMENTAR 
    ADD CONSTRAINT pk_grp PRIMARY KEY ( grp_id ) ;

ALTER TABLE GRUPO_ALIMENTAR 
    ADD CONSTRAINT uk_grp_nome UNIQUE ( grp_nome ) ;

CREATE TABLE H_PRODUTO 
    ( 
     hprd_id         NUMBER (6) 
         CONSTRAINT ck_nn_hprd_01 NOT NULL , 
     hprd_cat_id     NUMBER (6) 
         CONSTRAINT ck_nn_hprd_02 NOT NULL , 
     hprd_nome       VARCHAR2 (100) 
         CONSTRAINT ck_nn_hprd_03 NOT NULL , 
     hprd_var        VARCHAR2 (50) , 
     hprd_atv        NUMBER 
         CONSTRAINT ck_nn_hprd_04 NOT NULL , 
     hprd_dt_entrada DATE 
         CONSTRAINT ck_nn_hprd_05 NOT NULL 
    ) 
;

ALTER TABLE H_PRODUTO 
    ADD CONSTRAINT ck_hprd_atv 
    CHECK (prd_atv in (0,1))
;
ALTER TABLE H_PRODUTO 
    ADD CONSTRAINT pk_hprd PRIMARY KEY ( hprd_id, hprd_dt_entrada ) ;

CREATE TABLE H_PRODUTO_APRESENTACAO 
    ( 
     hpap_id         NUMBER (6) 
         CONSTRAINT ck_nn_hpap_01 NOT NULL , 
     hpap_prd_id     NUMBER (6) 
         CONSTRAINT ck_nn_hpap_02 NOT NULL , 
     hpap_tap_id     NUMBER (6) 
         CONSTRAINT ck_nn_hpap_03 NOT NULL , 
     hpap_qtd        NUMBER (6) , 
     hpap_umd_id     NUMBER (6) 
         CONSTRAINT ck_nn_hpap_04 NOT NULL , 
     hpap_atv        NUMBER 
         CONSTRAINT ck_nn_hpap_05 NOT NULL , 
     hpap_dt_entrada DATE 
         CONSTRAINT ck_nn_hpap_06 NOT NULL 
    ) 
;

ALTER TABLE H_PRODUTO_APRESENTACAO 
    ADD CONSTRAINT ck_hpap_atv 
    CHECK (pap_atv in (0,1))
;
ALTER TABLE H_PRODUTO_APRESENTACAO 
    ADD CONSTRAINT pk_hpap PRIMARY KEY ( hpap_id, hpap_dt_entrada ) ;

CREATE TABLE H_TIPO_APRESENTACAO 
    ( 
     htap_id         NUMBER (6) 
         CONSTRAINT ck_nn_htap_01 NOT NULL , 
     htap_nome       VARCHAR2 (50) 
         CONSTRAINT ck_nn_htap_02 NOT NULL , 
     htap_dt_entrada DATE 
         CONSTRAINT ck_nn_htap_03 NOT NULL 
    ) 
;

COMMENT ON COLUMN H_TIPO_APRESENTACAO.htap_nome IS 'caixa, duzia, maço, etc' 
;

ALTER TABLE H_TIPO_APRESENTACAO 
    ADD CONSTRAINT pk_htap PRIMARY KEY ( htap_id, htap_dt_entrada ) ;

CREATE TABLE H_UNIDADE_MEDIDA 
    ( 
     humd_id         NUMBER (6) 
         CONSTRAINT ck_nn_humd_01 NOT NULL , 
     humd_nome       VARCHAR2 (50) 
         CONSTRAINT ck_nn_humd_02 NOT NULL , 
     humd_sigla      VARCHAR2 (10) 
         CONSTRAINT ck_nn_humd_03 NOT NULL , 
     humd_dt_entrada DATE 
         CONSTRAINT ck_nn_humd_04 NOT NULL 
    ) 
;

ALTER TABLE H_UNIDADE_MEDIDA 
    ADD CONSTRAINT pk_humd PRIMARY KEY ( humd_id, humd_dt_entrada ) ;

CREATE TABLE PRODUTO 
    ( 
     prd_id     NUMBER (6) 
         CONSTRAINT ck_prd_nn_01 NOT NULL , 
     prd_cat_id NUMBER (6) 
         CONSTRAINT ck_prd_nn_02 NOT NULL , 
     prd_nome   VARCHAR2 (100) 
         CONSTRAINT ck_prd_nn_03 NOT NULL , 
     prd_var    VARCHAR2 (50) , 
     prd_atv    NUMBER 
         CONSTRAINT ck_prd_nn_04 NOT NULL 
    ) 
;
CREATE OR REPLACE TRIGGER tg_hprd BEFORE
	DELETE OR UPDATE ON PRODUTO
	FOR EACH ROW
BEGIN
	insert into H_PRODUTO values (:old.prd_id, :old.prd_cat_id, :old.prd_nome, :old.prd_var, :old.prd_atv, sysdate);
END
;

ALTER TABLE PRODUTO 
    ADD CONSTRAINT ck_prd_atv 
    CHECK (prd_atv in (0,1))
;
ALTER TABLE PRODUTO 
    ADD CONSTRAINT pk_prd PRIMARY KEY ( prd_id ) ;

ALTER TABLE PRODUTO 
    ADD CONSTRAINT uk_prd_cat_nom_var UNIQUE ( prd_cat_id , prd_nome , prd_var ) ;

CREATE TABLE PRODUTO_APRESENTACAO 
    ( 
     pap_id     NUMBER (6) 
         CONSTRAINT ck_pap_nn_01 NOT NULL , 
     pap_prd_id NUMBER (6) 
         CONSTRAINT ck_pap_nn_02 NOT NULL , 
     pap_tap_id NUMBER (6) 
         CONSTRAINT ck_pap_nn_03 NOT NULL , 
     pap_qtd    NUMBER (6) , 
     pap_umd_id NUMBER (6) 
         CONSTRAINT ck_pap_nn_04 NOT NULL , 
     pap_atv    NUMBER 
         CONSTRAINT ck_pap_nn_05 NOT NULL 
    ) 
;
CREATE OR REPLACE TRIGGER tg_hpap BEFORE
	DELETE OR UPDATE ON PRODUTO_APRESENTACAO
	FOR EACH ROW
BEGIN
	insert into H_PRODUTO_APRESENTACAO values (:old.pap_id, :old.pap_prd_id, :old.pap_tap_id, :old.pap_qtd, :old.pap_umd_id, :old.pap_atv, sysdate);
END
;

ALTER TABLE PRODUTO_APRESENTACAO 
    ADD CONSTRAINT ck_pap_atv 
    CHECK (pap_atv in (0,1))
;
ALTER TABLE PRODUTO_APRESENTACAO 
    ADD CONSTRAINT pk_pap PRIMARY KEY ( pap_id ) ;

CREATE TABLE TIPO_APRESENTACAO 
    ( 
     tap_id   NUMBER (6) 
         CONSTRAINT ck_tap_nn_01 NOT NULL , 
     tap_nome VARCHAR2 (50) 
         CONSTRAINT ck_tap_nn_02 NOT NULL 
    ) 
;

COMMENT ON COLUMN TIPO_APRESENTACAO.tap_nome IS 'caixa, duzia, maço, etc' 
;
CREATE OR REPLACE TRIGGER tg_htap BEFORE
	DELETE OR UPDATE ON TIPO_APRESENTACAO
	FOR EACH ROW
BEGIN
	insert into H_TIPO_APRESENTACAO values (:old.tap_id, :old.tap_nome, sysdate);
END
;

ALTER TABLE TIPO_APRESENTACAO 
    ADD CONSTRAINT pk_tap PRIMARY KEY ( tap_id ) ;

CREATE TABLE UNIDADE_MEDIDA 
    ( 
     umd_id    NUMBER (6) 
         CONSTRAINT ck_umd_nn_01 NOT NULL , 
     umd_nome  VARCHAR2 (50) 
         CONSTRAINT ck_umd_nn_02 NOT NULL , 
     umd_sigla VARCHAR2 (10) 
         CONSTRAINT ck_umd_nn_03 NOT NULL 
    ) 
;
CREATE OR REPLACE TRIGGER tg_humd BEFORE
	DELETE OR UPDATE ON UNIDADE_MEDIDA
	FOR EACH ROW
BEGIN
	insert into H_UNIDADE_MEDIDA values (:old.umd_id, :old.umd_nome, :old.umd_sigla, sysdate);
END
;

ALTER TABLE UNIDADE_MEDIDA 
    ADD CONSTRAINT pk_umd PRIMARY KEY ( umd_id ) ;

ALTER TABLE CATEGORIA 
    ADD CONSTRAINT fk_cat_grp FOREIGN KEY 
    ( 
     cat_grp_id
    ) 
    REFERENCES GRUPO_ALIMENTAR 
    ( 
     grp_id
    ) 
;

ALTER TABLE COTACAO 
    ADD CONSTRAINT fk_cot_blt FOREIGN KEY 
    ( 
     cot_blt_id
    ) 
    REFERENCES BOLETIM 
    ( 
     blt_id
    ) 
;

ALTER TABLE COTACAO 
    ADD CONSTRAINT fk_cot_pap FOREIGN KEY 
    ( 
     cot_pap_id
    ) 
    REFERENCES PRODUTO_APRESENTACAO 
    ( 
     pap_id
    ) 
;

ALTER TABLE PRODUTO_APRESENTACAO 
    ADD CONSTRAINT fk_pap_prd FOREIGN KEY 
    ( 
     pap_prd_id
    ) 
    REFERENCES PRODUTO 
    ( 
     prd_id
    ) 
;

ALTER TABLE PRODUTO_APRESENTACAO 
    ADD CONSTRAINT fk_pap_tap FOREIGN KEY 
    ( 
     pap_tap_id
    ) 
    REFERENCES TIPO_APRESENTACAO 
    ( 
     tap_id
    ) 
;

ALTER TABLE PRODUTO_APRESENTACAO 
    ADD CONSTRAINT fk_pap_umd FOREIGN KEY 
    ( 
     pap_umd_id
    ) 
    REFERENCES UNIDADE_MEDIDA 
    ( 
     umd_id
    ) 
;

ALTER TABLE PRODUTO 
    ADD CONSTRAINT fk_prd_cat FOREIGN KEY 
    ( 
     prd_cat_id
    ) 
    REFERENCES CATEGORIA 
    ( 
     cat_id
    ) 
;

CREATE SEQUENCE seq_blt 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER tg_seq_blt 
BEFORE INSERT ON BOLETIM 
FOR EACH ROW 
BEGIN 
    :NEW.blt_id := seq_blt.NEXTVAL; 
END;
/

CREATE SEQUENCE seq_cat 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER tg_seq_cat 
BEFORE INSERT ON CATEGORIA 
FOR EACH ROW 
BEGIN 
    :NEW.cat_id := seq_cat.NEXTVAL; 
END;
/

CREATE SEQUENCE seq_cot 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER tg_seq_cot 
BEFORE INSERT ON COTACAO 
FOR EACH ROW 
BEGIN 
    :NEW.cot_id := seq_cot.NEXTVAL; 
END;
/

CREATE SEQUENCE seq_grp 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER tg_seq_grp 
BEFORE INSERT ON GRUPO_ALIMENTAR 
FOR EACH ROW 
BEGIN 
    :NEW.grp_id := seq_grp.NEXTVAL; 
END;
/

CREATE SEQUENCE seq_prd 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER tg_seq_prd 
BEFORE INSERT ON PRODUTO 
FOR EACH ROW 
BEGIN 
    :NEW.prd_id := seq_prd.NEXTVAL; 
END;
/

CREATE SEQUENCE seq_pap 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER tg_seq_pap 
BEFORE INSERT ON PRODUTO_APRESENTACAO 
FOR EACH ROW 
BEGIN 
    :NEW.pap_id := seq_pap.NEXTVAL; 
END;
/

CREATE SEQUENCE seq_tap 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER tg_seq_tap 
BEFORE INSERT ON TIPO_APRESENTACAO 
FOR EACH ROW 
BEGIN 
    :NEW.tap_id := seq_tap.NEXTVAL; 
END;
/

CREATE SEQUENCE seq_umd 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER tg_seq_umd 
BEFORE INSERT ON UNIDADE_MEDIDA 
FOR EACH ROW 
BEGIN 
    :NEW.umd_id := seq_umd.NEXTVAL; 
END;
/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            16
-- CREATE INDEX                             0
-- ALTER TABLE                             34
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           8
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          8
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
