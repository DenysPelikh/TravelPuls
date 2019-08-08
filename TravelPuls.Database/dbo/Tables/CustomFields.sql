﻿CREATE TABLE CustomFields(
    CustomFieldId BIGINT IDENTITY (1, 1) NOT NULL PRIMARY KEY,
    Name Name NOT NULL, 
    ModifiedDate DATETIMEOFFSET NOT NULL DEFAULT (GETUTCDATE()) 
) ON [PRIMARY];