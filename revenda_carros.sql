-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 05-Abr-2024 às 19:57
-- Versão do servidor: 10.4.27-MariaDB
-- versão do PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `revenda_carros`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `carros`
--

CREATE TABLE `carros` (
  `ID` int(11) NOT NULL,
  `Marca` varchar(50) DEFAULT NULL,
  `Modelo` varchar(50) DEFAULT NULL,
  `Ano` int(11) DEFAULT NULL,
  `Preco` decimal(10,2) DEFAULT NULL,
  `Estoque` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `carros`
--

INSERT INTO `carros` (`ID`, `Marca`, `Modelo`, `Ano`, `Preco`, `Estoque`) VALUES
(1, 'Toyota', 'Corolla', 2020, '20000.00', 9),
(2, 'Honda', 'Civic', 2019, '18000.00', 8),
(3, 'Ford', 'Mustang', 2021, '30000.00', 5),
(4, 'Renault', 'Sandero TechRun', 2014, '34000.00', 5),
(5, 'Renault', 'Fluence GT', 2014, '50000.00', 5),
(6, 'Renault', 'Sandero RS', 2018, '50000.00', 8);

-- --------------------------------------------------------

--
-- Estrutura da tabela `clientes`
--

CREATE TABLE `clientes` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(100) DEFAULT NULL,
  `Telefone` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `clientes`
--

INSERT INTO `clientes` (`ID`, `Nome`, `Telefone`) VALUES
(1, 'João Silva', '555-1234'),
(2, 'Maria Santos', '555-2345'),
(3, 'Carlos Pereira', '555-3456'),
(4, 'Renato Trajano', '469-2630'),
(5, 'Everson Lucas', '341-3280'),
(6, 'Beatriz Trajano', '550-1237'),
(7, 'Marcio Lemos', '545-1834');

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionarios`
--

CREATE TABLE `funcionarios` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(100) DEFAULT NULL,
  `Cargo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `funcionarios`
--

INSERT INTO `funcionarios` (`ID`, `Nome`, `Cargo`) VALUES
(1, 'Ana Lúcia', 'Gerente de Vendas'),
(2, 'Roberto Alves', 'Vendedor'),
(3, 'Fernando Costa', 'Mecânico'),
(4, 'Lucas Martins', 'Vendedor'),
(5, 'Juliana Almeida', 'Vendedora');

-- --------------------------------------------------------

--
-- Estrutura da tabela `vendas`
--

CREATE TABLE `vendas` (
  `ID` int(11) NOT NULL,
  `ID_Carro` int(11) DEFAULT NULL,
  `ModeloCarro` varchar(50) DEFAULT NULL,
  `ID_Cliente` int(11) DEFAULT NULL,
  `NomeCliente` varchar(100) DEFAULT NULL,
  `ID_Funcionario` int(11) DEFAULT NULL,
  `NomeFuncionario` varchar(100) DEFAULT NULL,
  `DataVenda` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `vendas`
--

INSERT INTO `vendas` (`ID`, `ID_Carro`, `ModeloCarro`, `ID_Cliente`, `NomeCliente`, `ID_Funcionario`, `NomeFuncionario`, `DataVenda`) VALUES
(0, 6, 'Sandero RS', 4, 'Renato Trajano', 5, 'Juliana Almeida', '2024-04-05'),
(1, 1, 'Corolla', 1, 'João Silva', 2, 'Roberto Alves', '2024-01-15'),
(2, 2, 'Civic', 2, 'Maria Santos', 2, 'Roberto Alves', '2024-02-20'),
(3, 3, 'Mustang', 3, 'Carlos Pereira', 2, 'Roberto Alves', '2024-03-25'),
(4, 4, 'Sandero TechRun', 4, 'Renato Trajano', 4, 'Lucas Martins', '2024-04-10'),
(5, 5, 'Fluence GT', 5, 'Everson Lucas', 5, 'Juliana Almeida', '2024-05-15'),
(6, 4, 'Sandero TechRun', 5, 'Everson Lucas', 4, 'Lucas Martins', '2024-04-05'),
(7, 1, 'Corolla', 7, 'Marcio Lemos', 5, 'Juliana Almeida', '2024-01-15');

--
-- Acionadores `vendas`
--
DELIMITER $$
CREATE TRIGGER `AtualizarEstoque` AFTER INSERT ON `vendas` FOR EACH ROW BEGIN
    UPDATE Carros SET Estoque = Estoque - 1 WHERE ID = NEW.ID_Carro;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `vendasporfuncionario`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `vendasporfuncionario` (
`Nome` varchar(100)
,`Cargo` varchar(50)
,`NumVendas` bigint(21)
);

-- --------------------------------------------------------

--
-- Estrutura para vista `vendasporfuncionario`
--
DROP TABLE IF EXISTS `vendasporfuncionario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vendasporfuncionario`  AS SELECT `funcionarios`.`Nome` AS `Nome`, `funcionarios`.`Cargo` AS `Cargo`, (select count(0) from `vendas` where `vendas`.`ID_Funcionario` = `funcionarios`.`ID`) AS `NumVendas` FROM `funcionarios` WHERE `funcionarios`.`ID` in (select distinct `vendas`.`ID_Funcionario` from `vendas`)  ;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `carros`
--
ALTER TABLE `carros`
  ADD PRIMARY KEY (`ID`);

--
-- Índices para tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`ID`);

--
-- Índices para tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD PRIMARY KEY (`ID`);

--
-- Índices para tabela `vendas`
--
ALTER TABLE `vendas`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID_Carro` (`ID_Carro`),
  ADD KEY `ID_Cliente` (`ID_Cliente`),
  ADD KEY `ID_Funcionario` (`ID_Funcionario`);

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `vendas`
--
ALTER TABLE `vendas`
  ADD CONSTRAINT `vendas_ibfk_1` FOREIGN KEY (`ID_Carro`) REFERENCES `carros` (`ID`),
  ADD CONSTRAINT `vendas_ibfk_2` FOREIGN KEY (`ID_Cliente`) REFERENCES `clientes` (`ID`),
  ADD CONSTRAINT `vendas_ibfk_3` FOREIGN KEY (`ID_Funcionario`) REFERENCES `funcionarios` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
