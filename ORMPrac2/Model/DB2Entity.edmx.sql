
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 10/14/2021 20:12:50
-- Generated from EDMX file: C:\Users\USER\Documents\Visual Studio 2019\prac1\ORMPrac2\Model\DB2Entity.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [DB2];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_AGENTSORDERS]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ORDERS] DROP CONSTRAINT [FK_AGENTSORDERS];
GO
IF OBJECT_ID(N'[dbo].[FK_AGENTSCUSTOMER]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CUSTOMER] DROP CONSTRAINT [FK_AGENTSCUSTOMER];
GO
IF OBJECT_ID(N'[dbo].[FK_CUSTOMERORDERS]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ORDERS] DROP CONSTRAINT [FK_CUSTOMERORDERS];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[AGENTS]', 'U') IS NOT NULL
    DROP TABLE [dbo].[AGENTS];
GO
IF OBJECT_ID(N'[dbo].[ORDERS]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ORDERS];
GO
IF OBJECT_ID(N'[dbo].[CUSTOMER]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CUSTOMER];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'AGENTS'
CREATE TABLE [dbo].[AGENTS] (
    [AGENT_CODE] int  NOT NULL,
    [AGENT_NAME] nvarchar(max)  NOT NULL,
    [WORKING_AREA] nvarchar(max)  NOT NULL,
    [COMISSION] decimal(18,3)  NOT NULL,
    [PHONE_NO] nvarchar(max)  NOT NULL,
    [COUNTRY] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'ORDERS'
CREATE TABLE [dbo].[ORDERS] (
    [ORD_NUM] int  NOT NULL,
    [ORD_AMOUNT] decimal(18,3)  NOT NULL,
    [ADVANCE_AMOUNT] decimal(18,3)  NOT NULL,
    [ORD_DATE] datetime  NOT NULL,
    [ORD_DESCRIPTION] nvarchar(max)  NOT NULL,
    [AGENT_CODE] nvarchar(max)  NOT NULL,
    [CUST_CODE] nvarchar(max)  NOT NULL,
    [CUSTOMERCUST_CODE] int  NOT NULL,
    [AGENTSAGENT_CODE] int  NOT NULL
);
GO

-- Creating table 'CUSTOMER'
CREATE TABLE [dbo].[CUSTOMER] (
    [CUST_CODE] int  NOT NULL,
    [CUST_NAME] nvarchar(max)  NOT NULL,
    [CUST_CITY] nvarchar(max)  NOT NULL,
    [WORKING_AREA] nvarchar(max)  NOT NULL,
    [CUST_COUNTRY] nvarchar(max)  NOT NULL,
    [GRADE] int  NOT NULL,
    [OPENING_AMT] decimal(18,3)  NOT NULL,
    [RECEIVE_AMT] decimal(18,3)  NOT NULL,
    [PAYMENT_AMT] decimal(18,3)  NOT NULL,
    [OUTSTANDING_AMT] decimal(18,3)  NOT NULL,
    [PHONE_NO] nvarchar(max)  NOT NULL,
    [AGENTS_CODE] nvarchar(max)  NOT NULL,
    [AGENTSAGENT_CODE] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [AGENT_CODE] in table 'AGENTS'
ALTER TABLE [dbo].[AGENTS]
ADD CONSTRAINT [PK_AGENTS]
    PRIMARY KEY CLUSTERED ([AGENT_CODE] ASC);
GO

-- Creating primary key on [ORD_NUM] in table 'ORDERS'
ALTER TABLE [dbo].[ORDERS]
ADD CONSTRAINT [PK_ORDERS]
    PRIMARY KEY CLUSTERED ([ORD_NUM] ASC);
GO

-- Creating primary key on [CUST_CODE] in table 'CUSTOMER'
ALTER TABLE [dbo].[CUSTOMER]
ADD CONSTRAINT [PK_CUSTOMER]
    PRIMARY KEY CLUSTERED ([CUST_CODE] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [AGENTSAGENT_CODE] in table 'CUSTOMER'
ALTER TABLE [dbo].[CUSTOMER]
ADD CONSTRAINT [FK_AGENTSCUSTOMER]
    FOREIGN KEY ([AGENTSAGENT_CODE])
    REFERENCES [dbo].[AGENTS]
        ([AGENT_CODE])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_AGENTSCUSTOMER'
CREATE INDEX [IX_FK_AGENTSCUSTOMER]
ON [dbo].[CUSTOMER]
    ([AGENTSAGENT_CODE]);
GO

-- Creating foreign key on [CUSTOMERCUST_CODE] in table 'ORDERS'
ALTER TABLE [dbo].[ORDERS]
ADD CONSTRAINT [FK_CUSTOMERORDERS]
    FOREIGN KEY ([CUSTOMERCUST_CODE])
    REFERENCES [dbo].[CUSTOMER]
        ([CUST_CODE])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_CUSTOMERORDERS'
CREATE INDEX [IX_FK_CUSTOMERORDERS]
ON [dbo].[ORDERS]
    ([CUSTOMERCUST_CODE]);
GO

-- Creating foreign key on [AGENTSAGENT_CODE] in table 'ORDERS'
ALTER TABLE [dbo].[ORDERS]
ADD CONSTRAINT [FK_AGENTSORDERS]
    FOREIGN KEY ([AGENTSAGENT_CODE])
    REFERENCES [dbo].[AGENTS]
        ([AGENT_CODE])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_AGENTSORDERS'
CREATE INDEX [IX_FK_AGENTSORDERS]
ON [dbo].[ORDERS]
    ([AGENTSAGENT_CODE]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------