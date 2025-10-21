USE sistema_bancario;

-- Procedures para cadastro de clientes pessoa física
DROP PROCEDURE IF EXISTS sp_cadastrar_clientePF;

DELIMITER $$
CREATE PROCEDURE sp_cadastrar_clientePF (
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_cpf VARCHAR(14),
    IN p_data_nascimento DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO Clientes (nome, email, telefone, endereco, username, password)
    VALUES (p_nome, p_email, p_telefone, p_endereco, p_username, p_password);

    SET @cliente_id = LAST_INSERT_ID();

    INSERT INTO Clientes_PF (cliente_id, cpf, data_nascimento)
    VALUES (@cliente_id, p_cpf, p_data_nascimento);

    COMMIT;
END $$
DELIMITER ;

-- Procedures para atualização de dados do cliente pessoa física
DROP PROCEDURE IF EXISTS sp_alterar_clientePF;

DELIMITER $$
CREATE PROCEDURE sp_alterar_clientePF (
    IN p_id INT,
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_cpf VARCHAR(14),
    IN p_data_nascimento DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE Clientes
    SET nome = p_nome,
        email = p_email,
        telefone = p_telefone,
        endereco = p_endereco,
        username = p_username,
        password = p_password
    WHERE id = p_id;

    UPDATE Clientes_PF
    SET cpf = p_cpf,
        data_nascimento = p_data_nascimento
    WHERE cliente_id = p_id;

    COMMIT;
END $$
DELIMITER ;

-- Procedure para remover cliente pessoa física
DROP PROCEDURE IF EXISTS sp_deletar_clientePF;

DELIMITER $$
CREATE PROCEDURE sp_deletar_clientePF (
    IN p_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM Clientes_PF WHERE cliente_id = p_id;
    DELETE FROM Clientes WHERE id = p_id;

    COMMIT;
END $$
DELIMITER ;

-- Procedure para buscar clientes pessoa física pelo nome (parcial)
DROP PROCEDURE IF EXISTS sp_consultar_clientePF_por_nome;

DELIMITER $$
CREATE PROCEDURE sp_consultar_clientePF_por_nome (
    IN p_nome VARCHAR(100)
)
BEGIN
    SELECT * FROM Clientes
    WHERE nome LIKE CONCAT('%', p_nome, '%');
END $$
DELIMITER ;

-- Procedure para buscar clientes pessoa física pela razão social (OBS: Campo pode não existir, ajustar conforme tabela)
DROP PROCEDURE IF EXISTS sp_consultar_clientePF_por_razao_social;

DELIMITER $$
CREATE PROCEDURE sp_consultar_clientePF_por_razao_social (
    IN p_razao_social VARCHAR(100)
)
BEGIN
    SELECT c.*, pf.cpf, pf.data_nascimento
    FROM Clientes c
    INNER JOIN Clientes_PF pf ON c.id = pf.cliente_id
    WHERE pf.razao_social LIKE CONCAT('%', p_razao_social, '%');
END $$
DELIMITER ;

-- Procedure para buscar cliente pessoa física pelo CPF
DROP PROCEDURE IF EXISTS sp_consultar_clientePF_por_cpf;

DELIMITER $$
CREATE PROCEDURE sp_consultar_clientePF_por_cpf (
    IN p_cpf VARCHAR(14)
)
BEGIN
    SELECT c.*, pf.cpf, pf.data_nascimento
    FROM Clientes c
    INNER JOIN Clientes_PF pf ON c.id = pf.cliente_id
    WHERE pf.cpf = p_cpf;
END $$
DELIMITER ;

-- Procedure para buscar cliente pessoa física pelo ID
DROP PROCEDURE IF EXISTS sp_consultar_clientePF_por_id;

DELIMITER $$
CREATE PROCEDURE sp_consultar_clientePF_por_id (
    IN p_id INT
)
BEGIN
    SELECT c.*, pf.cpf, pf.data_nascimento
    FROM Clientes c
    INNER JOIN Clientes_PF pf ON c.id = pf.cliente_id
    WHERE c.id = p_id;
END $$
DELIMITER ;

-- Procedure para buscar cliente pessoa física pelo email
DROP PROCEDURE IF EXISTS sp_consultar_clientePF_por_email;

DELIMITER $$
CREATE PROCEDURE sp_consultar_clientePF_por_email (
    IN p_email VARCHAR(100)
)
BEGIN
    SELECT c.*, pf.cpf, pf.data_nascimento
    FROM Clientes c
    INNER JOIN Clientes_PF pf ON c.id = pf.cliente_id
    WHERE c.email = p_email;
END $$
DELIMITER ;



-- Procedures para clientes pessoa jurídica

DROP PROCEDURE IF EXISTS sp_cadastrar_clientePJ;

DELIMITER $$
CREATE PROCEDURE sp_cadastrar_clientePJ (
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_cnpj VARCHAR(18),
    IN p_razao_social VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO Clientes (nome, email, telefone, endereco, username, password)
    VALUES (p_nome, p_email, p_telefone, p_endereco, p_username, p_password);

    SET @cliente_id = LAST_INSERT_ID();

    INSERT INTO Clientes_PJ (cliente_id, cnpj, razao_social)
    VALUES (@cliente_id, p_cnpj, p_razao_social);

    COMMIT;
END $$
DELIMITER ;

-- Procedure para atualizar cliente pessoa jurídica
DROP PROCEDURE IF EXISTS sp_alterar_clientePJ;

DELIMITER $$
CREATE PROCEDURE sp_alterar_clientePJ (
    IN p_id INT,
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_cnpj VARCHAR(18),
    IN p_razao_social VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE Clientes
    SET nome = p_nome,
        email = p_email,
        telefone = p_telefone,
        endereco = p_endereco,
        username = p_username,
        password = p_password
    WHERE id = p_id;

    UPDATE Clientes_PJ
    SET cnpj = p_cnpj,
        razao_social = p_razao_social
    WHERE cliente_id = p_id;

    COMMIT;
END $$
DELIMITER ;

-- Procedure para deletar cliente pessoa jurídica
DROP PROCEDURE IF EXISTS sp_deletar_clientePJ;

DELIMITER $$
CREATE PROCEDURE sp_deletar_clientePJ (
    IN p_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM Clientes_PJ WHERE cliente_id = p_id;
    DELETE FROM Clientes WHERE id = p_id;

    COMMIT;
END $$
DELIMITER ;

-- Procedure para consultar cliente pessoa jurídica por nome (parcial)
DROP PROCEDURE IF EXISTS sp_consultar_clientePJ_por_nome;

DELIMITER $$
CREATE PROCEDURE sp_consultar_clientePJ_por_nome (
    IN p_nome VARCHAR(100)
)
BEGIN
    SELECT * FROM Clientes
    WHERE nome LIKE CONCAT('%', p_nome, '%');
END $$
DELIMITER ;

-- Procedure para consultar cliente pessoa jurídica por razão social
DROP PROCEDURE IF EXISTS sp_consultar_clientePJ_por_razao_social;

DELIMITER $$
CREATE PROCEDURE sp_consultar_clientePJ_por_razao_social (
    IN p_razao_social VARCHAR(100)
)
BEGIN
    SELECT c.*, pj.cnpj, pj.razao_social
    FROM Clientes c
    INNER JOIN Clientes_PJ pj ON c.id = pj.cliente_id
    WHERE pj.razao_social LIKE CONCAT('%', p_razao_social, '%');
END $$
DELIMITER ;

-- Procedure para consultar cliente pessoa jurídica por CNPJ
DROP PROCEDURE IF EXISTS sp_consultar_clientePJ_por_cnpj;

DELIMITER $$
CREATE PROCEDURE sp_consultar_clientePJ_por_cnpj (
    IN p_cnpj VARCHAR(18)
)
BEGIN
    SELECT c.*, pj.cnpj, pj.razao_social
    FROM Clientes c
    INNER JOIN Clientes_PJ pj ON c.id = pj.cliente_id
    WHERE pj.cnpj = p_cnpj;
END $$
DELIMITER ;

-- Procedure para consultar cliente pessoa jurídica por ID
DROP PROCEDURE IF EXISTS sp_consultar_clientePJ_por_id;

DELIMITER $$
CREATE PROCEDURE sp_consultar_clientePJ_por_id (
    IN p_id INT
)
BEGIN
    SELECT c.*, pj.cnpj, pj.razao_social
    FROM Clientes c
    INNER JOIN Clientes_PJ pj ON c.id = pj.cliente_id
    WHERE c.id = p_id;
END $$
DELIMITER ;

-- Procedure para consultar cliente pessoa jurídica por email
DROP PROCEDURE IF EXISTS sp_consultar_clientePJ_por_email;

DELIMITER $$
CREATE PROCEDURE sp_consultar_clientePJ_por_email (
    IN p_email VARCHAR(100)
)
BEGIN
    SELECT c.*, pj.cnpj, pj.razao_social
    FROM Clientes c
    INNER JOIN Clientes_PJ pj ON c.id = pj.cliente_id
    WHERE c.email = p_email;
END $$
DELIMITER ;



-- Procedures para gerenciar contas

-- Criar conta
DROP PROCEDURE IF EXISTS sp_criar_conta;

DELIMITER $$
CREATE PROCEDURE sp_criar_conta (
    IN p_cliente_id INT,
    IN p_tipo_conta VARCHAR(20),
    IN p_saldo DECIMAL(15,2)
)
BEGIN
    INSERT INTO Contas (cliente_id, tipo_conta, saldo)
    VALUES (p_cliente_id, p_tipo_conta, p_saldo);
END $$
DELIMITER ;

-- Atualizar dados da conta
DROP PROCEDURE IF EXISTS sp_alterar_conta;

DELIMITER $$
CREATE PROCEDURE sp_alterar_conta (
    IN p_id INT,
    IN p_tipo_conta VARCHAR(20),
    IN p_saldo DECIMAL(15,2)
)
BEGIN
    UPDATE Contas
    SET tipo_conta = p_tipo_conta,
        saldo = p_saldo
    WHERE id = p_id;
END $$
DELIMITER ;

-- Deletar conta
DROP PROCEDURE IF EXISTS sp_deletar_conta;

DELIMITER $$
CREATE PROCEDURE sp_deletar_conta (
    IN p_id INT
)
BEGIN
    DELETE FROM Contas
    WHERE id = p_id;
END $$
DELIMITER ;

-- Consultar conta por ID
DROP PROCEDURE IF EXISTS sp_consultar_conta_por_id;

DELIMITER $$
CREATE PROCEDURE sp_consultar_conta_por_id (
    IN p_id INT
)
BEGIN
    SELECT * FROM Contas
    WHERE id = p_id;
END $$
DELIMITER ;

-- Consultar contas pelo cliente ID
DROP PROCEDURE IF EXISTS sp_consultar_contas_por_cliente;

DELIMITER $$
CREATE PROCEDURE sp_consultar_contas_por_cliente (
    IN p_cliente_id INT
)
BEGIN
    SELECT * FROM Contas
    WHERE cliente_id = p_cliente_id;
END $$
DELIMITER ;

-- Procedimento para depósito em conta
DROP PROCEDURE IF EXISTS sp_deposito_conta;

DELIMITER $$
CREATE PROCEDURE sp_deposito_conta (
    IN p_conta_id INT,
    IN p_valor DECIMAL(15,2)
)
BEGIN
    UPDATE Contas
    SET saldo = saldo + p_valor
    WHERE id = p_conta_id;
END $$
DELIMITER ;

-- Procedimento para saque em conta
DROP PROCEDURE IF EXISTS sp_saque_conta;

DELIMITER $$
CREATE PROCEDURE sp_saque_conta (
    IN p_conta_id INT,
    IN p_valor DECIMAL(15,2)
)
BEGIN
    UPDATE Contas
    SET saldo = saldo - p_valor
    WHERE id = p_conta_id;
END $$
DELIMITER ;
