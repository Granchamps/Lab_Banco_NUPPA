-- Consultas estratégicas no Banco de Dados NUPPA
-- Paulo Gustavo Lisboa da Silva

-- Preço médio do produto no boletim anterior

SELECT
    p.prd_nome,
    b.blt_numero,
    b.blt_ano,
    b.blt_data_lev,
    co.cot_prc_med,

    LAG(co.cot_prc_med) OVER (
        PARTITION BY p.prd_id
        ORDER BY b.blt_data_lev
    ) preco_anterior,

    co.cot_prc_med -
    LAG(co.cot_prc_med) OVER (
        PARTITION BY p.prd_id
        ORDER BY b.blt_data_lev
    ) variacao_preco

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

-- Período em que cada produto apresentou a maior alta

SELECT *
FROM (
    SELECT
        p.prd_nome,
        b.blt_data_lev,
        co.cot_prc_med,

        co.cot_prc_med -
        LAG(co.cot_prc_med) OVER (
            PARTITION BY p.prd_id
            ORDER BY b.blt_data_lev
        ) variacao,

        RANK() OVER (
            PARTITION BY p.prd_id
            ORDER BY
                co.cot_prc_med -
                LAG(co.cot_prc_med) OVER (
                    PARTITION BY p.prd_id
                    ORDER BY b.blt_data_lev
                ) DESC
        ) ranking

    FROM cotacao co
    JOIN boletim b
        ON b.blt_id = co.blt_id
    JOIN produto_apresentacao pa
        ON pa.pap_id = co.pap_id
    JOIN produto p
        ON p.prd_id = pa.prd_id
)
WHERE ranking = 1;
/

-- Top 3 produtos mais caros por grupo alimentar

SELECT *
FROM (
    SELECT
        g.grp_nome,
        p.prd_nome,
        co.cot_prc_med,

        DENSE_RANK() OVER (
            PARTITION BY g.grp_id
            ORDER BY co.cot_prc_med DESC
        ) posicao

    FROM cotacao co
    JOIN produto_apresentacao pa
        ON pa.pap_id = co.pap_id
    JOIN produto p
        ON p.prd_id = pa.prd_id
    JOIN categoria c
        ON c.cat_id = p.cat_id
    JOIN grupo_alimentar g
        ON g.grp_id = c.grp_id
)
WHERE posicao <= 3

ORDER BY
    grp_nome,
    posicao;