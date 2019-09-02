CREATE FUNCTION [dbo].[EuclideanDistance]
(
	@x1 float,
	@y1 float,
	@x2 float,
	@y2 float
)
RETURNS float WITH SCHEMABINDING
AS BEGIN
    DECLARE @Result float

    SET @Result = ROUND(SQRT(POWER(@x1 - @x2, 2) + POWER(@y1 - @y2, 2)), 2)

    RETURN @Result
END