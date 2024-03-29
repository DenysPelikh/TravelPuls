﻿CREATE TABLE [dbo].[Points]
(
	[Id] BIGINT IDENTITY (1, 1) NOT NULL,
	[RouteId] INT NOT NULL,
	[PreviousId] BIGINT,
	[Latitude] FLOAT NOT NULL,
	[Longitude] FLOAT NOT NULL,
	CONSTRAINT [PK_Points] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_Points_PreviousId] FOREIGN KEY ([PreviousId]) REFERENCES Points([Id])
) ON [PRIMARY];