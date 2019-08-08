CREATE TABLE ProfilesCustomFields(
    ProfileId BIGINT NOT NULL,
	CustomFieldId BIGINT NOT NULL,
	Value NVARCHAR(MAX) NULL,
    ModifiedDate DATETIMEOFFSET NOT NULL DEFAULT (GETUTCDATE()) 
) ON [PRIMARY];

--------- PRIMARY KEY, FOREIGN KEY
GO

ALTER TABLE ProfilesCustomFields ADD 
    CONSTRAINT PK_ProfilesCustomFields_ProfileId_CustomFieldId PRIMARY KEY 
    (
        ProfileId,
        CustomFieldId
    )  ON [PRIMARY];

GO

ALTER TABLE ProfilesCustomFields ADD 
    CONSTRAINT FK_ProfilesCustomFields_Profiles_ProfileId FOREIGN KEY 
    (
        ProfileId
    ) REFERENCES Profiles(
        ProfileId
    );

GO

ALTER TABLE ProfilesCustomFields ADD 
	CONSTRAINT FK_ProfilesCustomFields_CustomFields_CustomFieldId FOREIGN KEY 
    (
        CustomFieldId
    ) REFERENCES CustomFields(
        CustomFieldId
    );