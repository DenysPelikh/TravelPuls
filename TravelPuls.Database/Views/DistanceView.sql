CREATE VIEW [dbo].[DistanceView]
AS
	WITH CTE_Points_Destination
	AS (
		select P1.Id
		from [dbo].[Points] as P1
		left join [dbo].[Points] as P2 on P1.Id = P2.PreviousId
		where P2.Id IS NULL
	),

	CTE_Points_Branch
	AS (
		SELECT 
			P1.Id as 'P1',
			P2.Id as 'P2',
			P1.PreviousId as 'P1.PreviousId',
			P2.PreviousId as 'P2.PreviousId',
			row_number() over (order by P1.Id) as Branch,
			0 as order_level,
			P1.RouteId,
			dbo.[EuclideanDistance](P1.Latitude, P1.Longitude, P2.Latitude, P2.Longitude) as Distance
		FROM [dbo].[Points] as P1
			inner join [dbo].[Points] as P2 on P1.Id = P2.PreviousId and  P1.RouteId = P2.RouteId
			inner join CTE_Points_Destination as Destinations on Destinations.Id = P2.Id
		UNION ALL
		SELECT 
			P1.Id as 'P1',
			P2.Id as 'P2',
			P1.PreviousId as 'P1.PreviousId',
			P2.PreviousId as 'P2.PreviousId',
			Branch,
			order_level + 1 as order_level,
			P1.RouteId,
		[dbo].[EuclideanDistance](P1.Latitude, P1.Longitude, P2.Latitude, P2.Longitude) as Distance
		FROM [dbo].[Points] as P1
			inner join [dbo].[Points] as P2 on P1.Id = P2.PreviousId and P1.RouteId = P2.RouteId
			inner join CTE_Points_Branch as CTE on CTE.P1 = P2.Id
	)

	SELECT Branch, RouteId, MIN(P1) as StartPointId, MAX(P2) as EndPointId, 
	Sum(Distance) as Distance
	FROM CTE_Points_Branch
	GROUP BY Branch, RouteId
