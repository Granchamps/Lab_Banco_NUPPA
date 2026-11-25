-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2026-11-20 11:58:52 PST
--   site:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE H_BOLETIM 
    ( 
     hblt_id         NUMBER (6) 
         CONSTRAINT ck_nn_hblt_01 NOT NULL , 
     hblt_num        NUMBER (6) 
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

CREATE TABLE H_CATEGORIA 
    ( 
     hcat_id         NUMBER (6) 
         CONSTRAINT ck_nn_hcat_01 NOT NULL , 
     hcat_grp_id     NUMBER (6) 
         CONSTRAINT ck_nn_hcat_02 NOT NULL , 
     hcat_nome       VARCHAR2 (200) 
         CONSTRAINT ck_nn_hcat_03 NOT NULL , 
     hcat_desc       VARCHAR2 (300) , 
     hcat_dt_entrada DATE 
         CONSTRAINT ck_nn_hcat_04 NOT NULL 
    ) 
;

ALTER TABLE H_CATEGORIA 
    ADD CONSTRAINT pk_hcat PRIMARY KEY ( hcat_id, hcat_dt_entrada ) ;

CREATE TABLE H_COTACAO 
    ( 
     hcot_id          NUMBER (6) 
         CONSTRAINT ck_nn_hcot_01 NOT NULL , 
     hcot_blt_id      NUMBER (6) 
         CONSTRAINT ck_nn_hcot_02 NOT NULL , 
     hcot_pap_id      NUMBER (6) 
         CONSTRAINT ck_nn_hcot_03 NOT NULL , 
     hcot_prc_comum   NUMBER (6,2) , 
     hcot_prc_min     NUMBER (6,2) , 
     hcot_prc_max     NUMBER (6,2) , 
     hcot_prc_med     NUMBER (6,2) , 
     hcot_prc_mediana NUMBER (6,2) , 
     hcot_dt_entrada  TIMESTAMP 
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
    CHECK ((HCOT_PRC_COMUM IS NULL OR HCOT_PRC_COMUM >= 0)
AND (HCOT_PRC_MIN IS NULL OR HCOT_PRC_MIN >= 0)
AND (HCOT_PRC_MAX IS NULL OR HCOT_PRC_MAX >= 0)
AND (HCOT_PRC_MED IS NULL OR HCOT_PRC_MED >= 0)
AND (HCOT_PRC_MEDIANA IS NULL OR HCOT_PRC_MEDIANA >= 0)
AND (HCOT_PRC_MIN <= HCOT_PRC_MAX)
AND (HCOT_PRC_MED BETWEEN HCOT_PRC_MIN AND HCOT_PRC_MAX)
AND (HCOT_PRC_MEDIANA BETWEEN HCOT_PRC_MIN AND HCOT_PRC_MAX))
;
ALTER TABLE H_COTACAO 
    ADD CONSTRAINT pk_hcot PRIMARY KEY ( hcot_id, hcot_dt_entrada ) ;

CREATE TABLE H_GRUPO_ALIMENTAR 
    ( 
     hgrp_id         NUMBER (6) 
         CONSTRAINT ck_nn_hgrp_01 NOT NULL , 
     hgrp_nome       VARCHAR2 (50) 
         CONSTRAINT ck_nn_hgrp_02 NOT NULL , 
     hgrp_desc       VARCHAR2 (300) , 
     hgrp_dt_entrada DATE 
         CONSTRAINT ck_nn_hgrp_03 NOT NULL 
    ) 
;

ALTER TABLE H_GRUPO_ALIMENTAR 
    ADD CONSTRAINT pk_hgrp PRIMARY KEY ( hgrp_id, hgrp_dt_entrada ) ;

CREATE TABLE H_PRODUTO 
    ( 
     hprd_id         NUMBER (6) 
         CONSTRAINT ck_nn_hprd_01 NOT NULL , 
     hprd_cat_id     NUMBER (6) 
         CONSTRAINT ck_nn_hprd_02 NOT NULL , 
     hprd_nome       VARCHAR2 (100) 
         CONSTRAINT ck_nn_hprd_03 NOT NULL , 
     hprd_var        VARCHAR2 (50) , 
     hprd_atv        CHAR (1) 
         CONSTRAINT ck_nn_hprd_04 NOT NULL , 
     hprd_dt_entrada DATE 
         CONSTRAINT ck_nn_hprd_05 NOT NULL 
    ) 
;

ALTER TABLE H_PRODUTO 
    ADD CONSTRAINT ck_hprd_atv 
    CHECK (HPRD_ATV IN ('0', '1'))
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
     hpap_qtd        NUMBER (6,3) , 
     hpap_umd_id     NUMBER (6) 
         CONSTRAINT ck_nn_hpap_04 NOT NULL , 
     hpap_atv        CHAR (1) 
         CONSTRAINT ck_nn_hpap_05 NOT NULL , 
     hpap_dt_entrada DATE 
         CONSTRAINT ck_nn_hpap_06 NOT NULL 
    ) 
;

ALTER TABLE H_PRODUTO_APRESENTACAO 
    ADD CONSTRAINT ck_hpap_atv 
    CHECK (HPAP_ATV IN ('0', '1'))
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



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             0
-- ALTER TABLE                             11
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
