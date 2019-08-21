PRINT N'Start seeding Point test date';
GO

SET IDENTITY_INSERT Points ON;
GO

-- Point test data
;
WITH [PointTestDataCTE]
AS (
	select *
	from
		(values
			( 1, 1, null, 1, 2),
			( 2, 1, 3, 1, 5),
			( 6, 1, 4, 1, 2),
			( 3, 1, 1, 1, 7),
			( 7, 1, 6, 1, 15),
			( 8, 1, 6, 1, 4),
			( 9, 1, 2, 1, 14),
			( 4, 1, 2, 1, 10)
		) as x([Id], [RouteId], [PreviousId], [Latitude], [Longitude])
)

MERGE INTO [dbo].[Points] as T_Base
USING [PointTestDataCTE] as T_Source ON T_Base.[Id] = T_Source.[Id]
WHEN MATCHED AND (
	T_Base.[RouteId] <> T_Source.[RouteId]
	OR T_Base.[PreviousId] <> T_Source.[PreviousId]
	OR T_Base.[Latitude] <> T_Source.[Latitude]
	OR T_Base.[Longitude] <> T_Source.[Longitude]
) THEN 
	UPDATE SET [RouteId] = T_Source.[RouteId],
				[PreviousId] = T_Source.[PreviousId],
				[Latitude] = T_Source.[Latitude],
				[Longitude] = T_Source.[Longitude]
WHEN NOT MATCHED BY TARGET THEN 
	INSERT
        (
			[Id],
            [RouteId],
            [PreviousId],
            [Latitude],
            [Longitude]
        )
	VALUES 
		(
			[Id],
            [RouteId],
            [PreviousId],
            [Latitude],
            [Longitude]
		)
OUTPUT $action AS [Action],
		Inserted.*,
        Deleted.*
;

SET IDENTITY_INSERT Points OFF;
GO

PRINT N'Finish seeding Point test date';
GO