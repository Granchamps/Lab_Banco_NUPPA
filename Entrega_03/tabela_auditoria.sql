-- Criacao da tabela auditoria


CREATE TABLE AUDITORIA (
    aud_id NUMBER(12)
        CONSTRAINT pk_aud PRIMARY KEY,

    aud_evento_id NUMBER(12) NOT NULL,
    aud_registro_id NUMBER(12),

    aud_tabela VARCHAR2(30) NOT NULL,
    aud_coluna VARCHAR2(30) NOT NULL,

    aud_valor_antigo VARCHAR2(4000),
    aud_valor_novo VARCHAR2(4000),

    aud_tp_operacao CHAR(1) NOT NULL,
    aud_data_entrada TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,

    aud_bd_user VARCHAR2(128) NOT NULL,
    aud_so_user VARCHAR2(255),

    CONSTRAINT ck_aud_operacao
        CHECK (aud_tp_operacao IN ('I', 'U', 'D'))
);