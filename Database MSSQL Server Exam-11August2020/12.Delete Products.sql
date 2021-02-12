--PROBLEM 12

/*create table DeletedProducts
(
    Id int identity primary key,
    Name nvarchar(25) not null unique,
    Description nvarchar(250),
    Recipe nvarchar(max)  not null,
    Price decimal(15, 2) not null
    CHECK ([Price] >= 0)
)*/

CREATE TRIGGER dbo.ProductsToDelete
    ON Products
    INSTEAD OF DELETE
    AS
BEGIN
    DECLARE
        @deletedProductId INT = (SELECT p.Id
                                 FROM Products AS p
                                 JOIN deleted AS d ON d.Id = p.Id)
    DELETE
    FROM ProductsIngredients
    WHERE ProductId = @deletedProductId
    DELETE
    FROM Feedbacks
    WHERE ProductId = @deletedProductId
    DELETE
    FROM Products
    WHERE Id = @deletedProductId
END