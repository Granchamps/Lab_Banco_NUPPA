-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2026-09-01 20:26:16 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

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

ALTER TABLE BOLETIM 
    ADD CONSTRAINT pk_blt PRIMARY KEY ( blt_id ) ;

ALTER TABLE BOLETIM 
    ADD CONSTRAINT uk_blt_num_ano UNIQUE ( blt_numero , blt_ano ) ;

CREATE TABLE CATEGORIA 
    ( 
     cat_id   NUMBER (6) 
         CONSTRAINT ck_cat_nn_01 NOT NULL , 
     grp_id   NUMBER (6) 
         CONSTRAINT ck_cat_nn_02 NOT NULL , 
     cat_nome VARCHAR2 (50) 
         CONSTRAINT ck_cat_nn_03 NOT NULL , 
     cat_desc VARCHAR2 (200) 
    ) 
;

ALTER TABLE CATEGORIA 
    ADD CONSTRAINT pk_cat PRIMARY KEY ( cat_id ) ;

ALTER TABLE CATEGORIA 
    ADD CONSTRAINT uk_cat_grp_nome UNIQUE ( grp_id , cat_nome ) ;

CREATE TABLE COTACAO 
    ( 
     cot_id          NUMBER (6) 
         CONSTRAINT ck_cot_nn_01 NOT NULL , 
     blt_id          NUMBER (6) 
         CONSTRAINT ck_cot_nn_02 NOT NULL , 
     pap_id          NUMBER (6) 
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
    ADD CONSTRAINT uk_cot_blt_pap UNIQUE ( blt_id , pap_id ) ;

CREATE TABLE GRUPO_ALIMENTAR 
    ( 
     grp_id   NUMBER (6) 
         CONSTRAINT ck_grp_nn_01 NOT NULL , 
     grp_nome VARCHAR2 (30) 
         CONSTRAINT ck_grp_nn_02 NOT NULL , 
     grp_desc VARCHAR2 (300) 
    ) 
;

ALTER TABLE GRUPO_ALIMENTAR 
    ADD CONSTRAINT pk_grp PRIMARY KEY ( grp_id ) ;

ALTER TABLE GRUPO_ALIMENTAR 
    ADD CONSTRAINT uk_grp_nome UNIQUE ( grp_nome ) ;

CREATE TABLE PRODUTO 
    ( 
     prd_id   NUMBER (6) 
         CONSTRAINT ck_prd_nn_01 NOT NULL , 
     cat_id   NUMBER (6) 
         CONSTRAINT ck_prd_nn_02 NOT NULL , 
     prd_nome VARCHAR2 (100) 
         CONSTRAINT ck_prd_nn_03 NOT NULL , 
     prd_var  VARCHAR2 (50) , 
     prd_atv  CHAR (1) 
         CONSTRAINT ck_prd_nn_04 NOT NULL 
    ) 
;

ALTER TABLE PRODUTO 
    ADD CONSTRAINT ck_prd_atv 
    CHECK (prd_atv in (0,1))
;
ALTER TABLE PRODUTO 
    ADD CONSTRAINT pk_prd PRIMARY KEY ( prd_id ) ;

ALTER TABLE PRODUTO 
    ADD CONSTRAINT uk_prd_cat_nom_var UNIQUE ( cat_id , prd_nome , prd_var ) ;

CREATE TABLE PRODUTO_APRESENTACAO 
    ( 
     pap_id  NUMBER (6) 
         CONSTRAINT ck_pap_nn_01 NOT NULL , 
     prd_id  NUMBER (6) 
         CONSTRAINT ck_pap_nn_02 NOT NULL , 
     tap_id  NUMBER (6) 
         CONSTRAINT ck_pap_nn_03 NOT NULL , 
     pap_qtd NUMBER (6) , 
     umd_id  NUMBER (6) 
         CONSTRAINT ck_pap_nn_04 NOT NULL , 
     pap_atv CHAR (1) 
         CONSTRAINT ck_pap_nn_05 NOT NULL 
    ) 
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

ALTER TABLE UNIDADE_MEDIDA 
    ADD CONSTRAINT pk_umd PRIMARY KEY ( umd_id ) ;

ALTER TABLE CATEGORIA 
    ADD CONSTRAINT fk_cat_grp FOREIGN KEY 
    ( 
     grp_id
    ) 
    REFERENCES GRUPO_ALIMENTAR 
    ( 
     grp_id
    ) 
;

ALTER TABLE COTACAO 
    ADD CONSTRAINT fk_cot_blt FOREIGN KEY 
    ( 
     blt_id
    ) 
    REFERENCES BOLETIM 
    ( 
     blt_id
    ) 
;

ALTER TABLE COTACAO 
    ADD CONSTRAINT fk_cot_pap FOREIGN KEY 
    ( 
     pap_id
    ) 
    REFERENCES PRODUTO_APRESENTACAO 
    ( 
     pap_id
    ) 
;

ALTER TABLE PRODUTO_APRESENTACAO 
    ADD CONSTRAINT fk_pap_prd FOREIGN KEY 
    ( 
     prd_id
    ) 
    REFERENCES PRODUTO 
    ( 
     prd_id
    ) 
;

ALTER TABLE PRODUTO_APRESENTACAO 
    ADD CONSTRAINT fk_pap_tap FOREIGN KEY 
    ( 
     tap_id
    ) 
    REFERENCES TIPO_APRESENTACAO 
    ( 
     tap_id
    ) 
;

ALTER TABLE PRODUTO_APRESENTACAO 
    ADD CONSTRAINT fk_pap_umd FOREIGN KEY 
    ( 
     umd_id
    ) 
    REFERENCES UNIDADE_MEDIDA 
    ( 
     umd_id
    ) 
;

ALTER TABLE PRODUTO 
    ADD CONSTRAINT fk_prd_cat FOREIGN KEY 
    ( 
     cat_id
    ) 
    REFERENCES CATEGORIA 
    ( 
     cat_id
    ) 
;



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             0
-- ALTER TABLE                             23
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
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
-- CREATE SEQUENCE                          0
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
