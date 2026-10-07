-- Amplitude de preços dentro de um mesmo ano

WITH TODAS_COTACOES AS (
    SELECT 
        b.blt_ano AS ANO,
        p.prd_nome AS PRODUTO,
        c.cot_prc_min AS PRECO_MINIMO,
        c.cot_prc_max AS PRECO_MAXIMO,
        c.cot_prc_med AS PRECO_MEDIO
    FROM COTACAO c
    JOIN BOLETIM b ON b.blt_id = c.cot_blt_id
    JOIN PRODUTO_APRESENTACAO pa ON pa.pap_id = c.cot_pap_id
    JOIN PRODUTO p ON p.prd_id = pa.pap_prd_id
    
    UNION ALL
    
    SELECT 
        b.blt_ano AS ANO,
        p.prd_nome AS PRODUTO,
        h.hcot_prc_min AS PRECO_MINIMO,
        h.hcot_prc_max AS PRECO_MAXIMO,
        h.hcot_prc_med AS PRECO_MEDIO
    FROM H_COTACAO h
    JOIN BOLETIM b ON b.blt_id = h.hcot_blt_id
    JOIN PRODUTO_APRESENTACAO pa ON pa.pap_id = h.hcot_pap_id
    JOIN PRODUTO p ON p.prd_id = pa.pap_prd_id
)
SELECT 
    ANO,
    PRODUTO,
    ROUND(AVG(PRECO_MINIMO), 2) AS MEDIA_PRECO_MINIMO,
    ROUND(AVG(PRECO_MAXIMO), 2) AS MEDIA_PRECO_MAXIMO,
    ROUND(AVG(PRECO_MEDIO), 2) AS MEDIA_PRECO_MEDIO,
    ROUND(MAX(PRECO_MAXIMO) - MIN(PRECO_MINIMO), 2) AS AMPLITUDE_PRECOS
FROM TODAS_COTACOES
GROUP BY ANO, PRODUTO
ORDER BY ANO, PRODUTO;

-- Preço médio por grupo alimentar e ano

WITH TODAS_COTACOES AS (
    SELECT 
        b.blt_ano AS ANO,
        g.grp_nome AS GRUPO_ALIMENTAR,
        c.cot_prc_med AS PRECO_MEDIO
    FROM COTACAO c
    JOIN BOLETIM b ON b.blt_id = c.cot_blt_id
    JOIN PRODUTO_APRESENTACAO pa ON pa.pap_id = c.cot_pap_id
    JOIN PRODUTO p ON p.prd_id = pa.pap_prd_id
    JOIN CATEGORIA cat ON cat.cat_id = p.prd_cat_id
    JOIN GRUPO_ALIMENTAR g ON g.grp_id = cat.cat_grp_id
    
    UNION ALL
    
    SELECT 
        b.blt_ano AS ANO,
        g.grp_nome AS GRUPO_ALIMENTAR,
        h.hcot_prc_med AS PRECO_MEDIO
    FROM H_COTACAO h
    JOIN BOLETIM b ON b.blt_id = h.hcot_blt_id
    JOIN PRODUTO_APRESENTACAO pa ON pa.pap_id = h.hcot_pap_id
    JOIN PRODUTO p ON p.prd_id = pa.pap_prd_id
    JOIN CATEGORIA cat ON cat.cat_id = p.prd_cat_id
    JOIN GRUPO_ALIMENTAR g ON g.grp_id = cat.cat_grp_id
)
SELECT 
    ANO,
    GRUPO_ALIMENTAR,
    ROUND(AVG(PRECO_MEDIO), 2) AS PRECO_MEDIO
FROM TODAS_COTACOES
GROUP BY ANO, GRUPO_ALIMENTAR
ORDER BY ANO, GRUPO_ALIMENTAR;