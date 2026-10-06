-- Comparação do preço médio de cada produto entre 2023 e 2025

WITH TODAS_COTACOES AS (
    SELECT
        b.blt_ano AS ANO,
        pa.pap_id AS APRESENTACAO_ID,
        p.prd_nome AS PRODUTO,
        c.cot_prc_med AS PRECO_MEDIO
    FROM COTACAO c
    JOIN BOLETIM b
        ON b.blt_id = c.cot_blt_id
    JOIN PRODUTO_APRESENTACAO pa
        ON pa.pap_id = c.cot_pap_id
    JOIN PRODUTO p
        ON p.prd_id = pa.pap_prd_id

    UNION ALL

    SELECT
        b.blt_ano AS ANO,
        pa.pap_id AS APRESENTACAO_ID,
        p.prd_nome AS PRODUTO,
        h.hcot_prc_med AS PRECO_MEDIO
    FROM H_COTACAO h
    JOIN BOLETIM b
        ON b.blt_id = h.hcot_blt_id
    JOIN PRODUTO_APRESENTACAO pa
        ON pa.pap_id = h.hcot_pap_id
    JOIN PRODUTO p
        ON p.prd_id = pa.pap_prd_id
)
SELECT
    PRODUTO,
    ROUND(AVG(CASE WHEN ANO = 2023
                   THEN PRECO_MEDIO END), 2) AS PRECO_2023,
    ROUND(AVG(CASE WHEN ANO = 2024
                   THEN PRECO_MEDIO END), 2) AS PRECO_2024,
    ROUND(AVG(CASE WHEN ANO = 2025
                   THEN PRECO_MEDIO END), 2) AS PRECO_2025
FROM TODAS_COTACOES
GROUP BY PRODUTO
ORDER BY PRODUTO;


-- Variação percentual do preço médio entre os anos

WITH TODAS_COTACOES AS (
    SELECT
        b.blt_ano AS ANO,
        pa.pap_id AS APRESENTACAO_ID,
        p.prd_nome AS PRODUTO,
        c.cot_prc_med AS PRECO_MEDIO
    FROM COTACAO c
    JOIN BOLETIM b
        ON b.blt_id = c.cot_blt_id
    JOIN PRODUTO_APRESENTACAO pa
        ON pa.pap_id = c.cot_pap_id
    JOIN PRODUTO p
        ON p.prd_id = pa.pap_prd_id

    UNION ALL

    SELECT
        b.blt_ano AS ANO,
        pa.pap_id AS APRESENTACAO_ID,
        p.prd_nome AS PRODUTO,
        h.hcot_prc_med AS PRECO_MEDIO
    FROM H_COTACAO h
    JOIN BOLETIM b
        ON b.blt_id = h.hcot_blt_id
    JOIN PRODUTO_APRESENTACAO pa
        ON pa.pap_id = h.hcot_pap_id
    JOIN PRODUTO p
        ON p.prd_id = pa.pap_prd_id
),
MEDIAS_ANUAIS AS (
    SELECT
        APRESENTACAO_ID,
        PRODUTO,
        ROUND(AVG(CASE WHEN ANO = 2023
                       THEN PRECO_MEDIO END), 2) AS PRECO_2023,
        ROUND(AVG(CASE WHEN ANO = 2024
                       THEN PRECO_MEDIO END), 2) AS PRECO_2024,
        ROUND(AVG(CASE WHEN ANO = 2025
                       THEN PRECO_MEDIO END), 2) AS PRECO_2025
    FROM TODAS_COTACOES
    GROUP BY APRESENTACAO_ID, PRODUTO
)
SELECT
    PRODUTO,
    APRESENTACAO_ID,
    PRECO_2023,
    PRECO_2024,
    PRECO_2025,
    ROUND(
        (PRECO_2024 - PRECO_2023) /
        NULLIF(PRECO_2023, 0) * 100, 2
    ) AS VARIACAO_2023_2024_PCT,
    ROUND(
        (PRECO_2025 - PRECO_2024) /
        NULLIF(PRECO_2024, 0) * 100, 2
    ) AS VARIACAO_2024_2025_PCT
FROM MEDIAS_ANUAIS
ORDER BY PRODUTO, APRESENTACAO_ID;