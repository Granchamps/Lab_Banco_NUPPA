-- Consultas estratégicas no Banco de Dados NUPPA
-- Allan Granchamps Fernandes Vieira

-- Quais produtos possuem maior preço médio em cada categoria

SELECT
    c.cat_nome,
    p.prd_nome,
    co.cot_prc_med,

    RANK() OVER (
        PARTITION BY c.cat_id
        ORDER BY co.cot_prc_med DESC
    ) ranking,

    DENSE_RANK() OVER (
        PARTITION BY c.cat_id
        ORDER BY co.cot_prc_med DESC
    ) dense_ranking,

    ROW_NUMBER() OVER (
        PARTITION BY c.cat_id
        ORDER BY co.cot_prc_med DESC
    ) numero_linha

FROM cotacao co
JOIN produto_apresentacao pa
    ON pa.pap_id = co.pap_id
JOIN produto p
    ON p.prd_id = pa.prd_id
JOIN categoria c
    ON c.cat_id = p.cat_id

ORDER BY
    c.cat_nome,
    co.cot_prc_med DESC;
/

-- Evolução do preço de cada produto entre boletins

SELECT
    p.prd_nome,
    b.blt_data_lev,
    co.cot_prc_med,

    LAG(co.cot_prc_med) OVER (
        PARTITION BY p.prd_id
        ORDER BY b.blt_data_lev
    ) preco_anterior,

    LEAD(co.cot_prc_med) OVER (
        PARTITION BY p.prd_id
        ORDER BY b.blt_data_lev
    ) preco_proximo

FROM cotacao co
JOIN boletim b
    ON b.blt_id = co.blt_id
JOIN produto_apresentacao pa
    ON pa.pap_id = co.pap_id
JOIN produto p
    ON p.prd_id = pa.prd_id

ORDER BY
    p.prd_nome,
    b.blt_data_lev;
/

-- Comparação do produto com a média da categoria

SELECT
    c.cat_nome,
    p.prd_nome,
    co.cot_prc_med,

    AVG(co.cot_prc_med) OVER (
        PARTITION BY c.cat_id
    ) media_categoria,

    co.cot_prc_med -
    AVG(co.cot_prc_med) OVER (
        PARTITION BY c.cat_id
    ) diferenca_media

FROM cotacao co
JOIN produto_apresentacao pa
    ON pa.pap_id = co.pap_id
JOIN produto p
    ON p.prd_id = pa.prd_id
JOIN categoria c
    ON c.cat_id = p.cat_id

ORDER BY
    c.cat_nome,
    co.cot_prc_med DESC;
/