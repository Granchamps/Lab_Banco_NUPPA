# NUPPA — Banco de Dados de Preços Agrícolas

## Sobre o NUPPA

O **NUPPA (Núcleo de Pesquisas em Preços Agrícolas)** é um projeto da Fatec de Mogi das Cruzes, criado em 2009, que realiza pesquisas e análises dos preços de produtos agrícolas comercializados no Mercado Municipal do Produtor Rural de Mogi das Cruzes — *Minor Harada*.

Entre suas atividades está a elaboração de boletins periódicos com informações sobre os preços mínimos, máximos, médios, comuns e medianos dos produtos pesquisados.

## Sobre o projeto

Este projeto tem como objetivo desenvolver um banco de dados relacional para armazenar, organizar e analisar as informações históricas dos boletins de preços agrícolas publicados pelo NUPPA.

Para isso, os dados originalmente disponibilizados em boletins e planilhas foram extraídos, organizados, padronizados e estruturados para importação em um banco de dados **Oracle Database**.

O banco contempla informações sobre:

- Boletins de preços e datas dos levantamentos;
- Grupos alimentares e categorias;
- Produtos agrícolas e suas apresentações comerciais;
- Unidades de medida;
- Cotações, incluindo preços mínimos, máximos, médios, comuns e medianos.

## Estrutura e funcionalidades do banco

O projeto foi desenvolvido em quatro etapas:

**1. Banco de dados relacional**

Criação das tabelas, relacionamentos, chaves primárias e estrangeiras, restrições de integridade, sequences e triggers para gerenciamento dos registros.

**2. Historiamento de dados**

Implementação de tabelas históricas e triggers para preservar registros anteriores a operações de atualização e exclusão, permitindo manter o histórico das informações.

**3. Auditoria**

Desenvolvimento de mecanismos de auditoria para registrar alterações e exclusões realizadas diretamente nas tabelas históricas, identificando os valores modificados, a operação, a data e o usuário responsável.

**4. Data Warehouse (DW)**

Criação de views dinâmicas, views materializadas e consultas SQL estratégicas para consolidar dados operacionais e históricos, facilitando análises gerenciais e a integração com ferramentas de Business Intelligence.

## Objetivo final — Dashboard analítico

A etapa final do projeto consiste no desenvolvimento de um **dashboard interativo no Microsoft Power BI**, utilizando as informações disponibilizadas pelo banco de dados.

O painel deverá permitir:

- Consultar a evolução histórica dos preços agrícolas;
- Comparar preços entre produtos e períodos;
- Identificar tendências de valorização e desvalorização;
- Analisar a volatilidade e a dispersão dos preços;
- Acompanhar indicadores por categoria e grupo alimentar;
- Apoiar análises e decisões relacionadas à gestão do Mercado do Produtor.

A proposta é transformar os dados históricos dos boletins em informações acessíveis e relevantes para gestores públicos, pesquisadores, produtores e demais interessados no mercado agrícola regional.

## Tecnologias utilizadas

- Oracle Database XE
- Oracle SQL Developer
- SQL / PL/SQL
- Modelagem relacional e Data Warehouse
- Microsoft Power BI

## Organização do repositório

O repositório reúne os scripts SQL referentes à estrutura do banco, ao historiamento, à auditoria e ao Data Warehouse, além dos materiais de documentação do projeto.

---

**Projeto acadêmico desenvolvido na matéria de Laboratório de Banco de Dados do curso de Análise e Desenvolvimento de Sistemas da Fatec de Mogi das Cruzes.**
