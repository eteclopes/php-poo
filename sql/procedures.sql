USE sistema_bancario;
--criando procedures para clientes pessoa fisica 
DROP PROCEDURE IF EXISTS clientePF_cadastrar;

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS clientePF_cadastrar (
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

    SET @last_id = LAST_INSERT_ID();

    INSERT INTO Clientes_PF (cliente_id, cpf, data_nascimento)
    VALUES (@last_id, p_cpf, p_data_nascimento);

    COMMIT;
END $$

DELIMITER ;

--criando procedures para alterar clientes pessoa fisica
DROP PROCEDURE IF EXISTS clientePF_alterar;
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS clientePF_alterar (
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

    UPDATE Clientes SET
        nome = p_nome,
        email = p_email,
        telefone = p_telefone,
        endereco = p_endereco,
        username = p_username,
        password = p_password
    WHERE id = p_id;

    UPDATE Clientes_PF SET
        cpf = p_cpf,
        data_nascimento = p_data_nascimento
    WHERE cliente_id = p_id;

    COMMIT;

    END$$
    DELIMITER ;

--criando procedures para deletar clientes pessoa fisica
   
   DROP PROCEDURE IF EXISTS clientePF_deletar;
    DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS clientePF_deletar (
    IN p_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    DELIMITER ;

---criando procedures para consultar clientes pessoa fisica por nome

    DROP PROCEDURE IF EXISTS clientePF_consultarpornome;

    DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS clientePF_consultarpornome (
    IN p_nome VARCHAR(100)  
)
BEGIN
    SELECT * FROM Clientes
    WHERE nome LIKE CONCAT('%', p_nome, '%');
END $$  
DELIMITER ;

--criando proceures para consultar por razao social 

    DROP PROCEDURE IF EXISTS clientePF_consultarporrazaosocial;

    DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS clientePF_consultarporrazaosocial (
    IN p_razao_social VARCHAR(100)  
)
BEGIN
    SELECT c.*, pf.cpf, pf.data_nascimento
    FROM Clientes c
    JOIN Clientes_PF pf ON c.id = pf.cliente_id
    WHERE pf.razao_social LIKE CONCAT('%', p_razao_social, '%');
END $$  
DELIMITER ;

----criando procedures para consultar por cpf

DROP PROCEDURE IF EXISTS clientePF_consultarporcpf; 
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS clientePF_consultarporcpf (
    IN p_cpf VARCHAR(14)  
)
BEGIN
    SELECT c.*, pf.cpf, pf.data_nascimento
    FROM Clientes c
    JOIN Clientes_PF pf ON c.id = pf.cliente_id
    WHERE pf.cpf = p_cpf;
END $$  
DELIMITER ;

--criando procedures para consultar por id 
DROP PROCEDURE IF EXISTS clientePF_consultarporid; 
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS clientePF_consultarporid (
    IN p_id INT  
)
BEGIN
    SELECT c.*, pf.cpf, pf.data_nascimento
    FROM Clientes c
    JOIN Clientes_PF pf ON c.id = pf.cliente_id
    WHERE c.id = p_id;
END $$  
DELIMITER ;

--consultar por email 
DROP PROCEDURE IF EXISTS clientePF_consultarporemail; 
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS clientePF_consultarporemail (
    IN p_email VARCHAR(100)  
)
BEGIN
    SELECT c.*, pf.cpf, pf.data_nascimento
    FROM Clientes c
    JOIN Clientes_PF pf ON c.id = pf.cliente_id
    WHERE c.email = p_email;
END $$  
DELIMITER ;




















---criando procedures para clientes pessoa juridica
DROP PROCEDURE IF EXISTS clientePJ_cadastrar;

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS clientePJ_cadastrar (
    IN p_id INT ,
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
    SET @last_id = LAST_INSERT_ID();
    INSERT INTO Clientes_PJ (cliente_id, cnpj, razao_social)
    VALUES (@last_id, p_cnpj, p_razao_social);
    COMMIT;
END $$

DELIMITER ;

--criando procedures para alterar clientes pessoa juridica
DROP PROCEDURE IF EXISTS clientePJ_alterar;
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS clientePJ_alterar (
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
    UPDATE Clientes SET
        nome = p_nome,
        email = p_email,
        telefone = p_telefone,      
        endereco = p_endereco,
        username = p_username,
        password = p_password
    WHERE id = p_id;
    UPDATE Clientes_PJ SET
        cnpj = p_cnpj,
        razao_social = p_razao_social
    WHERE cliente_id = p_id;
    COMMIT;
END$$
DELIMITER ;

--criando procedures para deletar clientes pessoa juridica

    DROP PROCEDURE IF EXISTS clientePJ_deletar;
     DELIMITER $$       
    CREATE PROCEDURE IF NOT EXISTS clientePJ_deletar (
        IN p_id INT
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
        END;
        DELIMITER ;

--criando procedures para consultar clientes pessoa juridica por nome 

    DROP PROCEDURE IF EXISTS clientePJ_consultarpornome;

    DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS clientePJ_consultarpornome (
    IN p_nome VARCHAR(100)  
)
BEGIN
    SELECT * FROM Clientes
    WHERE nome LIKE CONCAT('%', p_nome, '%');
END $$  
DELIMITER ; 

--criando procedures para consultar clientes pessoa juridica por razao social 

    DROP PROCEDURE IF EXISTS clientePJ_consultarporrazaosocial;

    DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS clientePJ_consultarporrazaosocial (
    IN p_razao_social VARCHAR(100)  
)
BEGIN
    SELECT c.*, pj.cnpj, pj.razao_social
    FROM Clientes c
    JOIN Clientes_PJ pj ON c.id = pj.cliente_id
    WHERE pj.razao_social LIKE CONCAT('%', p_razao_social, '%');
END $$  
DELIMITER ;

----criando procedures para consultar por cnpj
DROP PROCEDURE IF EXISTS clientePJ_consultarporcnpj; 
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS clientePJ_consultarporcnpj (
    IN p_cnpj VARCHAR(18)  
)
BEGIN
    SELECT c.*, pj.cnpj, pj.razao_social
    FROM Clientes c
    JOIN Clientes_PJ pj ON c.id = pj.cliente_id
    WHERE pj.cnpj = p_cnpj;
END $$  
DELIMITER ;

--criando procedures para consultar por id 

DROP PROCEDURE IF EXISTS clientePJ_consultarporid; 
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS clientePJ_consultarporid (
    IN p_id INT  
)
BEGIN
    SELECT c.*, pj.cnpj, pj.razao_social
    FROM Clientes c
    JOIN Clientes_PJ pj ON c.id = pj.cliente_id
    WHERE c.id = p_id;
END $$  
DELIMITER ; 

--consultar por email 

DROP PROCEDURE IF EXISTS clientePJ_consultarporemail; 
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS clientePJ_consultarporemail (
    IN p_email VARCHAR(100) 
)  
BEGIN
    SELECT c.*, pj.cnpj, pj.razao_social
    FROM Clientes c
    JOIN Clientes_PJ pj ON c.id = pj.cliente_id
    WHERE c.email = p_email;
END $$  
DELIMITER ; 











--criando procedures para conta 
DROP PROCEDURE IF EXISTS conta_criar;
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS conta_criar (
    IN p_cliente_id INT,
    IN p_tipo_conta VARCHAR(20),
    IN p_saldo DECIMAL(15,2) 
)
BEGIN
    INSERT INTO Contas (cliente_id, tipo_conta, saldo)
    VALUES (p_cliente_id, p_tipo_conta, p_saldo);
END $$  
DELIMITER ;

--criando procedure para alterar conta

DROP PROCEDURE IF EXISTS conta_alterar;
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS conta_alterar (
    IN p_id INT,
    IN p_tipo_conta VARCHAR(20),
    IN p_saldo DECIMAL(15,2) 
)
BEGIN
    UPDATE Contas SET
        tipo_conta = p_tipo_conta,
        saldo = p_saldo
    WHERE id = p_id;
END $$  
DELIMITER ; 

--criando procedure para deletar conta

DROP PROCEDURE IF EXISTS conta_deletar;
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS conta_deletar (
    IN p_id INT
)
BEGIN
    DELETE FROM Contas
    WHERE id = p_id;
END $$  
DELIMITER ;

--criando procedure para consultar conta por id

DROP PROCEDURE IF EXISTS conta_consultarporid;
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS conta_consultarporid (
    IN p_id INT
)
BEGIN
    SELECT * FROM Contas
    WHERE id = p_id;
END $$  
DELIMITER ;

--criando procedure para consultar conta por cliente_id
DROP PROCEDURE IF EXISTS conta_consultarporclienteid;
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS conta_consultarporclienteid (
    IN p_cliente_id INT
)
BEGIN
    SELECT * FROM Contas
    WHERE cliente_id = p_cliente_id;
END $$  
DELIMITER ;

--criando procedure conta-transacao-deposito

DROP PROCEDURE IF EXISTS conta_transacao_deposito;
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS conta_transacao_deposito (
    IN p_conta_id INT,
    IN p_valor DECIMAL(15,2)
)
BEGIN
    UPDATE Contas
    SET saldo = saldo + p_valor
    WHERE id = p_conta_id;
END $$  
DELIMITER ;

--criando procedure conta-transacao-saque

DROP PROCEDURE IF EXISTS conta_transacao_saque;
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS conta_transacao_saque (
    IN p_conta_id INT,
    IN p_valor DECIMAL(15,2)
)
BEGIN
    UPDATE Contas
    SET saldo = saldo - p_valor
    WHERE id = p_conta_id;
END $$  
DELIMITER ; 

