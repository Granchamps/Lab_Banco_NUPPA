-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2026-11-15 20:26:29 PST
--   site:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE BOLETIM 
    ( 
     blt_id       NUMBER (6) 
         CONSTRAINT ck_nn_blt_01 NOT NULL , 
     blt_num      NUMBER (6) 
         CONSTRAINT ck_nn_blt_02 NOT NULL , 
     blt_ano      NUMBER (4) 
         CONSTRAINT ck_nn_blt_03 NOT NULL , 
     blt_data_lev DATE 
         CONSTRAINT ck_nn_blt_04 NOT NULL , 
     blt_data_cad DATE 
    ) 
;

ALTER TABLE BOLETIM 
    ADD CONSTRAINT pk_blt PRIMARY KEY ( blt_id ) ;

ALTER TABLE BOLETIM 
    ADD CONSTRAINT uk_blt_num_ano UNIQUE ( blt_num , blt_ano ) ;

CREATE TABLE CATEGORIA 
    ( 
     cat_id     NUMBER (6) 
         CONSTRAINT ck_nn_cat_01 NOT NULL , 
     cat_grp_id NUMBER (6) 
         CONSTRAINT ck_nn_cat_02 NOT NULL , 
     cat_nome   VARCHAR2 (200) 
         CONSTRAINT ck_nn_cat_03 NOT NULL , 
     cat_desc   VARCHAR2 (300) 
    ) 
;

ALTER TABLE CATEGORIA 
    ADD CONSTRAINT pk_cat PRIMARY KEY ( cat_id ) ;

ALTER TABLE CATEGORIA 
    ADD CONSTRAINT uk_cat_grp_nome UNIQUE ( cat_grp_id , cat_nome ) ;

CREATE TABLE COTACAO 
    ( 
     cot_id          NUMBER (6) 
         CONSTRAINT ck_nn_cot_01 NOT NULL , 
     cot_blt_id      NUMBER (6) 
         CONSTRAINT ck_nn_cot_02 NOT NULL , 
     cot_pap_id      NUMBER (6) 
         CONSTRAINT ck_nn_cot_03 NOT NULL , 
     cot_prc_comum   NUMBER (6,2) , 
     cot_prc_min     NUMBER (6,2) , 
     cot_prc_max     NUMBER (6,2) , 
     cot_prc_med     NUMBER (6,2) , 
     cot_prc_mediana NUMBER (6,2) 
    ) 
;

ALTER TABLE COTACAO 
    ADD CONSTRAINT ck_cot_prc 
    CHECK ((COT_PRC_COMUM IS NULL OR COT_PRC_COMUM >= 0)
AND (COT_PRC_MIN IS NULL OR COT_PRC_MIN >= 0)
AND (COT_PRC_MAX IS NULL OR COT_PRC_MAX >= 0)
AND (COT_PRC_MED IS NULL OR COT_PRC_MED >= 0)
AND (COT_PRC_MEDIANA IS NULL OR COT_PRC_MEDIANA >= 0)
AND (COT_PRC_MIN <= COT_PRC_MAX)
AND (COT_PRC_MED BETWEEN COT_PRC_MIN AND COT_PRC_MAX)
AND (COT_PRC_MEDIANA BETWEEN COT_PRC_MIN AND COT_PRC_MAX))
;
ALTER TABLE COTACAO 
    ADD CONSTRAINT pk_cot PRIMARY KEY ( cot_id ) ;

ALTER TABLE COTACAO 
    ADD CONSTRAINT uk_cot_blt_pap UNIQUE ( cot_blt_id , cot_pap_id ) ;

CREATE TABLE GRUPO_ALIMENTAR 
    ( 
     grp_id   NUMBER (6) 
         CONSTRAINT ck_nn_grp_01 NOT NULL , 
     grp_nome VARCHAR2 (50) 
         CONSTRAINT ck_nn_grp_02 NOT NULL , 
     grp_desc VARCHAR2 (300) 
    ) 
;

ALTER TABLE GRUPO_ALIMENTAR 
    ADD CONSTRAINT pk_grp PRIMARY KEY ( grp_id ) ;

CREATE TABLE PRODUTO 
    ( 
     prd_id     NUMBER (6) 
         CONSTRAINT ck_nn_prd_01 NOT NULL , 
     prd_cat_id NUMBER (6) 
         CONSTRAINT ck_nn_prd_02 NOT NULL , 
     prd_nome   VARCHAR2 (100) 
         CONSTRAINT ck_nn_prd_03 NOT NULL , 
     prd_var    VARCHAR2 (50) , 
     prd_atv    CHAR (1)  NOT NULL 
    ) 
;

ALTER TABLE PRODUTO 
    ADD CONSTRAINT ck_prd_atv 
    CHECK (PRD_ATV IN ('0', '1'))
;
ALTER TABLE PRODUTO 
    ADD CONSTRAINT pk_prd PRIMARY KEY ( prd_id ) ;

ALTER TABLE PRODUTO 
    ADD CONSTRAINT uk_prd_cat_nom_var UNIQUE ( prd_cat_id , prd_nome , prd_var ) ;

CREATE TABLE PRODUTO_APRESENTACAO 
    ( 
     pap_id     NUMBER (6) 
         CONSTRAINT ck_nn_pap_01 NOT NULL , 
     pap_prd_id NUMBER (6) 
         CONSTRAINT ck_nn_pap_02 NOT NULL , 
     pap_tap_id NUMBER (6) 
         CONSTRAINT ck_nn_pap_03 NOT NULL , 
     pap_qtd    NUMBER (6,3) , 
     pap_umd_id NUMBER (6) 
         CONSTRAINT ck_nn_pap_04 NOT NULL , 
     pap_atv    CHAR (1) 
         CONSTRAINT ck_nn_pap_05 NOT NULL 
    ) 
;

ALTER TABLE PRODUTO_APRESENTACAO 
    ADD CONSTRAINT ck_pap_atv 
    CHECK (PAP_ATV IN ('0', '1'))
;


ALTER TABLE PRODUTO_APRESENTACAO 
    ADD CONSTRAINT ck_pap_qtd 
    CHECK (PAP_QTD > 0)
;
ALTER TABLE PRODUTO_APRESENTACAO 
    ADD CONSTRAINT pk_pap PRIMARY KEY ( pap_id ) ;

CREATE TABLE TIPO_APRESENTACAO 
    ( 
     tap_id   NUMBER (6) 
         CONSTRAINT ck_nn_tap_01 NOT NULL , 
     tap_nome VARCHAR2 (50) 
         CONSTRAINT ck_nn_tap_02 NOT NULL 
    ) 
;

ALTER TABLE TIPO_APRESENTACAO 
    ADD CONSTRAINT pk_tap PRIMARY KEY ( tap_id ) ;

CREATE TABLE UNIDADE_MEDIDA 
    ( 
     umd_id    NUMBER (6) 
         CONSTRAINT ck_nn_umd_01 NOT NULL , 
     umd_nome  VARCHAR2 (50) 
         CONSTRAINT ck_nn_umd_02 NOT NULL , 
     umd_sigla VARCHAR2 (10) 
         CONSTRAINT ck_nn_umd_03 NOT NULL 
    ) 
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
