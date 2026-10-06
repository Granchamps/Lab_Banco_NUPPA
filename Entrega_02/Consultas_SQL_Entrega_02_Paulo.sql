-- Amplitude de preços dentro de um mesmo ano

SELECT
    b.blt_ano AS ANO,
    p.prd_nome AS PRODUTO,
    ROUND(AVG(c.cot_prc_min), 2) AS MEDIA_PRECO_MINIMO,
    ROUND(AVG(c.cot_prc_max), 2) AS MEDIA_PRECO_MAXIMO,
    ROUND(AVG(c.cot_prc_med), 2) AS MEDIA_PRECO_MEDIO,
    ROUND(MAX(c.cot_prc_max) - MIN(c.cot_prc_min), 2)
        AS AMPLITUDE_PRECOS
FROM COTACAO c
JOIN BOLETIM b
    ON b.blt_id = c.cot_blt_id
JOIN PRODUTO_APRESENTACAO pa
    ON pa.pap_id = c.cot_pap_id
JOIN PRODUTO p
    ON p.prd_id = pa.pap_prd_id
GROUP BY b.blt_ano, p.prd_nome
ORDER BY b.blt_ano, p.prd_nome;

-- Preço médio por grupo alimentar e ano

SELECT
    b.blt_ano AS ANO,
    g.grp_nome AS GRUPO_ALIMENTAR,
    ROUND(AVG(c.cot_prc_med), 2) AS PRECO_MEDIO
FROM COTACAO c
JOIN BOLETIM b
    ON b.blt_id = c.cot_blt_id
JOIN PRODUTO_APRESENTACAO pa
    ON pa.pap_id = c.cot_pap_id
JOIN PRODUTO p
    ON p.prd_id = pa.pap_prd_id
JOIN CATEGORIA cat
    ON cat.cat_id = p.prd_cat_id
JOIN GRUPO_ALIMENTAR g
    ON g.grp_id = cat.cat_grp_id
GROUP BY b.blt_ano, g.grp_nome
ORDER BY b.blt_ano, g.grp_nome;
