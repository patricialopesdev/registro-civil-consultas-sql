CREATE DATABASE registro_civil_2023;
USE registro_civil_2023;

CREATE TABLE IF NOT EXISTS registro_civil (
    id INT PRIMARY KEY,
    titulo_tabela VARCHAR(500) NOT NULL,
    categoria VARCHAR(100) NOT NULL
);

-- Selecionar todos os registros
SELECT * FROM registro_civil_2023;

-- Contagem total por categoria (nascimento, óbito, casamento, divórcio)
SELECT `Título da Tabela`, COUNT(*) AS total
FROM registro_civil_2023
GROUP BY `Título da Tabela`
ORDER BY total DESC;

-- Contar quantas tabelas existem por categoria
SELECT categoria, COUNT(*) AS total_tabelas
FROM registro_civil
GROUP BY categoria
ORDER BY total_tabelas DESC;

-- Filtrar tabela por categoria
SELECT * FROM registro_civil
WHERE categoria = 'óbito';

-- Filtrar óbitos envolvendo sexo, idade e ano 2022
SELECT * FROM registro_civil
WHERE categoria = 'óbito'
  AND titulo_tabela LIKE '%sexo%'
  AND titulo_tabela LIKE '%idade%'
  AND titulo_tabela LIKE '%2022%';

-- Filtrar tabelas de mães estrangeiras 2022
SELECT * FROM registro_civil
WHERE titulo_tabela LIKE '%mães estrangeiras%'
  AND titulo_tabela LIKE '%2022%';
  
-- Casamento entre homem e mulher 2022
 SELECT * FROM registro_civil
WHERE titulo_tabela LIKE '%cônjuges masculino e feminino%'
  AND titulo_tabela LIKE '%idade%'
  AND titulo_tabela LIKE '%2022%';

-- Casamentos masculinos
 SELECT * FROM registro_civil
WHERE titulo_tabela LIKE '%cônjuges masculinos%'
  AND titulo_tabela LIKE '%nascimento%'
  AND titulo_tabela LIKE '%2022%';

-- Casamentos femininos
  SELECT * FROM registro_civil
WHERE titulo_tabela LIKE '%cônjuges femininos%'
  AND titulo_tabela LIKE '%nascimento%'
  AND titulo_tabela LIKE '%2022%';

-- Comparar quantidade de tabelas: casamentos masculinos vs femininos  
  SELECT 
  CASE 
    WHEN titulo_tabela LIKE '%cônjuges masculinos%' THEN 'masculinos'
    WHEN titulo_tabela LIKE '%cônjuges femininos%' THEN 'femininos'
  END AS tipo,
  COUNT(*) AS qtd_tabelas
FROM registro_civil
WHERE titulo_tabela LIKE '%nascimento%'
  AND titulo_tabela LIKE '%2022%'
GROUP BY tipo;

-- Total de divórcio
SELECT COUNT(*) AS total_divorcios
FROM registro_civil
WHERE categoria = 'divórcio';
