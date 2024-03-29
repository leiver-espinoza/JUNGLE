USE [master]
GO
/****** Object:  Database [JUNGLE]    Script Date: 5/4/2023 7:17:32 AM ******/
CREATE DATABASE [JUNGLE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'JUNGLE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\JUNGLE.mdf' , SIZE = 1253376KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'JUNGLE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\JUNGLE_log.ldf' , SIZE = 3940352KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [JUNGLE] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [JUNGLE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [JUNGLE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [JUNGLE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [JUNGLE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [JUNGLE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [JUNGLE] SET ARITHABORT OFF 
GO
ALTER DATABASE [JUNGLE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [JUNGLE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [JUNGLE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [JUNGLE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [JUNGLE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [JUNGLE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [JUNGLE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [JUNGLE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [JUNGLE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [JUNGLE] SET  ENABLE_BROKER 
GO
ALTER DATABASE [JUNGLE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [JUNGLE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [JUNGLE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [JUNGLE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [JUNGLE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [JUNGLE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [JUNGLE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [JUNGLE] SET RECOVERY FULL 
GO
ALTER DATABASE [JUNGLE] SET  MULTI_USER 
GO
ALTER DATABASE [JUNGLE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [JUNGLE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [JUNGLE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [JUNGLE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [JUNGLE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [JUNGLE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'JUNGLE', N'ON'
GO
ALTER DATABASE [JUNGLE] SET QUERY_STORE = ON
GO
ALTER DATABASE [JUNGLE] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [JUNGLE]
GO
/****** Object:  User [JungleAPI]    Script Date: 5/4/2023 7:17:32 AM ******/
CREATE USER [JungleAPI] FOR LOGIN [JungleAPI] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [JungleAPI]
GO
ALTER ROLE [db_datareader] ADD MEMBER [JungleAPI]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [JungleAPI]
GO
/****** Object:  Table [dbo].[tbl_indicators_client_config]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_indicators_client_config](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[client_id] [int] NOT NULL,
	[indicator_id] [int] NOT NULL,
	[interval_seconds] [int] NOT NULL,
	[enabled] [bit] NOT NULL,
	[threshold_l4] [decimal](22, 2) NULL,
	[threshold_l3] [decimal](22, 2) NULL,
	[threshold_l2] [decimal](22, 2) NULL,
	[threshold_l1] [decimal](22, 2) NULL,
	[created_at] [datetime] NOT NULL,
	[update_at] [datetime] NULL,
 CONSTRAINT [PK__tbl_indi__3213E83F574BA4C5] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_clients]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_clients](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[mac_address] [varchar](17) NOT NULL,
	[netbios_name] [varchar](16) NOT NULL,
	[friendly_name] [varchar](50) NOT NULL,
	[push_updates] [bit] NOT NULL,
	[version] [int] NOT NULL,
	[enabled] [bit] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[update_at] [datetime] NULL,
 CONSTRAINT [PK__tbl_clie__3213E83F356F1054] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__tbl_clie__11B29C93391D1F2E] UNIQUE NONCLUSTERED 
(
	[mac_address] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_stats]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_stats](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[client_mac_address] [varchar](17) NOT NULL,
	[indicator_key] [varchar](30) NOT NULL,
	[ipaddress] [varchar](16) NOT NULL,
	[value] [varchar](25) NOT NULL,
	[reported_datetime] [datetime] NOT NULL,
 CONSTRAINT [PK__tbl_stat__3213E83FD13BB8DB] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_indicators]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_indicators](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[indicator_key] [varchar](30) NOT NULL,
	[higher_the_best] [bit] NULL,
	[description] [varchar](150) NOT NULL,
	[sort_order] [int] NOT NULL,
	[enabled] [bit] NOT NULL,
	[casting_type_id] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[update_at] [datetime] NULL,
 CONSTRAINT [PK__tbl_indi__3213E83FFB35F198] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__tbl_indi__2B3B212BD91C2F66] UNIQUE NONCLUSTERED 
(
	[indicator_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__tbl_indi__72AFBCC66A0AD54F] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_get_stats_last_status]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_get_stats_last_status] (@hours FLOAT)
RETURNS TABLE
AS
RETURN (
	SELECT
		Main_Table.[Client ID]
		, Main_Table.[Indicator name]
		, Main_Table.[Indicator Key]
		, 'T0' AS 'Status'
		, Main_Table.[Friendly Name]
		, Main_Table.sort_order AS 'Indicator Order'
		, Main_Table.Hostname
		, Main_Table.[Last Report]
		, Specific_Stats.ipaddress AS 'IP Address'
		, Main_Table.id AS 'Configuration ID'
		, Main_Table.[Last ID] AS 'Value ID'
		, Main_Table.higher_the_best AS 'HTB'
		, Specific_Stats.value AS 'Value'
		, Main_Table.threshold_l4 AS 'T4'
		, Main_Table.threshold_l3 AS 'T3'
		, Main_Table.threshold_l2 AS 'T2'
		, Main_Table.threshold_l1 AS 'T1'
	FROM (
		SELECT
			Clients.id as 'Client ID'
			, Indicators.name AS 'Indicator name'
			, indicators.indicator_key AS 'Indicator Key'
			, Clients.friendly_name AS 'Friendly Name'
			, Clients.netbios_name AS 'Hostname'
			, MAX(Reported_Stats.reported_datetime) AS 'Last Report'
			, MAX(Reported_Stats.id) AS 'Last ID'
			, Configs.threshold_l4
			, Configs.threshold_l3
			, Configs.threshold_l2
			, Configs.threshold_l1
			, Configs.id
			, Indicators.higher_the_best
			, Indicators.sort_order
			--, Indicators.*
			--, Configs.*
		FROM tbl_indicators_client_config AS Configs
			LEFT JOIN tbl_indicators AS Indicators ON Configs.indicator_id = Indicators.id
			LEFT JOIN tbl_clients AS Clients ON Clients.id = Configs.client_id
			LEFT JOIN tbl_stats AS Reported_Stats ON Reported_Stats.client_mac_address = Clients.mac_address AND Reported_Stats.indicator_key = Indicators.indicator_key
		WHERE
			Indicators.higher_the_best IS NULL
			AND Indicators.enabled = 1
			AND Configs.enabled = 1
			AND Reported_Stats.reported_datetime >= DATEADD(Hour, @hours*-1, GETDATE())
		GROUP BY
			Clients.id
			, Indicators.name
			, indicators.indicator_key
			, Clients.friendly_name
			, Clients.netbios_name
			, Configs.threshold_l4
			, Configs.threshold_l3
			, Configs.threshold_l2
			, Configs.threshold_l1
			, Configs.id
			, Indicators.higher_the_best
			, Indicators.sort_order
	) AS Main_Table
		LEFT JOIN (SELECT id, ipaddress, value FROM tbl_stats) AS Specific_Stats ON Specific_Stats.id = Main_Table.[Last ID]
	UNION
	SELECT
		Main_Table.[Client ID]
		, Main_Table.[Indicator name]
		, Main_Table.[Indicator Key]
		, CASE
			WHEN threshold_l4 IS NULL OR threshold_l3 IS NULL OR threshold_l2 IS NULL OR threshold_l1 IS NULL THEN 'T0'
			WHEN Specific_Stats.value > threshold_l4 THEN 'T0'
			WHEN Specific_Stats.value < threshold_l1 THEN 'T1'
			WHEN (threshold_l4 <= Specific_Stats.value) AND (Specific_Stats.value < threshold_l3) THEN 'T4'
			WHEN (threshold_l3 <= Specific_Stats.value) AND (Specific_Stats.value < threshold_l2) THEN 'T3'
			WHEN (threshold_l2 <= Specific_Stats.value) AND (Specific_Stats.value < threshold_l1) THEN 'T2'
			ELSE 'T0'
		END AS 'Status'
		, Main_Table.[Friendly Name]
		, Main_Table.sort_order AS 'Indicator Order'
		, Main_Table.Hostname
		, Main_Table.[Last Report]
		, Specific_Stats.ipaddress AS 'IP Address'
		, Main_Table.id AS 'Configuration ID'
		, Main_Table.[Last ID] AS 'Value ID'
		, Main_Table.higher_the_best AS 'HTB'
		, Specific_Stats.value AS 'Value'
		, Main_Table.threshold_l4 AS 'T4'
		, Main_Table.threshold_l3 AS 'T3'
		, Main_Table.threshold_l2 AS 'T2'
		, Main_Table.threshold_l1 AS 'T1'
	FROM (
		SELECT
			Clients.id as 'Client ID'
			, Indicators.name AS 'Indicator name'
			, indicators.indicator_key AS 'Indicator Key'
			, Clients.friendly_name AS 'Friendly Name'
			, Clients.netbios_name AS 'Hostname'
			, MAX(Reported_Stats.reported_datetime) AS 'Last Report'
			, MAX(Reported_Stats.id) AS 'Last ID'
			, Configs.threshold_l4
			, Configs.threshold_l3
			, Configs.threshold_l2
			, Configs.threshold_l1
			, Configs.id
			, Indicators.higher_the_best
			, Indicators.sort_order
			--, Indicators.*
			--, Configs.*
		FROM tbl_indicators_client_config AS Configs
			LEFT JOIN tbl_indicators AS Indicators ON Configs.indicator_id = Indicators.id
			LEFT JOIN tbl_clients AS Clients ON Clients.id = Configs.client_id
			LEFT JOIN tbl_stats AS Reported_Stats ON Reported_Stats.client_mac_address = Clients.mac_address AND Reported_Stats.indicator_key = Indicators.indicator_key
		WHERE
			Indicators.higher_the_best = 1
			AND Indicators.enabled = 1
			AND Configs.enabled = 1
			AND Reported_Stats.reported_datetime >= DATEADD(Hour, @hours*-1, GETDATE())
		GROUP BY
			Clients.id
			, Indicators.name
			, indicators.indicator_key
			, Clients.friendly_name
			, Clients.netbios_name
			, Configs.threshold_l4
			, Configs.threshold_l3
			, Configs.threshold_l2
			, Configs.threshold_l1
			, Configs.id
			, Indicators.higher_the_best
			, Indicators.sort_order
	) AS Main_Table
		LEFT JOIN (SELECT id, ipaddress, value FROM tbl_stats) AS Specific_Stats ON Specific_Stats.id = Main_Table.[Last ID]
	UNION
	SELECT
		Main_Table.[Client ID]
		, Main_Table.[Indicator name]
		, Main_Table.[Indicator Key]
		, CASE
			WHEN threshold_l4 IS NULL OR threshold_l3 IS NULL OR threshold_l2 IS NULL OR threshold_l1 IS NULL THEN 'T0'
			WHEN Specific_Stats.value < threshold_l4 THEN 'T0'
			WHEN Specific_Stats.value >= threshold_l1 THEN 'T1'
			WHEN (threshold_l4 <= Specific_Stats.value) AND (Specific_Stats.value < threshold_l3) THEN 'T4'
			WHEN (threshold_l3 <= Specific_Stats.value) AND (Specific_Stats.value < threshold_l2) THEN 'T3'
			WHEN (threshold_l2 <= Specific_Stats.value) AND (Specific_Stats.value < threshold_l1) THEN 'T2'
			ELSE 'T0'
		END AS 'Status'
		, Main_Table.[Friendly Name]
		, Main_Table.sort_order AS 'Indicator Order'
		, Main_Table.Hostname
		, Main_Table.[Last Report]
		, Specific_Stats.ipaddress AS 'IP Address'
		, Main_Table.id AS 'Configuration ID'
		, Main_Table.[Last ID] AS 'Value ID'
		, Main_Table.higher_the_best AS 'HTB'
		, Specific_Stats.value AS 'Value'
		, Main_Table.threshold_l4 AS 'T4'
		, Main_Table.threshold_l3 AS 'T3'
		, Main_Table.threshold_l2 AS 'T2'
		, Main_Table.threshold_l1 AS 'T1'
	FROM (
		SELECT
			Clients.id as 'Client ID'
			, Indicators.name AS 'Indicator name'
			, indicators.indicator_key AS 'Indicator Key'
			, Clients.friendly_name AS 'Friendly Name'
			, Clients.netbios_name AS 'Hostname'
			, MAX(Reported_Stats.reported_datetime) AS 'Last Report'
			, MAX(Reported_Stats.id) AS 'Last ID'
			, Configs.threshold_l4
			, Configs.threshold_l3
			, Configs.threshold_l2
			, Configs.threshold_l1
			, Configs.id
			, Indicators.higher_the_best
			, Indicators.sort_order
			--, Indicators.*
			--, Configs.*
		FROM tbl_indicators_client_config AS Configs
			LEFT JOIN tbl_indicators AS Indicators ON Configs.indicator_id = Indicators.id
			LEFT JOIN tbl_clients AS Clients ON Clients.id = Configs.client_id
			LEFT JOIN tbl_stats AS Reported_Stats ON Reported_Stats.client_mac_address = Clients.mac_address AND Reported_Stats.indicator_key = Indicators.indicator_key
		WHERE
			Indicators.higher_the_best = 0
			AND Indicators.enabled = 1
			AND Configs.enabled = 1
			AND Reported_Stats.reported_datetime >= DATEADD(Hour, @hours*-1, GETDATE())
		GROUP BY
			Clients.id
			, Indicators.name
			, indicators.indicator_key
			, Clients.friendly_name
			, Clients.netbios_name
			, Configs.threshold_l4
			, Configs.threshold_l3
			, Configs.threshold_l2
			, Configs.threshold_l1
			, Configs.id
			, Indicators.higher_the_best
			, Indicators.sort_order
	) AS Main_Table
		LEFT JOIN (SELECT id, ipaddress, value FROM tbl_stats) AS Specific_Stats ON Specific_Stats.id = Main_Table.[Last ID]
	--ORDER BY
	--	[Friendly Name]
	--	, [Indicator Order]
);
GO
/****** Object:  Table [dbo].[tbl_role_has_permissions]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_role_has_permissions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL,
 CONSTRAINT [PK_tbl_role_has_permissions] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC,
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_routes]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_routes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[display_order] [int] NOT NULL,
	[enabled] [bit] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[update_at] [datetime] NULL,
 CONSTRAINT [PK__tbl_rout__3213E83F508F9FDF] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__tbl_rout__1B16645E486D9117] UNIQUE NONCLUSTERED 
(
	[display_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__tbl_rout__75E3EFCFAD3B77E2] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_user_has_roles]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_user_has_roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[role_id] [int] NOT NULL,
 CONSTRAINT [PK__tbl_user__6EDEA153FE3B2609] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__tbl_user__3213E83EEBA0786E] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_users]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name_first] [varchar](25) NOT NULL,
	[name_last] [varchar](25) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[username] [varchar](15) NOT NULL,
	[password] [binary](64) NOT NULL,
	[enabled] [bit] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_user_has_permissions]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_user_has_permissions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL,
 CONSTRAINT [PK_tbl_user_has_permissions] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sessions]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sessions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[token_value] [varchar](36) NOT NULL,
	[enabled] [bit] NOT NULL,
	[created_at] [datetime] NOT NULL,
 CONSTRAINT [PK__tbl_sess__3213E83F0C7600C9] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__tbl_sess__728CF2F9B17CFE3B] UNIQUE NONCLUSTERED 
(
	[token_value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_roles]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](25) NOT NULL,
	[guard_name] [varchar](25) NOT NULL,
	[display_order] [int] NOT NULL,
	[enabled] [bit] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[update_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[display_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[guard_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_permissions]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_permissions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[route_id] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[guard_name] [varchar](50) NOT NULL,
	[display_order] [int] NOT NULL,
	[enabled] [bit] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[update_at] [datetime] NULL,
 CONSTRAINT [PK__tbl_perm__3213E83FE7C2D6E2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__tbl_perm__75E3EFCFCAF294C9] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__tbl_perm__7B88694AE08173FA] UNIQUE NONCLUSTERED 
(
	[guard_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_has_permissions_token]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_has_permissions_token]
AS
SELECT DISTINCT * FROM (
	SELECT        dbo.tbl_users.username, dbo.tbl_sessions.token_value, dbo.tbl_permissions.guard_name
	FROM            dbo.tbl_user_has_roles INNER JOIN
							 dbo.tbl_users ON dbo.tbl_user_has_roles.user_id = dbo.tbl_users.id INNER JOIN
							 dbo.tbl_roles ON dbo.tbl_user_has_roles.role_id = dbo.tbl_roles.id INNER JOIN
							 dbo.tbl_role_has_permissions ON dbo.tbl_roles.id = dbo.tbl_role_has_permissions.role_id INNER JOIN
							 dbo.tbl_routes INNER JOIN
							 dbo.tbl_permissions ON dbo.tbl_routes.id = dbo.tbl_permissions.route_id ON dbo.tbl_role_has_permissions.permission_id = dbo.tbl_permissions.id INNER JOIN
							 dbo.tbl_sessions ON dbo.tbl_users.id = dbo.tbl_sessions.user_id
	WHERE        (dbo.tbl_users.enabled = 1) AND (dbo.tbl_permissions.enabled = 1) AND (dbo.tbl_routes.enabled = 1) AND (dbo.tbl_roles.enabled = 1) AND (dbo.tbl_sessions.enabled = 1)
	UNION

	SELECT        dbo.tbl_users.username, dbo.tbl_sessions.token_value, dbo.tbl_permissions.guard_name
	FROM            dbo.tbl_sessions INNER JOIN
							 dbo.tbl_users ON dbo.tbl_sessions.user_id = dbo.tbl_users.id INNER JOIN
							 dbo.tbl_user_has_permissions ON dbo.tbl_users.id = dbo.tbl_user_has_permissions.user_id INNER JOIN
							 dbo.tbl_routes INNER JOIN
							 dbo.tbl_permissions ON dbo.tbl_routes.id = dbo.tbl_permissions.route_id ON dbo.tbl_user_has_permissions.permission_id = dbo.tbl_permissions.id
	WHERE        (dbo.tbl_users.enabled = 1) AND (dbo.tbl_permissions.enabled = 1) AND (dbo.tbl_routes.enabled = 1) AND (dbo.tbl_sessions.enabled = 1)) AS has_permissions_token
GO
/****** Object:  View [dbo].[vw_has_permissions_user]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_has_permissions_user]
AS
SELECT DISTINCT * FROM (
	SELECT
		dbo.tbl_users.username, 
		dbo.tbl_permissions.guard_name
	FROM
		dbo.tbl_user_has_roles INNER JOIN
            dbo.tbl_users ON dbo.tbl_user_has_roles.user_id = dbo.tbl_users.id INNER JOIN
            dbo.tbl_roles ON dbo.tbl_user_has_roles.role_id = dbo.tbl_roles.id INNER JOIN
            dbo.tbl_role_has_permissions ON dbo.tbl_roles.id = dbo.tbl_role_has_permissions.role_id INNER JOIN
            dbo.tbl_routes INNER JOIN
			dbo.tbl_permissions ON dbo.tbl_routes.id = dbo.tbl_permissions.route_id ON dbo.tbl_role_has_permissions.permission_id = dbo.tbl_permissions.id
	WHERE
		(dbo.tbl_users.enabled = 1)
		AND (dbo.tbl_permissions.enabled = 1) 
		AND (dbo.tbl_routes.enabled = 1) 
		AND (dbo.tbl_roles.enabled = 1)	
	UNION
	SELECT
		dbo.tbl_users.username, 
		dbo.tbl_permissions.guard_name
	FROM
		dbo.tbl_users INNER JOIN
			dbo.tbl_user_has_permissions ON dbo.tbl_users.id = dbo.tbl_user_has_permissions.user_id INNER JOIN
			dbo.tbl_permissions ON dbo.tbl_user_has_permissions.permission_id = dbo.tbl_permissions.id INNER JOIN
			dbo.tbl_routes ON dbo.tbl_permissions.route_id = dbo.tbl_routes.id
	WHERE
		(dbo.tbl_users.enabled = 1)
		AND (dbo.tbl_permissions.enabled = 1)
		AND (dbo.tbl_routes.enabled = 1)) AS has_permissions_user
GO
/****** Object:  Table [dbo].[personas]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[personas](
	[nombre] [varchar](50) NOT NULL,
	[edad] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_casting_types]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_casting_types](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[data_type_id] [int] NOT NULL,
	[name] [varchar](20) NOT NULL,
	[format_driver] [varchar](20) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[update_at] [datetime] NULL,
 CONSTRAINT [PK__tbl_form__3213E83F1828B578] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__tbl_form__75E3EFCF7CA672F6] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_data_types]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_data_types](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
 CONSTRAINT [PK_tbl_data_types] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempHeaders]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempHeaders](
	[label] [varchar](30) NULL,
	[value] [varchar](30) NULL,
	[order] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_casting_types] ADD  CONSTRAINT [DF_tbl_format_types_created_at]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tbl_clients] ADD  CONSTRAINT [DF_tbl_clients_push_updates]  DEFAULT (CONVERT([bit],(1))) FOR [push_updates]
GO
ALTER TABLE [dbo].[tbl_clients] ADD  CONSTRAINT [DF_tbl_clients_version]  DEFAULT ((1)) FOR [version]
GO
ALTER TABLE [dbo].[tbl_clients] ADD  CONSTRAINT [DF__tbl_clien__enabl__6C190EBB]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[tbl_clients] ADD  CONSTRAINT [DF_tbl_clients_created_at]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tbl_data_types] ADD  CONSTRAINT [DF_tbl_data_types_created_at]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tbl_indicators] ADD  CONSTRAINT [DF__tbl_indic__highe__656C112C]  DEFAULT ((1)) FOR [higher_the_best]
GO
ALTER TABLE [dbo].[tbl_indicators] ADD  CONSTRAINT [DF__tbl_indic__enabl__66603565]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[tbl_indicators] ADD  CONSTRAINT [DF_tbl_indicators_created_at]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tbl_indicators_client_config] ADD  CONSTRAINT [DF__tbl_indic__enabl__72C60C4A]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[tbl_indicators_client_config] ADD  CONSTRAINT [DF_tbl_indicators_client_config_created_at]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tbl_permissions] ADD  CONSTRAINT [DF__tbl_permi__enabl__4BAC3F29]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[tbl_permissions] ADD  CONSTRAINT [DF_tbl_permissions_created_at]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tbl_roles] ADD  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[tbl_roles] ADD  CONSTRAINT [DF_tbl_roles_created_at]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tbl_routes] ADD  CONSTRAINT [DF__tbl_route__enabl__44FF419A]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[tbl_routes] ADD  CONSTRAINT [DF_tbl_routes_created_at]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tbl_sessions] ADD  CONSTRAINT [DF__tbl_sessi__enabl__3A4CA8FD]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[tbl_sessions] ADD  CONSTRAINT [DF__tbl_sessi__creat__3B40CD36]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tbl_stats] ADD  CONSTRAINT [DF__tbl_stats__repor__787EE5A0]  DEFAULT (getdate()) FOR [reported_datetime]
GO
ALTER TABLE [dbo].[tbl_users] ADD  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[tbl_users] ADD  CONSTRAINT [DF_tbl_users_created_at]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[tbl_casting_types]  WITH CHECK ADD  CONSTRAINT [FK_tbl_casting_types_tbl_data_types] FOREIGN KEY([data_type_id])
REFERENCES [dbo].[tbl_data_types] ([id])
GO
ALTER TABLE [dbo].[tbl_casting_types] CHECK CONSTRAINT [FK_tbl_casting_types_tbl_data_types]
GO
ALTER TABLE [dbo].[tbl_indicators]  WITH CHECK ADD  CONSTRAINT [FK_tbl_format_types_tbl_indicators] FOREIGN KEY([casting_type_id])
REFERENCES [dbo].[tbl_casting_types] ([id])
GO
ALTER TABLE [dbo].[tbl_indicators] CHECK CONSTRAINT [FK_tbl_format_types_tbl_indicators]
GO
ALTER TABLE [dbo].[tbl_indicators_client_config]  WITH CHECK ADD  CONSTRAINT [FK_tbl_indicators_client_config_tbl_clients] FOREIGN KEY([client_id])
REFERENCES [dbo].[tbl_clients] ([id])
GO
ALTER TABLE [dbo].[tbl_indicators_client_config] CHECK CONSTRAINT [FK_tbl_indicators_client_config_tbl_clients]
GO
ALTER TABLE [dbo].[tbl_indicators_client_config]  WITH CHECK ADD  CONSTRAINT [FK_tbl_indicators_client_config_tbl_indicators] FOREIGN KEY([indicator_id])
REFERENCES [dbo].[tbl_indicators] ([id])
GO
ALTER TABLE [dbo].[tbl_indicators_client_config] CHECK CONSTRAINT [FK_tbl_indicators_client_config_tbl_indicators]
GO
ALTER TABLE [dbo].[tbl_indicators_client_config]  WITH CHECK ADD  CONSTRAINT [FK_tbl_indicators_client_config_tbl_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[tbl_users] ([id])
GO
ALTER TABLE [dbo].[tbl_indicators_client_config] CHECK CONSTRAINT [FK_tbl_indicators_client_config_tbl_users]
GO
ALTER TABLE [dbo].[tbl_permissions]  WITH CHECK ADD  CONSTRAINT [FK_tbl_permissions_tbl_routes] FOREIGN KEY([route_id])
REFERENCES [dbo].[tbl_routes] ([id])
GO
ALTER TABLE [dbo].[tbl_permissions] CHECK CONSTRAINT [FK_tbl_permissions_tbl_routes]
GO
ALTER TABLE [dbo].[tbl_role_has_permissions]  WITH CHECK ADD  CONSTRAINT [FK_tbl_role_has_permissions_tbl_permissions] FOREIGN KEY([permission_id])
REFERENCES [dbo].[tbl_permissions] ([id])
GO
ALTER TABLE [dbo].[tbl_role_has_permissions] CHECK CONSTRAINT [FK_tbl_role_has_permissions_tbl_permissions]
GO
ALTER TABLE [dbo].[tbl_role_has_permissions]  WITH CHECK ADD  CONSTRAINT [FK_tbl_role_has_permissions_tbl_roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[tbl_roles] ([id])
GO
ALTER TABLE [dbo].[tbl_role_has_permissions] CHECK CONSTRAINT [FK_tbl_role_has_permissions_tbl_roles]
GO
ALTER TABLE [dbo].[tbl_sessions]  WITH CHECK ADD  CONSTRAINT [FK_tbl_sessions_tbl_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[tbl_users] ([id])
GO
ALTER TABLE [dbo].[tbl_sessions] CHECK CONSTRAINT [FK_tbl_sessions_tbl_users]
GO
ALTER TABLE [dbo].[tbl_stats]  WITH CHECK ADD  CONSTRAINT [FK_tbl_stats_tbl_clients] FOREIGN KEY([client_mac_address])
REFERENCES [dbo].[tbl_clients] ([mac_address])
GO
ALTER TABLE [dbo].[tbl_stats] CHECK CONSTRAINT [FK_tbl_stats_tbl_clients]
GO
ALTER TABLE [dbo].[tbl_stats]  WITH CHECK ADD  CONSTRAINT [FK_tbl_stats_tbl_indicators] FOREIGN KEY([indicator_key])
REFERENCES [dbo].[tbl_indicators] ([indicator_key])
GO
ALTER TABLE [dbo].[tbl_stats] CHECK CONSTRAINT [FK_tbl_stats_tbl_indicators]
GO
ALTER TABLE [dbo].[tbl_user_has_permissions]  WITH CHECK ADD  CONSTRAINT [FK_tbl_user_has_permissions_tbl_permissions] FOREIGN KEY([permission_id])
REFERENCES [dbo].[tbl_permissions] ([id])
GO
ALTER TABLE [dbo].[tbl_user_has_permissions] CHECK CONSTRAINT [FK_tbl_user_has_permissions_tbl_permissions]
GO
ALTER TABLE [dbo].[tbl_user_has_permissions]  WITH CHECK ADD  CONSTRAINT [FK_tbl_user_has_permissions_tbl_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[tbl_users] ([id])
GO
ALTER TABLE [dbo].[tbl_user_has_permissions] CHECK CONSTRAINT [FK_tbl_user_has_permissions_tbl_users]
GO
ALTER TABLE [dbo].[tbl_user_has_roles]  WITH CHECK ADD  CONSTRAINT [FK_tbl_user_has_roles_tbl_roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[tbl_roles] ([id])
GO
ALTER TABLE [dbo].[tbl_user_has_roles] CHECK CONSTRAINT [FK_tbl_user_has_roles_tbl_roles]
GO
ALTER TABLE [dbo].[tbl_user_has_roles]  WITH CHECK ADD  CONSTRAINT [FK_tbl_user_has_roles_tbl_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[tbl_users] ([id])
GO
ALTER TABLE [dbo].[tbl_user_has_roles] CHECK CONSTRAINT [FK_tbl_user_has_roles_tbl_users]
GO
/****** Object:  StoredProcedure [dbo].[sp_clients_create]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Alfonso Loaiza Sibaja
-- Create date: 2023-03-18
-- Description:	Inserta un nuevo registro dentro de la tabla dbo.tbl_clients
-- =============================================
CREATE PROCEDURE [dbo].[sp_clients_create]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id					INT
	DECLARE @mac_address		VARCHAR(17)
	DECLARE @netbios_name		VARCHAR(16)
	DECLARE @friendly_name		VARCHAR(50)
	DECLARE @enabled			BIT

	-- Asignación de los valores del JSON a las variables del Stored Procedure
	SELECT
		@mac_address	= CASE WHEN TRIM(mac_address)	= '' THEN NULL ELSE TRIM(mac_address)	END,
		@netbios_name	= CASE WHEN TRIM(netbios_name)	= '' THEN NULL ELSE TRIM(netbios_name)	END,
		@friendly_name	= CASE WHEN TRIM(friendly_name)	= '' THEN NULL ELSE TRIM(friendly_name)	END,
		@enabled		= enabled

	FROM OPENJSON(@json)
		WITH (
			mac_address		VARCHAR(17),
			netbios_name	VARCHAR(16),
			friendly_name	VARCHAR(50),
			enabled			BIT
			)
	
	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		INSERT INTO [dbo].[tbl_clients]
				([mac_address]
				,[netbios_name]
				,[friendly_name]
				,[enabled])
			VALUES
				(@mac_address
				,@netbios_name
				,@friendly_name
				,@enabled)

		-- Se toma el ID del último registro que se creó
		SELECT @id = SCOPE_IDENTITY()

		-- Se devuelven los campos del registro recien creado
		SELECT
			[id]
			,[mac_address]
			,[netbios_name]
			,[friendly_name]
			,[push_updates]
			,[version]
			,[enabled]
			,[created_at]
			,[update_at]
		FROM [dbo].[tbl_clients] WHERE id = @id
	END TRY

	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		THROW 60000, '{"code":"60101"}', 16;;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_clients_delete]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_clients_delete]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id				INT

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
			@id = id
		FROM OPENJSON(@json)
			WITH (
				id		INT
				)

		IF EXISTS(SELECT * FROM [dbo].[tbl_clients] WHERE id = @id)
		BEGIN
			-- Eliminación del registro seleccionado
			DELETE FROM [dbo].[tbl_clients] WHERE id = @id
		END
		ELSE
		BEGIN;
			THROW 60000, '{"code":"60104"}', 16;
		END
	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_clients_login]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Leiver Espinoza
-- Create date: 2023-03-22
-- Description:	Permite a una cuenta de servicio crear una nueva sesión
-- Exec: EXEC [dbo].[sp_clients_login] '{"username":"remote_client", "secret_key":"remote_client"}'
-- =============================================
CREATE PROCEDURE [dbo].[sp_clients_login]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id				INT
	DECLARE @username		VARCHAR(15)
	DECLARE @api_key		VARCHAR(36)
	DECLARE @secret_key		VARCHAR(36)

	-- Asignación de los valores del JSON a las variables del Stored Procedure
	SELECT
		@username		= CASE WHEN TRIM(username)		= '' THEN NULL ELSE TRIM(username)		END,
		@api_key		= CASE WHEN TRIM(api_key)		= '' THEN NULL ELSE TRIM(api_key)		END,
		@secret_key		= CASE WHEN TRIM(secret_key)	= '' THEN NULL ELSE TRIM(secret_key)	END
	FROM OPENJSON(@json)
		WITH (
			username		VARCHAR(15),
			api_key			VARCHAR(36),
			secret_key		VARCHAR(36)
			)

	-- Prueba de ejecución de la acción principal del Stored Procedure
		IF CASE WHEN EXISTS(SELECT id FROM [dbo].[tbl_users]
							WHERE
							[tbl_users].username = @username
							AND [tbl_users].password = HASHBYTES('SHA2_512', @secret_key)
							)
				THEN 1
				ELSE 0 END = 1
		BEGIN
			BEGIN TRY
			--ACTIVAR LAS SIGUIENTES LINIEAS PARA PERMITIR UNA UNICA SESION POR CLIENTE
			--Eliminación de cualquier otra sesion activa
			--UPDATE [dbo].[tbl_sessions]
			--	SET enabled = CAST(0 AS BIT)
			--	WHERE
			--		user_id = (SELECT id FROM tbl_users WHERE username = @username)
			--		AND enabled = CAST(1 AS BIT)

			--Creación de un nuevo token para la nueva sesión
			INSERT INTO [dbo].[tbl_sessions]
					([user_id]
					,[token_value]
					,[enabled])
				VALUES
					((SELECT id FROM tbl_users WHERE username = @username)
					,NEWID()
					,1)

			SELECT @id = SCOPE_IDENTITY()

			--Se devuelven los campos del registro recien creado
			SELECT
				[token_value] AS Token
			FROM [dbo].[tbl_sessions] WHERE id = @id
			END TRY

			--En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure arroja una excepción de error
			BEGIN CATCH
				THROW 59000, '{"code":"59001"}', 16;;
			END CATCH
		END
		ELSE
		BEGIN;
			THROW 59000, '{"code":"59002"}', 16;
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_clients_read]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Alfonso Loaiza Sibaja
-- Create date: 2023-03-18
-- Description:	Retorna el usuario que tenga el ID igual al valor especificado en el JSON
-- =============================================
CREATE PROCEDURE [dbo].[sp_clients_read]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id				INT

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
			@id = id
		FROM OPENJSON(@json)
			WITH (
				id		INT
				)
	
		-- Se devuelven los campos del registro recien creado
		SELECT
			 [id]
			,[mac_address]
			,[netbios_name]
			,[friendly_name]
			,[push_updates]
			,[version]
			,[enabled]
			,[created_at]
			,[update_at]
		FROM [dbo].[tbl_clients] WHERE id = @id
	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		THROW 60000, '{"code":"60102"}', 16;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_clients_read_all]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Alfonso Loaiza Sibaja
-- Create date: 2023-03-01
-- Description:	Retorna la lista completa de usuarios que cumplan con los parámetros en el parámetro de tipo JSON
-- Exec : EXEC [dbo].[sp_clients_read_all] @json = '{}'
-- =============================================
CREATE PROCEDURE [dbo].[sp_clients_read_all]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @mac_address		VARCHAR(17)
	DECLARE @netbios_name		VARCHAR(16)
	DECLARE @friendly_name		VARCHAR(50)
	DECLARE @push_updates		BIT
	DECLARE @version			INT
	DECLARE @enabled			BIT

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
			@mac_address	= mac_address,
			@netbios_name	= netbios_name,
			@friendly_name	= friendly_name
		FROM OPENJSON(@json)
			WITH (
				mac_address			VARCHAR(17),
				netbios_name		VARCHAR(16),
				friendly_name		VARCHAR(50)
				)
	
		-- Se devuelven los campos del registro recien creado

		--SELECT @mac_address, @netbios_name, @friendly_name

		SELECT
			[id]
			,[mac_address]
			,[netbios_name]
			,[friendly_name]
			,[push_updates]
			,[version]
			,[enabled]
			,[created_at]
			,[update_at]
		FROM [dbo].[tbl_clients]
		WHERE
			[mac_address]	LIKE	CASE WHEN @mac_address		IS NULL	THEN '%%'			ELSE '%' + @mac_address + '%'	END AND
			[netbios_name]	LIKE	CASE WHEN @netbios_name		IS NULL	THEN '%%'			ELSE '%' + @netbios_name + '%'	END AND
			[friendly_name]	LIKE	CASE WHEN @friendly_name	IS NULL	THEN '%%'			ELSE '%' + @friendly_name + '%'	END AND
			[enabled]		=		CASE WHEN @enabled			IS NULL	THEN [enabled]		ELSE @enabled					END
	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		THROW 60000, '{"code":"60102"}', 16;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[sp_clients_switch_push]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Leiver Espinoza
-- Create date: 2023-03-01
-- Description:	Actualiza un registro de la tabla de usuarios con base a la información contenida en el parámetro de tipo JSON
-- =============================================
CREATE PROCEDURE [dbo].[sp_clients_switch_push]
	@json varchar(max) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET XACT_ABORT ON
	SET NOCOUNT ON

	DECLARE @client_mac_address VARCHAR(17)

    -- Insert statements for procedure here
	SELECT
		@client_mac_address = client_mac_address
	FROM OPENJSON(@json)
		WITH (
			client_mac_address VARCHAR(17)
			)
	---select @client_mac_address

	UPDATE [dbo].[tbl_clients]
	SET
		[push_updates] = 0
		, [version] = [version] + 1
	WHERE
		[mac_address] = @client_mac_address
END
GO
/****** Object:  StoredProcedure [dbo].[sp_clients_update]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Alfonso Loaiza Sibaja
-- Create date: 2023-03-18
-- Description:	Actualiza un registro de la tabla de usuarios con base a la información contenida en el parámetro de tipo JSON
-- =============================================
CREATE PROCEDURE [dbo].[sp_clients_update]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id				INT
	DECLARE @mac_address	VARCHAR(17)
	DECLARE @netbios_name	VARCHAR(16)
	DECLARE @friendly_name	VARCHAR(50)
	DECLARE @enabled		BIT

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
			@id = id,
			@mac_address		= CASE WHEN TRIM(mac_address)		= '' THEN NULL ELSE TRIM(mac_address)		END,
			@netbios_name		= CASE WHEN TRIM(netbios_name)		= '' THEN NULL ELSE TRIM(netbios_name)		END,
			@friendly_name		= CASE WHEN TRIM(friendly_name)		= '' THEN NULL ELSE TRIM(friendly_name)		END,
			@enabled = enabled
		FROM OPENJSON(@json)
			WITH (
				id				INT,
				mac_address		VARCHAR(17),
				netbios_name	VARCHAR(16),
				friendly_name	VARCHAR(50),
				enabled			BIT
				)
	
		-- Se actualizan los datos del registro cuyo ID corresponde al ID proveido

		UPDATE [dbo].[tbl_clients]
		SET
			[mac_address]	=	CASE WHEN @mac_address		IS NULL	THEN [mac_address]		ELSE @mac_address	END,
			[netbios_name]	=	CASE WHEN @netbios_name		IS NULL	THEN [netbios_name]		ELSE @netbios_name	END,
			[friendly_name]	=	CASE WHEN @friendly_name	IS NULL	THEN [friendly_name]	ELSE @friendly_name	END,
			[enabled]		=	CASE WHEN @enabled			IS NULL	THEN [enabled]			ELSE @enabled		END,
			[update_at]		=	GETDATE()
		WHERE	
			[id] = @id

		-- Se devuelven los campos del registro recien creado

		SELECT
			[id]
			,[mac_address]
			,[netbios_name]
			,[friendly_name]
			,[push_updates]
			,[version]
			,[enabled]
			,[created_at]
			,[update_at]
		FROM [dbo].[tbl_clients]
		WHERE
			[id] = @id
	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		THROW 60000, '{"code":"60103"}', 16;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_dashboard_details_all]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Leiver Espinoza
-- Create date: 2023-04-17
-- Description:	Retorna los indicadores usados en el la barra superior del dashboard
-- Exec: 
-- EXEC [dbo].[sp_dashboard_details_all] @json = '{"client_id":5}'
-- EXEC [dbo].[sp_dashboard_details_all] @json = '{"client_id":0}'
-- =============================================
CREATE PROCEDURE [dbo].[sp_dashboard_details_all]
	@json varchar(max) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @client_id INT

	If(OBJECT_ID('TempHeaders') IS NOT NULL) DROP TABLE TempHeaders
	CREATE TABLE TempHeaders (
		[label] VARCHAR(30)
		, [value] VARCHAR(30)
		, [order] INT
	)
	INSERT INTO TempHeaders EXEC [dbo].[sp_dashboard_top_panel]

	SELECT
		@client_id = client_id
	FROM OPENJSON(@json)
		WITH (
			client_id INT
			)

	If(OBJECT_ID('tempdb..#Snapshot') IS NOT NULL) DROP TABLE #Snapshot
	SELECT
		RawData.[Client ID] AS 'Client_ID'
		, RawData.[Indicator Key] AS 'Indicator_Key'
		, RawData.[Last Report] AS 'Time_Stamp'
		, RawData.Status AS 'Status'
		, CASE
			WHEN RawData.[Indicator Key] = 'platform_name' THEN
				CASE
					WHEN [Value] IN ('Linux' , 'Windows') THEN [Value]
					WHEN [Value] = 'Darwin' THEN 'MacOS'
					ELSE 'Unknown'
				END
			WHEN RawData.[Indicator Key] = 'battery_power_plugged' THEN
				CASE
					WHEN [Value] = 'True' THEN 'AC Adapter'
					WHEN [Value] = 'False' THEN 'Battery'
					ELSE 'Power Supply'
				END
			WHEN [Indicator Key] = 'battery_percent' AND [Value] = '0' THEN '-'
			WHEN [Indicator Key] IN ('battery_percent','disk_space_percent','memory_perc_used') THEN CONVERT(VARCHAR,CAST(CAST([Value] AS DECIMAL(8,4))*100 AS DECIMAL(8,2))) + '%' --0.5423
			WHEN [Indicator Key] = 'cpu_perc' THEN [Value] + ' %'
			WHEN [Indicator Key] LIKE 'cpu_freq_%' THEN [Value] + ' MHz'
			WHEN [Indicator Key] = 'boot_time' THEN LEFT([Value],10)
			WHEN [Indicator Key] LIKE 'disk_%_time' THEN CONVERT(VARCHAR,DATEADD(SECOND,CONVERT(INT,[Value]),'00:00:00'),8)
			WHEN [Indicator Key] LIKE '%bytes%' THEN CONCAT(CAST([Value] AS FLOAT)/1024/1024, ' GB')
			WHEN ([Indicator Key] LIKE '%_mb' AND [Indicator Key] LIKE 'disk_%') THEN CONVERT(VARCHAR,CAST(CAST([Value] AS FLOAT)/1024 AS DECIMAL(6,2)))
			WHEN [Indicator Key] LIKE '%_mb' THEN CONCAT(CAST(CAST([Value] AS FLOAT)/1024 AS DECIMAL(6,2)), ' GB')
			WHEN [Indicator Key] LIKE '%_count' THEN FORMAT(CAST([Value] AS BIGINT),'###,###,###,###,###,###')
			ELSE [Value]
		END AS 'Value'
	INTO #Snapshot
	FROM (SELECT * FROM fn_get_stats_last_status(36)) AS RawData
	WHERE
		RawData.[Client ID] = @client_id
	ORDER BY RawData.[Last Report] DESC

	SELECT
		0 AS 'Client_ID'
		, LOWER(REPLACE(CONVERT(VARCHAR(30),TempHeaders.[label]), ' ', '_')) AS 'Indicator_Key'
		, GETDATE() AS 'Time_Stamp'
		, CASE
			WHEN TempHeaders.label = 'Clients with Alerts' AND TempHeaders.value > 0 THEN 'T1'
			ELSE 'T0'
		END AS 'Status'
		, CONVERT(VARCHAR(15),TempHeaders.[value]) AS 'Value'
	FROM TempHeaders
	UNION
	SELECT * FROM #Snapshot
	UNION
	SELECT
		0 AS 'Client_ID'
		, 'last_update' AS 'Indicator_Key'
		, GETDATE()
		, 'T0' AS 'Status'
		, CONVERT(VARCHAR,GETDATE(),20) AS 'Value'
	UNION
	SELECT
		0 AS 'Client_ID'
		, 'last_report' AS 'Indicator_Key'
		, GETDATE()
		, 'T0' AS 'Status'
		,CONVERT(VARCHAR,MAX(#Snapshot.Time_Stamp),20) AS 'Value'
	FROM #Snapshot
	ORDER BY [Time_Stamp] DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_dashboard_details_cbos]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Leiver Espinoza
-- Create date: 2023-04-17
-- Description:	Retorna los indicadores usados en el la barra superior del dashboard
-- Exec: EXEC [dbo].[sp_dashboard_details_cbos] @json = '{"client_id":0}'
-- UPDATE [dbo].[tbl_indicators_client_config] SET interval_seconds = 5 WHERE ID = 211
-- =============================================
CREATE PROCEDURE [dbo].[sp_dashboard_details_cbos]
	@json varchar(max) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @client_id INT
	
	
	SELECT
		@client_id = CASE WHEN client_id IS NULL THEN 0 ELSE client_id END
	FROM OPENJSON(@json)
		WITH (
			client_id INT
			)

	If(OBJECT_ID('tempdb..#Snapshot') IS NOT NULL) DROP TABLE #Snapshot

	SELECT
		[Client ID] AS 'Client_ID'
		, [Indicator name] AS 'Indicator_Name'
		, [Indicator Key] AS 'Indicator_Key'
		, [Configuration ID] AS 'Configuration_ID'
		, [Value ID] AS 'Value_ID',
		CASE
			WHEN [Indicator Key] = 'platform_name' THEN
				CASE
					WHEN [Value] IN ('Linux' , 'Windows') THEN [Value]
					WHEN [Value] = 'Darwin' THEN 'MacOS'
					ELSE 'Unknown'
				END
			WHEN [Indicator Key] = 'battery_power_plugged' THEN
				CASE
					WHEN [Value] = 'True' THEN 'AC Adapter'
					WHEN [Value] = 'False' THEN 'Battery'
					ELSE 'Power Supply'
				END
			WHEN [Indicator Key] = 'battery_percent' AND [Value] = '0' THEN '-'
			WHEN [Indicator Key] = 'battery_percent' THEN CONVERT(VARCHAR,CAST([Value] AS DECIMAL(5,2))*100) + '%'
			WHEN [Indicator Key] LIKE 'cpu_freq_%' THEN [Value] + ' MHz'
			WHEN [Indicator Key] = 'boot_time' THEN LEFT([Value],10)
			ELSE [Value]
		END AS 'Value'
	INTO #Snapshot
	FROM fn_get_stats_last_status(60*24)
	WHERE
		(
			[Client ID] = @client_id
			OR
			(@client_id = 0 AND [Client ID] > @client_id)
		)
		AND [Indicator Key] IN ('cpu_count', 'cpu_freq_min', 'cpu_freq_current', 'cpu_freq_max', 'boot_time', 'time_since_boot', 'platform_name', 'battery_percent','battery_power_plugged')
	SELECT * FROM #Snapshot
	ORDER BY [Indicator_Key]
END
GO
/****** Object:  StoredProcedure [dbo].[sp_dashboard_details_values]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Leiver Espinoza
-- Create date: 2023-04-17
-- Description:	Retorna los indicadores usados en el la barra superior del dashboard
-- Exec: 
-- EXEC [dbo].[sp_dashboard_details_values] @json = '{"client_id":5, "records":1, "indicator_key":"platform"}'
-- EXEC [dbo].[sp_dashboard_details_values] @json = '{"client_id":0, "records":100, "indicator_key":"mem_"}'
-- =============================================
CREATE PROCEDURE [dbo].[sp_dashboard_details_values]
	@json varchar(max) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @client_id INT
	DECLARE @records INT
	DECLARE @indicator_key VARCHAR(30)
	
	SELECT
		@client_id = client_id
		, @records = records
		, @indicator_key = indicator_key
	FROM OPENJSON(@json)
		WITH (
			client_id INT
			, records INT
			, indicator_key VARCHAR(30)
			)

	If(OBJECT_ID('tempdb..#Snapshot') IS NOT NULL) DROP TABLE #Snapshot
	SELECT TOP (@records)
		tmpClients.id AS 'Client_ID'
		, tmpIndicators.indicator_key AS 'Indicator_Key'
		, tmpStats.value AS 'Value'
		, tmpStats.reported_datetime AS 'Time_Stamp'
		, tmpStats.id AS 'Value_Order'
	INTO #Snapshot
	FROM tbl_stats AS tmpStats
		INNER JOIN tbl_clients AS tmpClients ON tmpClients.mac_address = tmpStats.client_mac_address
		INNER JOIN tbl_indicators AS tmpIndicators ON tmpIndicators.indicator_key = tmpStats.indicator_key
		INNER JOIN tbl_data_types AS tmpTypes ON tmpTypes.id = tmpIndicators.casting_type_id
		INNER JOIN tbl_casting_types AS tmpCasting ON tmpCasting.data_type_id = tmpTypes.id
	WHERE
		(
			tmpClients.id = @client_id
			OR
			(@client_id = 0 AND tmpClients.id > @client_id)
		)
		AND tmpStats.indicator_key LIKE ('%' + @indicator_key + '%')
	ORDER BY tmpStats.reported_datetime DESC

	SELECT * FROM #Snapshot ORDER BY [Time_Stamp]
END
GO
/****** Object:  StoredProcedure [dbo].[sp_dashboard_side_panel]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Leiver Espinoza
-- Create date: 2023-04-17
-- Description:	Retorna la lista de equipos reportados en los últimos n minutos y su estatus
-- Exec: EXEC [dbo].[sp_dashboard_side_panel]
-- =============================================
CREATE PROCEDURE [dbo].[sp_dashboard_side_panel]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @minutes INT
	SET @minutes = 30

	If(OBJECT_ID('tempdb..#Snapshot') IS NOT NULL) DROP TABLE #Snapshot

	SELECT *
	INTO #Snapshot
	FROM fn_get_stats_last_status(@minutes) AS Snap
	INNER JOIN tbl_clients AS Clients ON Snap.[Client ID] = Clients.id
	WHERE Clients.enabled = 1

	If(OBJECT_ID('tempdb..#Snapshot_Clients') IS NOT NULL) DROP TABLE #Snapshot_Clients

	SELECT C.[Client ID], MAX(C.[Value ID]) AS 'LastRecord'
	INTO #Snapshot_Clients
	FROM #Snapshot AS C
	GROUP BY C.[Client ID]

	If(OBJECT_ID('tempdb..#Snapshot_IPs') IS NOT NULL) DROP TABLE #Snapshot_IPs

	SELECT [Client ID], [IP Address], [Value ID]
	INTO #Snapshot_IPs
	FROM #Snapshot

	If(OBJECT_ID('tempdb..#Snapshot_LastIP') IS NOT NULL) DROP TABLE #Snapshot_LastIP

	SELECT SC.[Client ID], SIP.[IP Address]
	INTO #Snapshot_LastIP
	FROM #Snapshot_Clients AS SC 
	INNER JOIN #Snapshot_IPs AS SIP ON SIP.[Value ID] = SC.LastRecord

	If(OBJECT_ID('tempdb..#Clients') IS NOT NULL) DROP TABLE #Clients

	SELECT
		RawData.[Client ID]
		, RawData.[Friendly Name]
		, RawData.Hostname
	INTO #Clients
	FROM (SELECT * FROM #Snapshot) AS RawData
	--WHERE
	--	RawData.Status = 'T1'
	GROUP BY
		RawData.[Client ID]
		, RawData.[Friendly Name]
		, RawData.Hostname

	If(OBJECT_ID('tempdb..#Alerts') IS NOT NULL) DROP TABLE #Alerts

	CREATE TABLE #Alerts (
		[Client ID] INT
		, [Status] VARCHAR(50)
		, [Records] INT)

	INSERT INTO #Alerts
	SELECT
		RawData.[Client ID]
		, 'Critical' AS 'Status'
		, COUNT(RawData.[Client ID]) AS 'Records'
	FROM (SELECT * FROM #Snapshot) AS RawData
	WHERE
		RawData.Status = 'T1'
	GROUP BY
		RawData.[Client ID]

	INSERT INTO #Alerts
	SELECT
		RawData.[Client ID]
		, 'Alert' AS 'Status'
		, COUNT(RawData.[Client ID]) AS 'Records'
	FROM (SELECT * FROM #Snapshot) AS RawData
	WHERE
		RawData.Status = 'T2'
		AND RawData.[Client ID] NOT IN (SELECT [Client ID] FROM #Alerts)
	GROUP BY
		RawData.[Client ID]

	INSERT INTO #Alerts
	SELECT
		RawData.[Client ID]
		, 'Warning' AS 'Status'
		, COUNT(RawData.[Client ID]) AS 'Records'
	FROM (SELECT * FROM #Snapshot) AS RawData
	WHERE
		RawData.Status = 'T3'
		AND RawData.[Client ID] NOT IN (SELECT [Client ID] FROM #Alerts)
	GROUP BY
		RawData.[Client ID]

	INSERT INTO #Alerts
	SELECT
		RawData.[Client ID]
		, 'Normal operation' AS 'Status'
		, COUNT(RawData.[Client ID]) AS 'Records'
	FROM (SELECT * FROM #Snapshot) AS RawData
	WHERE
		RawData.Status IN ('T4', 'T0')
		AND RawData.[Client ID] NOT IN (SELECT [Client ID] FROM #Alerts)
	GROUP BY
		RawData.[Client ID]

	SELECT
		C.[Client ID] AS 'Client_ID'
		, C.[Friendly Name] AS 'Friendly_Name'
		, C.Hostname
		, SLIP.[IP Address] AS 'IP_Address'
		, A.Status
		, A.Records
	FROM #Clients AS C
		LEFT JOIN #Alerts AS A ON A.[Client ID] = C.[Client ID]
		LEFT JOIN #Snapshot_LastIP AS SLIP ON SLIP.[Client ID] = C.[Client ID]
END
GO
/****** Object:  StoredProcedure [dbo].[sp_dashboard_top_panel]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Leiver Espinoza
-- Create date: 2023-04-17
-- Description:	Retorna los indicadores usados en el la barra superior del dashboard
-- Exec: EXEC [dbo].[sp_dashboard_top_panel]
-- =============================================
CREATE PROCEDURE [dbo].[sp_dashboard_top_panel]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		'Configured Clients' AS 'label'
		, COUNT(*) AS 'value'
		, 1 AS 'order'
	FROM tbl_clients
	UNION
	SELECT
		'Active Clients' AS 'label'
		, COUNT(*) AS 'value'
		, 2 AS 'order'
	FROM tbl_clients
	WHERE enabled = 1
	UNION
	SELECT
		'Windows Clients' AS 'label'
		, COUNT([Client ID]) AS 'value'
		, 3 AS 'order'
	FROM fn_get_stats_last_status(24)
	WHERE [Indicator Key] = 'platform_name' AND UPPER([Value]) ='WINDOWS'
	UNION
	SELECT
		'Linux Clients' AS 'label'
		, COUNT([Client ID]) AS 'value'
		, 4 AS 'order'
	FROM fn_get_stats_last_status(24)
	WHERE [Indicator Key] = 'platform_name' AND UPPER([Value]) ='LINUX'
	UNION
	SELECT
		'Inactive Clients' AS 'label'
		, COUNT(*) AS 'value'
		, 5 AS 'order'
	FROM tbl_clients
	WHERE enabled = 0
	UNION
	SELECT DISTINCT
		'Clients with Alerts' AS 'label'
		, COUNT(RawData.[Friendly Name])
		, 6 AS 'order'
	FROM (SELECT * FROM fn_get_stats_last_status(30)) AS RawData
	WHERE
		RawData.Status != 'T0'
	ORDER BY[order]
END
GO
/****** Object:  StoredProcedure [dbo].[sp_indicators_client_config_create]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Alfonso Loaiza Sibaja
-- Create date: 2023-03-18
-- Description:	Inserta un nuevo registro dentro de la tabla dbo.tbl_clients
-- =============================================
CREATE PROCEDURE [dbo].[sp_indicators_client_config_create]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id					INT
	DECLARE @user_id			INT
	DECLARE @client_id			INT
	DECLARE @indicator_id		INT
	DECLARE @interval_seconds	INT
	DECLARE @enabled			bit
	DECLARE @threshold_l4		decimal
	DECLARE @threshold_l3		decimal
	DECLARE @threshold_l2		decimal
	DECLARE @threshold_l1		decimal

	-- Asignación de los valores del JSON a las variables del Stored Procedure
	SELECT
		@user_id			= user_id,
		@client_id			= client_id,
		@indicator_id		= indicator_id,
		@interval_seconds	= interval_seconds,
		@threshold_l4		= threshold_l4,
		@threshold_l3		= threshold_l3,
		@threshold_l2		= threshold_l2,
		@threshold_l1		= threshold_l1,
		@enabled			= enabled

	FROM OPENJSON(@json)
		WITH (
				user_id				INT,	
				client_id			INT,
				indicator_id		INT,
				interval_seconds	INT,
				enabled				bit,
				threshold_l4		decimal,
				threshold_l3		decimal,
				threshold_l2		decimal,
				threshold_l1		decimal
			)
	
	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		INSERT INTO [dbo].[tbl_indicators_client_config]
				([user_id]
				,[client_id]
				,[indicator_id]
				,[interval_seconds]
				,[threshold_l4]
				,[threshold_l3]
				,[threshold_l2]
				,[threshold_l1]
				,[enabled])
			VALUES
				(@user_id
				,@client_id
				,@indicator_id
				,@interval_seconds
				,@threshold_l4
				,@threshold_l3
				,@threshold_l2
				,@threshold_l1
				,@enabled)

		-- Se toma el ID del último registro que se creó
		SELECT @id = SCOPE_IDENTITY()

		-- Se devuelven los campos del registro recien creado
		SELECT
			[id]
			,[user_id]
			,[client_id]
			,[indicator_id]
			,[interval_seconds]
			,[enabled]
			,[threshold_l4]
			,[threshold_l3]
			,[threshold_l2]
			,[threshold_l1]
			,[created_at]
			,[update_at]
		FROM [dbo].[tbl_indicators_client_config] WHERE id = @id
	END TRY

	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure arroja una excepción de error
	BEGIN CATCH
		THROW 60000, '{"code":"60201"}', 16;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_indicators_client_config_delete]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_indicators_client_config_delete]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id				INT

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
			@id = id
		FROM OPENJSON(@json)
			WITH (
				id		INT
				)

		IF EXISTS(SELECT * FROM [dbo].[tbl_indicators_client_config] WHERE id = @id)
		BEGIN
			-- Eliminación del registro seleccionado
			DELETE FROM [dbo].[tbl_indicators_client_config] WHERE id = @id
		END
		ELSE
		BEGIN;
			THROW 60000, '{"code":"60204"}', 16;
		END
	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_indicators_client_config_push_settings]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Leiver Espinoza
-- Create date: 2023-04-19
-- Description:	Retorna la configuración del cliente que tenga el Mac Address igual al valor especificado en el JSON
-- =============================================
CREATE PROCEDURE [dbo].[sp_indicators_client_config_push_settings]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @client_mac_address	VARCHAR(17)

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
			@client_mac_address = client_mac_address
		FROM OPENJSON(@json)
			WITH (
				client_mac_address VARCHAR(17)
				)

		-- Se devuelven los campos del registro consultado
		SELECT
			Indicator.indicator_key AS 'indicator_key'
			, Config.enabled AS 'enabled'
			, Config.interval_seconds AS 'interval_seconds'
		FROM tbl_indicators_client_config AS Config
			INNER JOIN tbl_indicators AS Indicator ON Config.indicator_id = Indicator.id
			INNER JOIN tbl_clients AS Clients ON config.client_id = Clients.id
		WHERE
			Clients.mac_address = @client_mac_address

	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		THROW 60000, '{"code":"60205"}', 16;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_indicators_client_config_read]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Alfonso Loaiza Sibaja
-- Create date: 2023-03-01
-- Description:	Retorna el usuario que tenga el ID igual al valor especificado en el JSON
-- =============================================
CREATE PROCEDURE [dbo].[sp_indicators_client_config_read]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id				INT

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
			@id = id
		FROM OPENJSON(@json)
			WITH (
				id		INT
				)
	
		-- Se devuelven los campos del registro recien creado
		SELECT
			[id]
			,[user_id]
			,[client_id]
			,[indicator_id]
			,[interval_seconds]
			,[enabled]
			,[threshold_l4]
			,[threshold_l3]
			,[threshold_l2]
			,[threshold_l1]
			,[created_at]
			,[update_at]
		FROM [dbo].[tbl_indicators_client_config] WHERE id = @id
	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure arroja una excepción de error
	BEGIN CATCH
		THROW 60000, '{"code":"60202"}', 16;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_indicators_client_config_read_all]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Cristopher Mora Sánchez
-- Create date: 2023-03-18
-- Description:	Retorna la lista completa de usuarios que cumplan con los parámetros en el parámetro de tipo JSON
-- =============================================
CREATE PROCEDURE [dbo].[sp_indicators_client_config_read_all]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id					INT
	DECLARE @user_id			INT
	DECLARE @client_id			INT
	DECLARE @indicator_id		INT
	DECLARE @interval_seconds	INT
	DECLARE @enabled			BIT
	DECLARE @threshold_l4		decimal
	DECLARE @threshold_l3		decimal
	DECLARE @threshold_l2		decimal
	DECLARE @threshold_l1		decimal

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
			@user_id			= user_id,
			@client_id			= client_id,
			@indicator_id		= indicator_id,
			@interval_seconds	= interval_seconds,
			@threshold_l4		= threshold_l4,
			@threshold_l3		= threshold_l3,
			@threshold_l2		= threshold_l2,
			@threshold_l1		= threshold_l1,
			@enabled			= enabled
		FROM OPENJSON(@json)
		WITH (
				user_id				INT,	
				client_id			INT,
				indicator_id		INT,
				interval_seconds	INT,
				enabled				BIT,
				threshold_l4		DECIMAL,
				threshold_l3		DECIMAL,
				threshold_l2		DECIMAL,
				threshold_l1		DECIMAL
			)
		-- Se devuelven los campos del registro recien creado

		SELECT
			[id]
			,[user_id]
			,[client_id]
			,[indicator_id]
			,[interval_seconds]
			,[enabled]
			,[threshold_l4]
			,[threshold_l3]
			,[threshold_l2]
			,[threshold_l1]
			,[created_at]
			,[update_at]
		FROM [dbo].[tbl_indicators_client_config]
		WHERE
			[user_id]			= CASE WHEN @user_id			IS NULL THEN [user_id]			ELSE @user_id			END AND
			[client_id]			= CASE WHEN @client_id			IS NULL THEN [client_id]		ELSE @client_id			END AND
			[indicator_id]		= CASE WHEN @indicator_id		IS NULL THEN [indicator_id]		ELSE @indicator_id		END AND
			[interval_seconds]	= CASE WHEN @interval_seconds	IS NULL THEN [interval_seconds] ELSE @interval_seconds	END AND
			[threshold_l4]		= CASE WHEN @threshold_l4		IS NULL THEN [threshold_l4]		ELSE @threshold_l4		END AND
			[threshold_l3]		= CASE WHEN @threshold_l3		IS NULL THEN [threshold_l3]		ELSE @threshold_l3		END AND
			[threshold_l2]		= CASE WHEN @threshold_l2		IS NULL THEN [threshold_l2]		ELSE @threshold_l2		END AND
			[threshold_l1]		= CASE WHEN @threshold_l1		IS NULL THEN [threshold_l1]		ELSE @threshold_l1		END AND
			[enabled]			= CASE WHEN @enabled			IS NULL THEN [enabled]			ELSE @enabled			END
	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure arroja una excepción de error
	BEGIN CATCH
		THROW 60000, '{"code":"60202"}', 16;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_indicators_client_config_update]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Cristopher Mora Sánchez
-- Create date: 2023-03-18
-- Description:	Actualiza un registro de la tabla de usuarios con base a la información contenida en el parámetro de tipo JSON
-- =============================================
CREATE PROCEDURE [dbo].[sp_indicators_client_config_update]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id					INT
	DECLARE @user_id			INT
	DECLARE @client_id			INT
	DECLARE @indicator_id		INT
	DECLARE @interval_seconds	INT
	DECLARE @enabled			bit
	DECLARE @threshold_l4		decimal
	DECLARE @threshold_l3		decimal
	DECLARE @threshold_l2		decimal
	DECLARE @threshold_l1		decimal

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
			@id					= id,
			@user_id			= user_id,
			@client_id			= client_id,
			@indicator_id		= indicator_id,
			@interval_seconds	= interval_seconds,
			@threshold_l4		= threshold_l4,
			@threshold_l3		= threshold_l3,
			@threshold_l2		= threshold_l2,
			@threshold_l1		= threshold_l1,
			@enabled			= enabled
		FROM OPENJSON(@json)
		WITH (
				id					INT,
				user_id				INT,	
				client_id			INT,
				indicator_id		INT,
				interval_seconds	INT,
				enabled				BIT,
				threshold_l4		DECIMAL,
				threshold_l3		DECIMAL,
				threshold_l2		DECIMAL,
				threshold_l1		DECIMAL
			)
	
		-- Se actualizan los datos del registro cuyo ID corresponde al ID proveido

		UPDATE [dbo].[tbl_indicators_client_config]
		SET
			[user_id]			= CASE WHEN @user_id			IS NULL THEN [user_id]			ELSE @user_id			END,
			[client_id]			= CASE WHEN @client_id			IS NULL THEN [client_id]		ELSE @client_id			END,
			[indicator_id]		= CASE WHEN @indicator_id		IS NULL THEN [indicator_id]		ELSE @indicator_id		END,
			[interval_seconds]	= CASE WHEN @interval_seconds	IS NULL THEN [interval_seconds] ELSE @interval_seconds	END,
			[threshold_l4]		= CASE WHEN @threshold_l4		IS NULL THEN [threshold_l4]		ELSE @threshold_l4		END,
			[threshold_l3]		= CASE WHEN @threshold_l3		IS NULL THEN [threshold_l3]		ELSE @threshold_l3		END,
			[threshold_l2]		= CASE WHEN @threshold_l2		IS NULL THEN [threshold_l2]		ELSE @threshold_l2		END,
			[threshold_l1]		= CASE WHEN @threshold_l1		IS NULL THEN [threshold_l1]		ELSE @threshold_l1		END,
			[enabled]			= CASE WHEN @enabled			IS NULL THEN [enabled]			ELSE @enabled			END,
			[update_at]			= GETDATE()
		WHERE	
			[id] = @id

		-- Se devuelven los campos del registro recien creado
		UPDATE tbl_clients
		SET push_updates = 1
		WHERE id = @client_id

		SELECT
			[id]
				,[user_id]				
				,[client_id]			
				,[indicator_id]		
				,[interval_seconds]	
				,[enabled]			
				,[threshold_l4]		
				,[threshold_l3]	
				,[threshold_l2]		
				,[threshold_l1]		
				,[created_at]		
				,[update_at]			
		FROM [dbo].[tbl_indicators_client_config]
		WHERE
			[id] = @id
	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure arroja una excepción de error
	BEGIN CATCH
		THROW 60000, '{"code":"60203"}', 16;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_reset_database_tables]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Leiver Espinoza
-- Create date: 2023-02-28
-- Description:	Clears all data from tables and resets the ID fields.
-- Sets up the database to initial defaults values
-- =============================================
CREATE PROCEDURE [dbo].[sp_reset_database_tables]
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM [dbo].[tbl_stats]						DBCC CHECKIDENT ('[dbo].[tbl_stats]', RESEED, 0);
	DELETE FROM [dbo].[tbl_indicators_client_config]	DBCC CHECKIDENT ('[dbo].[tbl_indicators_client_config]', RESEED, 0);
	DELETE FROM [dbo].[tbl_indicators]					DBCC CHECKIDENT ('[dbo].[tbl_indicators]', RESEED, 0);
	DELETE FROM [dbo].[tbl_casting_types]				DBCC CHECKIDENT ('[dbo].[tbl_casting_types]', RESEED, 0);
	DELETE FROM [dbo].[tbl_data_types]					DBCC CHECKIDENT ('[dbo].[tbl_data_types]', RESEED, 0);
	DELETE FROM [dbo].[tbl_clients]						DBCC CHECKIDENT ('[dbo].[tbl_clients]', RESEED, 0);

	DELETE FROM [dbo].[tbl_user_has_roles];				DBCC CHECKIDENT ('[dbo].[tbl_user_has_roles]', RESEED, 0);
	DELETE FROM [dbo].[tbl_role_has_permissions];		DBCC CHECKIDENT ('[dbo].[tbl_role_has_permissions]', RESEED, 0);
	DELETE FROM [dbo].[tbl_user_has_permissions];		DBCC CHECKIDENT ('[dbo].[tbl_user_has_permissions]', RESEED, 0);
	DELETE FROM [dbo].[tbl_sessions];					DBCC CHECKIDENT ('[dbo].[tbl_sessions]', RESEED, 0);

	DELETE FROM [dbo].[tbl_users];						DBCC CHECKIDENT ('[tbl_users]', RESEED, 0);
	DELETE FROM [dbo].[tbl_roles];						DBCC CHECKIDENT ('[dbo].[tbl_roles]', RESEED, 0);
	DELETE FROM [dbo].[tbl_permissions];				DBCC CHECKIDENT ('[dbo].[tbl_permissions]', RESEED, 0);
	DELETE FROM [dbo].[tbl_routes];						DBCC CHECKIDENT ('[dbo].[tbl_routes]', RESEED, 0);

	INSERT INTO [dbo].[tbl_roles]
			([name]
			,[guard_name]
			,[display_order]
			,[enabled])
		VALUES
			('Administradores'		-- ID: 1
			,'administrator'
			,1
			,1)
			,('Super Usuarios'		-- ID: 2
			,'super_users'
			,2
			,1)
			,('Usuarios'			-- ID: 3
			,'users'
			,3
			,1)
			,('Servicios'			-- ID: 4
			,'service'
			,4
			,1)

	INSERT INTO [dbo].[tbl_users]
			([name_first]
			,[name_last]
			,[email]
			,[username]
			,[password]
			,[enabled])
		VALUES
			('system'				-- ID: 1
			,'administrator'
			,'administrator@toolsformyjob.com'
			,'administrator'
			,HASHBYTES('SHA2_512', 'administrator')
			,1)
			,('super'				-- ID: 2
			,'user'
			,'super.user@toolsformyjob.com'
			,'super.user'
			,HASHBYTES('SHA2_512', 'super.user')
			,1)
			,('user'				-- ID: 3
			,''
			,'user@toolsformyjob.com'
			,'user'
			,HASHBYTES('SHA2_512', 'user')
			,1)
			,('service'				-- ID: 4
			,'client'
			,'service.client@toolsformyjob.com'
			,'remote_client'
			,HASHBYTES('SHA2_512', 'remote_client')
			,1)
			,('Leiver'				-- ID: 5
			,'Espinoza'
			,'leiver@toolsformyjob.com'
			,'leiver'
			,HASHBYTES('SHA2_512', 'leiver')
			,1)
			,('Esteban'				-- ID: 6
			,'Siles'
			,'esteban.siles@toolsformyjob.com'
			,'esteban'
			,HASHBYTES('SHA2_512', 'esteban')
			,1)
			,('Alfonso'				-- ID: 7
			,'Loaiza'
			,'alfonso.loaiza@toolsformyjob.com'
			,'alfonso'
			,HASHBYTES('SHA2_512', 'alfonso')
			,1)
			,('Cristopher'			-- ID: 8
			,'Mora'
			,'cristopher.mora@toolsformyjob.com'
			,'cristopher'
			,HASHBYTES('SHA2_512', 'cristopher')
			,1)
			,('Kevin'				-- ID: 9
			,'Corrales'
			,'kevin.corrales@toolsformyjob.com'
			,'kevin'
			,HASHBYTES('SHA2_512', 'kevin')
			,1)
			,('Ricardo'				-- ID: 10
			,'Jimenez'
			,'ricardo.jimenez@toolsformyjob.com'
			,'ricardo'
			,HASHBYTES('SHA2_512', 'ricardo')
			,1)
			,('Lenin'				-- ID: 11
			,'Ortega'
			,'lortega@edu.upolitecnica.cr'
			,'lenin'
			,HASHBYTES('SHA2_512', 'lenin')
			,1)
			,('PowerBI'
			,'Client'
			,'powerbi@toolsformyjob.com'
			,'powerbi'
			,HASHBYTES('SHA2_512', 'powerbi')
			,1)


	INSERT INTO [dbo].[tbl_routes]
			([name]
			,[display_order]
			,[enabled])
		VALUES
			('Tareas de Sistema',1,1)
			,('Usuarios',2,1)
			,('Monitoreo',3,1)
			,('Clientes',4,1)
			,('Estadísticas',5,1)
			,('Configuración de estadísticas a clientes',6,1)

	INSERT INTO [dbo].[tbl_permissions]
		([route_id]
		,[name]
		,[guard_name]
		,[display_order]
		,[enabled])
	VALUES
		(1,'Autenticar usando el portal web','login_web',1,1)
		,(1,'Autenticar como servicio sin contraseña','login_service',2,1)
		,(2,'Crear usuarios','users_create',1,1)
		,(2,'Ver usuarios','users_read',2,1)
		,(2,'Listar usuarios','users_read_all',3,1)
		,(2,'Actualizar usuarios','users_update',4,1)
		,(2,'Eliminar usuarios','users_delete',5,1)
		,(3,'Crear configuración de monitoreo','monitoring_create',1,1)
		,(3,'Ver configuración de monitoreo','monitoring_read',2,1)
		,(3,'Listar configuración de monitoreo','monitoring_read_all',3,1)
		,(3,'Actualizar configuración de monitoreo','monitoring_update',4,1)
		,(3,'Eliminar configuración de monitoreo','monitoring_delete',5,1)
		,(4,'Crear clientes','clients_create',1,1)
		,(4,'Ver clientes','clients_read',2,1)
		,(4,'Listar clientes','clients_read_all',3,1)
		,(4,'Actualizar clientes','clients_update',4,1)
		,(4,'Eliminar clientes','clients_delete',5,1)
		,(5,'Crear estadísticas','stats_create',1,1)										-- ID: 18
		,(5,'Ver estadísticas','stats_read',2,1)
		,(5,'Listar estadísticas','stats_read_all',3,1)
		,(5,'Actualizar estadísticas','stats_update',4,1)
		,(5,'Eliminar estadísticas','stats_delete',5,1)
		,(6,'Asignar estadísticas a clientes','stats_assign_create',1,1)
		,(6,'Ver estadísticas asignadas a clientes','stats_assign_read',2,1)
		,(6,'Listar estadísticas asignadas a clientes','stats_assign_read_all',3,1)
		,(6,'Actualizar estadísticas asignadas a clientes','stats_assign_update',4,1)
		,(6,'Eliminar estadísticas asignadas a clientes','stats_assign_delete',5,1)
		
	INSERT INTO [dbo].[tbl_user_has_roles]
			([user_id]
			,[role_id])
		VALUES
			(1,1)
			,(2,2)
			,(3,3)
			,(4,4)
			,(5,1)
			,(6,1)
			,(7,1)
			,(8,1)
			,(9,1)
			,(10,1)
			,(11,1)
			,(12,3)

	INSERT INTO [dbo].[tbl_role_has_permissions]
			([role_id]
			,[permission_id])
		VALUES
			(1, 1),
			(1, 3),
			(1, 4),
			(1, 5),
			(1, 6),
			(1, 7),
			(1, 8),
			(1, 9),
			(1, 10),
			(1, 11),
			(1, 12),
			(1, 13),
			(1, 14),
			(1, 15),
			(1, 16),
			(1, 17),
			(1, 18),
			(1, 19),
			(1, 20),
			(1, 21),
			(1, 22),
			(1, 23),
			(1, 24),
			(1, 25),
			(1, 26),
			(1, 27),
			(2, 1),
			(2, 4),
			(2, 5),
			(2, 8),
			(2, 9),
			(2, 10),
			(2, 11),
			(2, 12),
			(2, 13),
			(2, 14),
			(2, 15),
			(2, 16),
			(2, 17),
			(2, 18),
			(2, 19),
			(2, 20),
			(2, 21),
			(2, 22),
			(2, 23),
			(2, 24),
			(2, 25),
			(2, 26),
			(2, 27),
			(3, 1),
			(3, 9),
			(3, 10),
			(3, 13),
			(3, 14),
			(3, 15),
			(3, 19),
			(3, 20),
			(3, 24),
			(3, 25),
			(4, 2),
			(4, 18)

	INSERT INTO [dbo].[tbl_data_types]
			([name])
		VALUES
			('VARCHAR')
			,('DATETIME')
			,('INT')
			,('DECIMAL')
			,('BIGINT')

	INSERT INTO [dbo].[tbl_casting_types]
			(data_type_id
			,name
			,format_driver)
		VALUES
			(1,'Text','@')
			,(2,'Date and Time','yyyy-MM-dd hh:mm:ss')
			,(3,'Number (0 decimals)','0')
			,(4,'Number (2 decimals)','0.00')

	INSERT INTO [dbo].[tbl_indicators]
			([name]
			,[indicator_key]
			,[higher_the_best]
			,[description]
			,[sort_order]
			,[enabled]
			,[casting_type_id])
		VALUES
			('Platform Name','platform_name',null,'Returns the name of the operating system running in the equipment.',1,1,1)
			,('Boot Time','boot_time',null,'Return the system boot time expressed in seconds since the epoch.',2,1,2)
			,('Time Since Boot','time_since_boot',null,'Returns the days and time duration since the computer waas booted last.',3,1,1)
			,('CPU Count','cpu_count',null,'Returns the number of logical CPUs in the system',4,1,3)
			,('CPU Freq Min','cpu_freq_min',null,'Is a function that returns the minimum frequency of the CPU on the system .',5,1,3)
			,('CPU Freq Current','cpu_freq_current',1,'Is a function that returns the current frequency of the CPU on the system .',6,1,3)
			,('CPU Freq Max','cpu_freq_max',null,'Is a function that returns the maximum frequency of the CPU on the system .',7,1,3)
			,('CPU Perc','cpu_perc',0,'Is a function that returns the percentage of CPU utilization on the system .',8,1,4)
			,('Memory Total in MB','memory_total_mb',null,'Is a function that returns the total physical memory (RAM) available on the system in MB.',9,1,4)
			,('Memory Available in MB','memory_available_mb',1,'Is a function that returns the amount of available physical memory (RAM) on the system in MB.',10,1,4)
			,('Memory Perc Used','memory_perc_used',0,'Is a function that returns the percentage of physical memory used on the system in MB.',11,1,4)
			,('Memory Used in MB','memory_used_mb',0,'Is a function that returns the amount of physical memory (RAM) currently in use by applications and the operating system in MB.',12,1,4)
			,('Memory Free in MB','memory_free_mb',1,'Is a function that returns the total physical memory (RAM) free on the system in MB.',13,1,4)
			,('Battery Percent','battery_percent',1,'Is a function that returns the percentage of battery charge in a system that has one.',14,0,4)
			,('Battery Power Plugged','battery_power_plugged',null,'Is a function that returns a boolean indicating whether the system battery is currently being charged.',15,0,4)
			,('Disk Read Count','disk_read_count',null,'Is a function that returns the number of reads from disks on the system since the system was last rebooted.',16,1,3)
			,('Disk Write Count','disk_write_count',null,'Is a function that returns the number of writes to disks on the system since the system was last rebooted.',17,1,3)
			,('Disk Read Bytes','disk_read_bytes',null,'Is a function that returns the number of bytes read from disks on the system since the system was last rebooted in bytes.',18,1,3)
			,('Disk Write Bytes','disk_write_bytes',null,'Is a function that returns the number of bytes written to disks on the system since the system was last rebooted in bytes.',19,1,3)
			,('Disk Read Time','disk_read_time',null,'Is a function that returns the amount of time that the system has spent reading from disks since the system was last rebooted in bytes.',20,1,3)
			,('Disk Write Time','disk_write_time',null,'Is a function that returns the time that the system has spent writing to disks since the last system reboot in bytes.',21,1,3)
			,('Disk Space Total in MB','disk_space_total_mb',null,'Is a function that returns the total disk space of a particular disk partition in megabytes (MB). ',22,1,3)
			,('Disk Space Used in MB','disk_space_used_mb',0,'Is a function that returns the disk space used by a disk partition in megabytes (MB).',23,1,4)
			,('Disk Space Free in MB','disk_space_free_mb',1,'Is a function that returns the amount of free disk space available in a disk partition in megabytes (MB).',24,1,4)
			,('Disk Space Percent','disk_space_percent',0,'Is a function that returns the percentage of disk space usage in a partition.',25,1,4)
			,('Disk Space 0 Total in MB','disk0_space_total_mb',null,'Is a function that returns the total disk space of a particular disk partition in megabytes (MB) (Disk 0).',26,0,3)
			,('Disk Space 0 Used in MB','disk0_space_used_mb',0,'Is a function that returns the disk space used by a disk partition in megabytes (MB) (Disk 0).',27,0,4)
			,('Disk Space 0 Free in MB','disk0_space_free_mb',1,'Is a function that returns the amount of free disk space available in a disk partition in megabytes (MB) (Disk 0).',28,0,4)
			,('Disk Space 0 Percent','disk0_space_percent',0,'Is a function that returns the percentage of disk space usage in a partition (Disk 0).',29,0,4)
			,('Disk Space 1 Total in MB','disk1_space_total_mb',null,'Is a function that returns the total disk space of a particular disk partition in megabytes (MB) (Disk 1).',30,0,3)
			,('Disk Space 1 Used in MB','disk1_space_used_mb',0,'Is a function that returns the disk space used by a disk partition in megabytes (MB) (Disk 1).',31,0,4)
			,('Disk Space 1 Free in MB','disk1_space_free_mb',1,'Is a function that returns the amount of free disk space available in a disk partition in megabytes (MB) (Disk 1).',32,0,4)
			,('Disk Space 1 Percent','disk1_space_percent',0,'Is a function that returns the percentage of disk space usage in a partition (Disk 1).',33,0,4)
			,('Disk Space 2 Total in MB','disk2_space_total_mb',null,'Is a function that returns the total disk space of a particular disk partition in megabytes (MB) (Disk 2).',34,0,3)
			,('Disk Space 2 Used in MB','disk2_space_used_mb',0,'Is a function that returns the disk space used by a disk partition in megabytes (MB) (Disk 2).',35,0,4)
			,('Disk Space 2 Free in MB','disk2_space_free_mb',1,'Is a function that returns the amount of free disk space available in a disk partition in megabytes (MB) (Disk 2).',36,0,4)
			,('Disk Space 2 Percent','disk2_space_percent',0,'Is a function that returns the percentage of disk space usage in a partition (Disk 2).',37,0,4)
			,('Disk Space 3 Total in MB','disk3_space_total_mb',null,'Is a function that returns the total disk space of a particular disk partition in megabytes (MB) (Disk 3).',38,0,3)
			,('Disk Space 3 Used in MB','disk3_space_used_mb',0,'Is a function that returns the disk space used by a disk partition in megabytes (MB) (Disk 3).',39,0,4)
			,('Disk Space 3 Free in MB','disk3_space_free_mb',1,'Is a function that returns the amount of free disk space available in a disk partition in megabytes (MB) (Disk 3).',40,0,4)
			,('Disk Space 3 Percent','disk3_space_percent',0,'Is a function that returns the percentage of disk space usage in a partition (Disk 3).',41,0,4)
			,('Disk Space 4 Total in MB','disk4_space_total_mb',null,'Is a function that returns the total disk space of a particular disk partition in megabytes (MB) (Disk 4).',42,0,3)
			,('Disk Space 4 Used in MB','disk4_space_used_mb',0,'Is a function that returns the disk space used by a disk partition in megabytes (MB) (Disk 4).',43,0,4)
			,('Disk Space 4 Free in MB','disk4_space_free_mb',1,'Is a function that returns the amount of free disk space available in a disk partition in megabytes (MB) (Disk 4).',44,0,4)
			,('Disk Space 4 Percent','disk4_space_percent',0,'Is a function that returns the percentage of disk space usage in a partition (Disk 4).',45,0,4)
			,('Disk Space 5 Total in MB','disk5_space_total_mb',null,'Is a function that returns the total disk space of a particular disk partition in megabytes (MB) (Disk 5).',46,0,3)
			,('Disk Space 5 Used in MB','disk5_space_used_mb',0,'Is a function that returns the disk space used by a disk partition in megabytes (MB) (Disk 5).',47,0,4)
			,('Disk Space 5 Free in MB','disk5_space_free_mb',1,'Is a function that returns the amount of free disk space available in a disk partition in megabytes (MB) (Disk 5).',48,0,4)
			,('Disk Space 5 Percent','disk5_space_percent',0,'Is a function that returns the percentage of disk space usage in a partition (Disk 5).',49,0,4)

	SELECT * FROM [dbo].[tbl_sessions]
	SELECT * FROM [dbo].[tbl_users]
	SELECT * FROM [dbo].[tbl_roles]
	SELECT * FROM [dbo].[tbl_permissions]
	SELECT * FROM [dbo].[tbl_routes]
	SELECT * FROM [dbo].[tbl_user_has_roles]
	SELECT * FROM [dbo].[tbl_role_has_permissions]
	SELECT * FROM [dbo].[tbl_user_has_permissions]
	SELECT * FROM [dbo].[tbl_data_types]
	SELECT * FROM [dbo].[tbl_casting_types]
	SELECT * FROM [dbo].[tbl_indicators]
	SELECT * FROM [dbo].[tbl_stats]
	SELECT * FROM [dbo].[tbl_clients]
	SELECT * FROM [dbo].[tbl_indicators_client_config]
END
GO
/****** Object:  StoredProcedure [dbo].[sp_stats_create]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Cristopher Mora Sánchez
-- Create date: 2023-03-18
-- Description:	Inserta un nuevo registro dentro de la tabla dbo.tbl_stats
-- =============================================
CREATE PROCEDURE [dbo].[sp_stats_create]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id				        INT
	DECLARE @client_mac_address		VARCHAR(17)
	DECLARE @indicator_key			VARCHAR(30)
	DECLARE @ipaddress				VARCHAR(16)
	DECLARE @value					VARCHAR(15)
	DECLARE @reported_datetime		Datetime


	-- Asignación de los valores del JSON a las variables del Stored Procedure
	SELECT
		@client_mac_address		 = CASE WHEN TRIM(client_mac_address)	= '' THEN NULL ELSE TRIM(client_mac_address)	END,
		@indicator_key		     = CASE WHEN TRIM(indicator_key)		= '' THEN NULL ELSE TRIM(indicator_key)			END,
		@ipaddress		         = CASE WHEN TRIM(ipaddress)			= '' THEN NULL ELSE TRIM(ipaddress)				END,
		@value		             = CASE WHEN TRIM(value)	         	= '' THEN NULL ELSE TRIM(value)					END,
		@reported_datetime		 = CASE WHEN reported_datetime			= '' THEN NULL ELSE reported_datetime			END

	FROM OPENJSON(@json)
		WITH (
			client_mac_address	VARCHAR(17),
			indicator_key		VARCHAR(30),
			ipaddress			VARCHAR(16),
			value				VARCHAR(15),
			reported_datetime	Datetime
				)

	-- Las siguientes lineas se agregan para realizar pruebas en vivo y facilitar la demostración, pero el
	-- método correctoes que cada cliente debe ser previamente registrado en el sistema para así, poder aceptar
	-- sus entradas.

	-- [ INICIO DE BLOQUE NECESARIO PARA DEMOSTRACION ]
	-- En caso de ser un cliente nuevo, lo registra como desconocido, pero permite la insertar el registro
	IF NOT EXISTS(SELECT mac_address FROM tbl_clients WHERE mac_address = @client_mac_address)
	BEGIN
		DECLARE @client_id INT

		INSERT INTO [dbo].[tbl_clients]
				([mac_address]
				,[netbios_name]
				,[friendly_name]
				,[push_updates]
				,[enabled])
			VALUES
				(@client_mac_address
				,'New_Device'
				,'Unknown - ' + CONVERT(VARCHAR,GETDATE(),120)
				,0
				,1)

		-- Se toma el ID del último registro que se creó
		SELECT @client_id = SCOPE_IDENTITY()

		INSERT INTO [dbo].[tbl_indicators_client_config]
				([user_id]
				,[client_id]
				,[indicator_id]
				,[interval_seconds]
				,[enabled])
			VALUES
				(4,@client_id,1,86400,1)
				,(4,@client_id,2,86400,1)
				,(4,@client_id,3,86400,1)
				,(4,@client_id,4,86400,1)
				,(4,@client_id,5,3600,1)
				,(4,@client_id,6,3600,1)
				,(4,@client_id,7,3600,1)
				,(4,@client_id,8,15,1)
				,(4,@client_id,9,15,1)
				,(4,@client_id,10,15,1)
				,(4,@client_id,11,15,1)
				,(4,@client_id,12,15,1)
				,(4,@client_id,13,15,1)
				,(4,@client_id,14,300,1)
				,(4,@client_id,15,5,1)
				,(4,@client_id,16,5,1)
				,(4,@client_id,17,5,1)
				,(4,@client_id,18,5,1)
				,(4,@client_id,19,5,1)
				,(4,@client_id,20,5,1)
				,(4,@client_id,21,5,1)
				,(4,@client_id,22,5,1)
				,(4,@client_id,23,5,1)
				,(4,@client_id,24,5,1)
				,(4,@client_id,25,5,1)
				,(4,@client_id,26,5,0)
				,(4,@client_id,27,5,0)
				,(4,@client_id,28,5,0)
				,(4,@client_id,29,5,0)
				,(4,@client_id,30,5,0)
				,(4,@client_id,31,5,0)
				,(4,@client_id,32,5,0)
				,(4,@client_id,33,5,0)
				,(4,@client_id,34,5,0)
				,(4,@client_id,35,5,0)
				,(4,@client_id,36,5,0)
				,(4,@client_id,37,5,0)
				,(4,@client_id,38,5,0)
				,(4,@client_id,39,5,0)
				,(4,@client_id,40,5,0)
				,(4,@client_id,41,5,0)
				,(4,@client_id,42,5,0)
				,(4,@client_id,43,5,0)
				,(4,@client_id,44,5,0)
				,(4,@client_id,45,5,0)
				,(4,@client_id,46,5,0)
				,(4,@client_id,47,5,0)
				,(4,@client_id,48,5,0)
				,(4,@client_id,49,5,0)
	END
	-- [ FIN DE BLOQUE NECESARIO PARA DEMOSTRACION ]

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		DECLARE @pushUpdates AS BIT
		SET @pushUpdates = (SELECT push_updates FROM tbl_clients WHERE mac_address = @client_mac_address)
		
		INSERT INTO [dbo].[tbl_stats]
				([client_mac_address]
				,[indicator_key]
				,[ipaddress]
				,[value]
				,[reported_datetime]
				)
			VALUES
				(@client_mac_address
				,@indicator_key
				,@ipaddress
				,@value
				,@reported_datetime)
				

		-- Se toma el ID del último registro que se creó
		SELECT @id = SCOPE_IDENTITY()

		-- Se devuelven los campos del registro recien creado
		SELECT
			@pushUpdates AS [pull_updates]
		    ,[id]
			,[client_mac_address]
			,[indicator_key]
			,[ipaddress]
			,[value]
			,[reported_datetime]
			
		FROM [dbo].[tbl_stats] WHERE id = @id
	END TRY

	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		  SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_STATE() AS ErrorState,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_stats_delete]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_stats_delete]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id				INT

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
			@id = id
		FROM OPENJSON(@json)
			WITH (
				id		INT
				)

		IF EXISTS(SELECT * FROM [dbo].[tbl_stats] WHERE id = @id)
		BEGIN
			-- Eliminación del registro seleccionado
			DELETE FROM [dbo].[tbl_stats] WHERE id = @id
		END
		ELSE
		BEGIN;
			THROW 60000, '{"code":"60304"}', 16;
		END
	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_stats_read]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Cristopher Mora Sánchez
-- Create date: 2023-03-18
-- Description:	Retorna el usuario que tenga el ID igual al valor especificado en el JSON
-- =============================================
CREATE PROCEDURE [dbo].[sp_stats_read]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id				INT

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
			@id = id
		FROM OPENJSON(@json)
			WITH (
				id		INT
				)
	
		-- Se devuelven los campos del registro recien creado
		SELECT
			 [id]
			,[client_mac_address]
			,[indicator_key]
			,[ipaddress]
			,[value]
			,[reported_datetime]
		FROM [dbo].[tbl_stats] WHERE id = @id
	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		THROW 60000, '{"code":"60302"}', 16;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_stats_read_all]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Cristopher Mora Sánchez
-- Create date: 2023-03-18
-- Description:	Retorna la lista completa de usuarios que cumplan con los parámetros en el parámetro de tipo JSON
-- =============================================
CREATE PROCEDURE [dbo].[sp_stats_read_all]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON

	DECLARE @client_mac_address		VARCHAR(17)
	DECLARE @indicator_key			VARCHAR(30)
	DECLARE @ipaddress				VARCHAR(16)
	DECLARE @value					VARCHAR(15)
	DECLARE @reported_datetime		Datetime

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
		@client_mac_address		 = CASE WHEN TRIM(client_mac_address)	= '' THEN NULL ELSE TRIM(client_mac_address)	END,
		@indicator_key		     = CASE WHEN TRIM(indicator_key)		= '' THEN NULL ELSE TRIM(indicator_key)			END,
		@ipaddress		         = CASE WHEN TRIM(ipaddress)			= '' THEN NULL ELSE TRIM(ipaddress)				END,
		@value		             = CASE WHEN TRIM(value)	         	= '' THEN NULL ELSE TRIM(value)					END,
		@reported_datetime		 = CASE WHEN reported_datetime			= '' THEN NULL ELSE reported_datetime			END
		FROM OPENJSON(@json)
			WITH (
			client_mac_address	VARCHAR(17),
			indicator_key		VARCHAR(30),
			ipaddress			VARCHAR(16),
			value				VARCHAR(15),
			reported_datetime	Datetime
				)
	
		-- Se devuelven los campos del registro recien creado

		SELECT
			 [id]
			,[client_mac_address]
			,[indicator_key]
			,[ipaddress]
			,[value]
			,[reported_datetime]
		FROM [dbo].[tbl_stats]
		WHERE
			[client_mac_address]	LIKE	CASE WHEN @client_mac_address IS NULL      	THEN '%%'						ELSE '%' + @client_mac_address + '%'	END AND
			[indicator_key]			LIKE	CASE WHEN @indicator_key IS NULL	        THEN '%%'						ELSE '%' + @indicator_key + '%'			END AND
			[ipaddress]				LIKE	CASE WHEN @ipaddress IS NULL				THEN '%%'						ELSE '%' + @ipaddress + '%'				END AND
			[value]					LIKE    CASE WHEN @value	IS NULL				   	THEN '%%'						ELSE '%' + @value + '%'					END AND
			[reported_datetime]		=		CASE WHEN @reported_datetime IS NULL		THEN [reported_datetime]     	ELSE @reported_datetime					END
	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		THROW 60000, '{"code":"60303"}', 16;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_users_create]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Leiver Espinoza
-- Create date: 2023-02-28
-- Description:	Inserta un nuevo registro dentro de la tabla dbo.tbl_users
-- =============================================
CREATE PROCEDURE [dbo].[sp_users_create]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id				INT
	DECLARE @name_first		VARCHAR(25)
	DECLARE @name_last		VARCHAR(25)
	DECLARE @email			VARCHAR(50)
	DECLARE @username		VARCHAR(15)
	DECLARE @password		VARCHAR(64)
	DECLARE @enabled		BIT

	-- Asignación de los valores del JSON a las variables del Stored Procedure
	SELECT
		@name_first		= CASE WHEN TRIM(name_first)	= '' THEN NULL ELSE TRIM(name_first)	END,
		@name_last		= CASE WHEN TRIM(name_last)		= '' THEN NULL ELSE TRIM(name_last)		END,
		@email			= CASE WHEN TRIM(email)			= '' THEN NULL ELSE TRIM(email)			END,
		@username		= CASE WHEN TRIM(username)		= '' THEN NULL ELSE TRIM(username)		END,
		@password		= CASE WHEN TRIM(password)		= '' THEN NULL ELSE TRIM(password)		END,
		@enabled		= enabled
	FROM OPENJSON(@json)
		WITH (
			name_first		VARCHAR(25),
			name_last		VARCHAR(25),
			email			VARCHAR(50),
			username		VARCHAR(15),
			password		VARCHAR(64),
			enabled			BIT
			)
	
	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		INSERT INTO [dbo].[tbl_users]
				([name_first]
				,[name_last]
				,[email]
				,[username]
				,[password]
				,[enabled])
			VALUES
				(@name_first
				,@name_last
				,@email
				,@username
				,HASHBYTES('SHA2_512', @password)
				,@enabled)

		-- Se toma el ID del último registro que se creó
		SELECT @id = SCOPE_IDENTITY()

		-- Se devuelven los campos del registro recien creado
		SELECT
			[id]
			,[name_first]
			,[name_last]
			,[email]
			,[username]
			,[enabled]
			,[created_at]
			,[updated_at]
		FROM [dbo].[tbl_users] WHERE id = @id
	END TRY

	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		THROW 60000, '{"code":"60001"}', 16;;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_users_delete]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_users_delete]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id				INT

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
			@id = id
		FROM OPENJSON(@json)
			WITH (
				id		INT
				)

		IF EXISTS(SELECT * FROM [dbo].[tbl_users] WHERE id = @id)
		BEGIN
			-- Eliminación del registro seleccionado
			DELETE FROM [dbo].[tbl_users] WHERE id = @id
		END
		ELSE
		BEGIN;
			THROW 60000, '{"code":"60004"}', 16;
		END
	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_users_login]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_users_login]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Necesario para saber si hay transacciones pendientes en la tabla que se está editando
	DECLARE @trancount		INT
	set @trancount = @@trancount

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id				INT
	DECLARE @username		VARCHAR(15)
	DECLARE @password		VARCHAR(64)

	-- Asignación de los valores del JSON a las variables del Stored Procedure
	SELECT
		@username		= CASE WHEN TRIM(username)		= '' THEN NULL ELSE TRIM(username)		END,
		@password		= CASE WHEN TRIM(password)		= '' THEN NULL ELSE TRIM(password)		END
	FROM OPENJSON(@json)
		WITH (
			username		VARCHAR(15),
			password		VARCHAR(64)
			)

	-- Prueba de ejecución de la acción principal del Stored Procedure
		IF CASE WHEN EXISTS(SELECT id FROM [dbo].[tbl_users]
							WHERE
							[tbl_users].username = @username
							AND [tbl_users].password = HASHBYTES('SHA2_512', @password)
							)
				THEN 1
				ELSE 0 END = 1
		BEGIN
			BEGIN TRY
			--Eliminación de cualquier otra sesion activa
			UPDATE [dbo].[tbl_sessions]
				SET enabled = CAST(0 AS BIT)
				WHERE
					user_id = (SELECT id FROM tbl_users WHERE username = @username)
					AND enabled = CAST(1 AS BIT)

			--Creación de un nuevo token para la nueva sesión
			INSERT INTO [dbo].[tbl_sessions]
					([user_id]
					,[token_value]
					,[enabled])
				VALUES
					((SELECT id FROM tbl_users WHERE username = @username)
					,NEWID()
					,1)
			COMMIT;
			SELECT @id = SCOPE_IDENTITY()

			--Se devuelven los campos del registro recien creado
			SELECT
				[token_value] AS Token
			FROM [dbo].[tbl_sessions] WHERE id = @id
			END TRY

			--En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure arroja una excepción de error
			BEGIN CATCH
				THROW 59000, '{"code":"59001"}', 16;;
			END CATCH
		END
		ELSE
		BEGIN;
			THROW 59000, '{"code":"59002"}', 16;
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_users_logout]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
SELECT * FROM tbl_users
select * from tbl_sessions where enabled = 1 and user_id != 4
EXEC [dbo].[sp_users_logout] @json = '{"token_owner":"alfonso", "token_value":"xxxxxxx"}'

*/
CREATE PROCEDURE [dbo].[sp_users_logout]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Necesario para saber si hay transacciones pendientes en la tabla que se está editando
	DECLARE @trancount		INT
	set @trancount = @@trancount

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id				INT
	DECLARE @token_owner		VARCHAR(15)
	DECLARE @token_value		VARCHAR(64)

	-- Asignación de los valores del JSON a las variables del Stored Procedure
	SELECT
		@token_owner		= CASE WHEN TRIM(token_owner)		= '' THEN NULL ELSE TRIM(token_owner)		END,
		@token_value		= CASE WHEN TRIM(token_value)		= '' THEN NULL ELSE TRIM(token_value)		END
	FROM OPENJSON(@json)
		WITH (
			token_owner		VARCHAR(15),
			token_value 	VARCHAR(64)
			)

	-- Prueba de ejecución de la acción principal del Stored Procedure
		IF CASE WHEN EXISTS(SELECT tbl_sessions.id
							FROM [dbo].tbl_sessions
							LEFT JOIN tbl_users ON tbl_sessions.user_id = tbl_users.id
							WHERE
								[tbl_users].username = @token_owner
								AND tbl_sessions.token_value = @token_value
								AND tbl_sessions.enabled = 1)
				THEN 1
				ELSE 0 END = 1
		BEGIN
			BEGIN TRY
			--Eliminación de cualquier otra sesion activa

			UPDATE [dbo].[tbl_sessions]
				SET enabled = CAST(0 AS BIT)
				WHERE
					user_id = (SELECT id FROM tbl_users WHERE username = @token_owner)
					AND token_value = @token_value
					AND enabled = CAST(1 AS BIT)

			--Se devuelven los campos del registro recien creado
			SELECT 'User logged out' AS 'Status'

			END TRY

			--En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure arroja una excepción de error
			BEGIN CATCH
				THROW 59000, '{"code":"59001"}', 16;;
			END CATCH
		END
		ELSE
		BEGIN;
			THROW 59000, '{"code":"59002"}', 16;
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_users_read]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Leiver Espinoza
-- Create date: 2023-03-01
-- Description:	Retorna el usuario que tenga el ID igual al valor especificado en el JSON
-- =============================================
CREATE PROCEDURE [dbo].[sp_users_read]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id				INT

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
			@id = id
		FROM OPENJSON(@json)
			WITH (
				id		INT
				)
	
		-- Se devuelven los campos del registro recien creado
		SELECT
			[id]
			,[name_first]
			,[name_last]
			,[email]
			,[username]
			,[enabled]
			,[created_at]
			,[updated_at]
		FROM [dbo].[tbl_users] WHERE id = @id
	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		THROW 60000, '{"code":"60002"}', 16;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_users_read_all]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Leiver Espinoza
-- Create date: 2023-03-01
-- Description:	Retorna la lista completa de usuarios que cumplan con los parámetros en el parámetro de tipo JSON
-- =============================================
CREATE PROCEDURE [dbo].[sp_users_read_all]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @name_first		VARCHAR(25)
	DECLARE @name_last		VARCHAR(25)
	DECLARE @email			VARCHAR(50)
	DECLARE @username		VARCHAR(15)
	DECLARE @enabled		BIT

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
			@name_first = name_first,
			@name_last = name_last,
			@email = email,
			@username = username,
			@enabled = enabled
		FROM OPENJSON(@json)
			WITH (
				name_first		VARCHAR(25),
				name_last		VARCHAR(25),
				email			VARCHAR(50),
				username		VARCHAR(15),
				enabled			BIT
				)
	
		-- Se devuelven los campos del registro recien creado

		SELECT
			[id]
			,[name_first]
			,[name_last]
			,[email]
			,[username]
			,[enabled]
			,[created_at]
			,[updated_at]
		FROM [dbo].[tbl_users]
		WHERE
			[name_first]	LIKE	CASE WHEN @name_first IS NULL	THEN '%%'		ELSE '%' + @name_first + '%'	END AND
			[name_last]		LIKE	CASE WHEN @name_last IS NULL	THEN '%%'		ELSE '%' + @name_last + '%'		END AND
			[email]			LIKE	CASE WHEN @email IS NULL		THEN '%%'		ELSE '%' + @email + '%'			END AND
			[username]		LIKE	CASE WHEN @username	IS NULL		THEN '%%'		ELSE '%' + @username + '%'		END AND
			[enabled]		=		CASE WHEN @enabled IS NULL		THEN [enabled]	ELSE @enabled					END
	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		THROW 60000, '{"code":"60002"}', 16;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_users_update]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Leiver Espinoza
-- Create date: 2023-03-01
-- Description:	Actualiza un registro de la tabla de usuarios con base a la información contenida en el parámetro de tipo JSON
-- =============================================
CREATE PROCEDURE [dbo].[sp_users_update]
	@json varchar(max) = ''
AS
BEGIN
	-- Configuraciones necesarias para la salida del resultado correcto
	SET XACT_ABORT ON
	SET NOCOUNT ON

	-- Declaración de las variables que van a tomar los datos de la variable JSON
	DECLARE @id				INT
	DECLARE @name_first		VARCHAR(25)
	DECLARE @name_last		VARCHAR(25)
	DECLARE @email			VARCHAR(50)
	DECLARE @username		VARCHAR(15)
	DECLARE @enabled		BIT

	-- Prueba de ejecución de la acción principal del Stored Procedure
	BEGIN TRY
		-- Asignación de los valores del JSON a las variables del Stored Procedure
		SELECT
			@id = id,
			@name_first		= CASE WHEN TRIM(name_first)	= '' THEN NULL ELSE TRIM(name_first)	END,
			@name_last		= CASE WHEN TRIM(name_last)		= '' THEN NULL ELSE TRIM(name_last)		END,
			@email			= CASE WHEN TRIM(email)			= '' THEN NULL ELSE TRIM(email)			END,
			@username		= CASE WHEN TRIM(username)		= '' THEN NULL ELSE TRIM(username)		END,
			@enabled = enabled
		FROM OPENJSON(@json)
			WITH (
				id				INT,
				name_first		VARCHAR(25),
				name_last		VARCHAR(25),
				email			VARCHAR(50),
				username		VARCHAR(15),
				enabled			BIT
				)
	
		-- Se actualizan los datos del registro cuyo ID corresponde al ID proveido

		UPDATE [dbo].[tbl_users]
		SET
			[name_first]	=	CASE WHEN @name_first IS NULL	THEN [name_first]	ELSE @name_first	END,
			[name_last]		=	CASE WHEN @name_last IS NULL	THEN [name_last]	ELSE @name_last		END,
			[email]			=	CASE WHEN @email IS NULL		THEN [email]		ELSE @email			END,
			[username]		=	CASE WHEN @username	IS NULL		THEN [username]		ELSE @username		END,
			[enabled]		=	CASE WHEN @enabled IS NULL		THEN [enabled]		ELSE @enabled		END,
			[updated_at]	=	GETDATE()
		WHERE	
			[id] = @id

		-- Se devuelven los campos del registro recien creado

		SELECT
			[id]
			,[name_first]
			,[name_last]
			,[email]
			,[username]
			,[enabled]
			,[created_at]
			,[updated_at]
		FROM [dbo].[tbl_users]
		WHERE
			[id] = @id
	END TRY
	-- En caso de que alguna de las sentencias dentro del TRY dieran error, el Stored Procedure aroja una excepción de error
	BEGIN CATCH
		THROW 60000, '{"code":"60003"}', 16;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_validate_has_permission_token]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_validate_has_permission_token] 
	@json varchar(max) = ''
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @username		VARCHAR(15)
	DECLARE @token_value	VARCHAR(36)
	DECLARE @guard_name		VARCHAR(25)

	SELECT
		@username = token_owner,
		@token_value = token_value,
		@guard_name = guard_name
	FROM OPENJSON(@json)
		WITH (
			token_owner		VARCHAR(15),
			token_value		VARCHAR(36),
			guard_name		VARCHAR(25)
			)

	SELECT
		CASE WHEN EXISTS
			(
				SELECT *
				FROM vw_has_permissions_token
				WHERE
					username = @username
					AND token_value = @token_value
					AND guard_name = @guard_name
			)
			THEN CAST(1 AS BIT)
			ELSE CAST(0 AS BIT)
		END AS 'authorized'
END
GO
/****** Object:  StoredProcedure [dbo].[sp_validate_has_permission_user]    Script Date: 5/4/2023 7:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_validate_has_permission_user]
	@json varchar(max) = ''
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @username		VARCHAR(15)
	DECLARE @guard_name		VARCHAR(25)

	SELECT
		@username = username,
		@guard_name = guard_name
	FROM OPENJSON(@json)
		WITH (
			username		VARCHAR(15),
			guard_name		VARCHAR(25)
			)

	SELECT
		CASE WHEN EXISTS
			(
				SELECT *
				FROM vw_has_permissions_user
				WHERE
					username = @username
					AND guard_name = @guard_name
			)
			THEN CAST(1 AS BIT)
			ELSE CAST(0 AS BIT)
		END AS 'authorized'
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tbl_sessions"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 159
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_users"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 226
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_user_has_roles"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 124
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_roles"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 192
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_role_has_permissions"
            Begin Extent = 
               Top = 6
               Left = 870
               Bottom = 119
               Right = 1040
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_permissions"
            Begin Extent = 
               Top = 6
               Left = 1078
               Bottom = 211
               Right = 1248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         W' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_has_permissions_token'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'idth = 1380
         Width = 4650
         Width = 2550
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_has_permissions_token'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_has_permissions_token'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tbl_users"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_user_has_roles"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 119
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_roles"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 136
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_role_has_permissions"
            Begin Extent = 
               Top = 6
               Left = 870
               Bottom = 119
               Right = 1040
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_permissions"
            Begin Extent = 
               Top = 6
               Left = 1078
               Bottom = 136
               Right = 1248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 2835
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_has_permissions_user'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_has_permissions_user'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_has_permissions_user'
GO
USE [master]
GO
ALTER DATABASE [JUNGLE] SET  READ_WRITE 
GO
