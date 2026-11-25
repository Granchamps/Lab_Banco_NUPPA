CREATE OR REPLACE TRIGGER tg_hblt BEFORE
    UPDATE OR DELETE ON boletim
    FOR EACH ROW
BEGIN
    insert into h_boletim values (:old.blt_id, :old.blt_num, :old.blt_ano, :old.blt_data_lev, :old.blt_data_cad, sysdate);
END;
/

CREATE OR REPLACE TRIGGER tg_hcat BEFORE
    UPDATE OR DELETE ON categoria
    FOR EACH ROW
BEGIN
    insert into h_categoria values (:old.cat_id, :old.cat_grp_id, :old.cat_nome, :old.cat_desc, sysdate);
END;
/

CREATE OR REPLACE TRIGGER tg_hcot BEFORE
    UPDATE OR DELETE ON cotacao
    FOR EACH ROW
BEGIN
    insert into h_cotacao values (:old.cot_id, :old.cot_blt_id, :old.cot_pap_id, :old.cot_prc_comum, :old.cot_prc_min, :old.cot_prc_max, :old.cot_prc_med, :old.cot_prc_mediana, systimestamp);
END;
/

CREATE OR REPLACE TRIGGER tg_hgrp BEFORE
    UPDATE OR DELETE ON grupo_alimentar
    FOR EACH ROW
BEGIN
    insert into h_grupo_alimentar values (:old.grp_id, :old.grp_nome, :old.grp_desc, sysdate);
END;
/

CREATE OR REPLACE TRIGGER tg_hprd BEFORE
    UPDATE OR DELETE ON produto
    FOR EACH ROW
BEGIN
    insert into h_produto values (:old.prd_id, :old.prd_cat_id, :old.prd_nome, :old.prd_var, :old.prd_atv, sysdate);
END;
/

CREATE OR REPLACE TRIGGER tg_hpap BEFORE
    UPDATE OR DELETE ON produto_apresentacao
    FOR EACH ROW
BEGIN
    insert into h_produto_apresentacao values (:old.pap_id, :old.pap_prd_id, :old.pap_tap_id, :old.pap_qtd, :old.pap_umd_id, :old.pap_atv, sysdate);
END;
/

CREATE OR REPLACE TRIGGER tg_htap BEFORE
    UPDATE OR DELETE ON tipo_apresentacao
    FOR EACH ROW
BEGIN
    insert into h_tipo_apresentacao values (:old.tap_id, :old.tap_nome, sysdate);
END;
/

CREATE OR REPLACE TRIGGER tg_humd BEFORE
    UPDATE OR DELETE ON unidade_medida
    FOR EACH ROW
BEGIN
    insert into h_unidade_medida values (:old.umd_id, :old.umd_nome, :old.umd_sigla, sysdate);
END;
/