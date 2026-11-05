DROP TABLE IF EXISTS Pedido;

CREATE TABLE Pedido (
    id           INT AUTO_INCREMENT,
    cliente      VARCHAR(100) NOT NULL,
    item         VARCHAR(100) NOT NULL,
    quantidade   INT NOT NULL,
    status       VARCHAR(20) NOT NULL,  -- 'pendente', 'preparando', 'pronto', 'entregue'
    observacao   VARCHAR(200),
    PRIMARY KEY (id)
);

INSERT INTO Pedido (id, cliente, item, quantidade, status, observacao) VALUES
(1, 'Marcos Silva',     'pao frances',        20, 'pendente',   NULL),
(2, 'Ana Souza',        'bolo de chocolate',   1, 'pendente',   NULL),
(3, 'Carlos Pereira',   'croissant',           6, 'preparando', NULL),
(4, 'Juliana Lima',     'pao de queijo',      12, 'pronto',     NULL),
(5, 'Ana Souza',        'torta de morango',    1, 'pendente',   NULL),
(6, 'Roberto Alves',    'baguete',             3, 'entregue',   NULL);

UPDATE Pedido
SET status = 'pronto'
WHERE id = 3;

UPDATE Pedido
SET observacao = 'cliente vai retirar às 18h'
WHERE cliente = 'Ana Souza'
AND status = 'pendente';

UPDATE Pedido
SET status = CASE status
WHEN 'preparando' THEN 'pronto'
WHEN 'pronto' THEN 'entregue'
ELSE status
END
WHERE status IN ('preparando', 'pronto');

UPDATE Pedido
SET observacao = CONCAT(IFNULL(observacao, ''), ' - pedido grande')
WHERE id IN (
SELECT id FROM (
SELECT id FROM Pedido WHERE quantidade > 10
) AS subquery_temp
);

SELECT * FROM Pedido;