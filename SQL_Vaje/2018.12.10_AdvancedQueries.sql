-- creating table
USE [tempdb];
GO
CREATE TABLE [Employee](
[EmployeeID] [int] NOT NULL,
[ContactID] [int] NOT NULL,
[ManagerID] [int] NULL,
[Title] [nvarchar](50) NOT NULL);
CREATE TABLE [Contact] (
[ContactID] [int] NOT NULL,
[FirstName] [nvarchar](50) NOT NULL,
[MiddleName] [nvarchar](50) NULL,
[LastName] [nvarchar](50) NOT NULL);
INSERT INTO tempdb.dbo.Contact (ContactID, FirstName, MiddleName, LastName) VALUES
(1030,'Kevin','F','Brown'),
(1009,'Thierry','B','DHers'),
(1028,'David','M','Bradley'),
(1070,'JoLynn','M','Dobney'),
(1071,'Ruth','Ann','Ellerbrock'),
(1005,'Gail','A','Erickson'),
(1076,'Barry','K','Johnson'),
(1006,'Jossef','H','Goldberg'),
(1001,'Terri','Lee','Duffy'),
(1072,'Sidney','M','Higa'),
(1067,'Taylor','R','Maxwell'),
(1073,'Jeffrey','L','Ford'),
(1068,'Jo','A','Brown'),
(1074,'Doris','M','Hartwig'),
(1069,'John','T','Campbell'),
(1075,'Diane','R','Glimp'),
(1129,'Steven','T','Selikoff'),
(1231,'Peter','J','Krebs'),
(1172,'Stuart','V','Munson'),
(1173,'Greg','F','Alderson'),
(1113,'David','N','Johnson'),
(1054,'Zheng','W','Mu'),
(1007, 'Ovidiu', 'V', 'Cracium'),
(1052, 'James', 'R', 'Hamilton'),
(1053, 'Andrew', 'R', 'Hill'),
(1056, 'Jack', 'S', 'Richins'),
(1058, 'Michael', 'Sean', 'Ray'),
(1064, 'Lori', 'A', 'Kane'),
(1287, 'Ken', 'J', 'Sanchez');
INSERT INTO tempdb.dbo.Employee (EmployeeID, ContactID, ManagerID, Title) VALUES
(1, 1209, 16,'Production Technician - WC60'),
(2, 1030, 6,'Marketing Assistant'),
(3, 1002, 12,'Engineering Manager'),
(4, 1290, 3,'Senior Tool Designer'),
(5, 1009, 263,'Tool Designer'),
(6, 1028, 109,'Marketing Manager'),
(7, 1070, 21,'Production Supervisor - WC60'),
(8, 1071, 185,'Production Technician - WC10'),
(9, 1005, 3,'Design Engineer'),
(10, 1076, 185,'Production Technician - WC10'),
(11, 1006, 3,'Design Engineer'),
(12, 1001, 109,'Vice President of Engineering'),
(13, 1072, 185,'Production Technician - WC10'),
(14, 1067, 21,'Production Supervisor - WC50'),
(15, 1073, 185,'Production Technician - WC10'),
(16, 1068, 21,'Production Supervisor - WC60'),
(17, 1074, 185,'Production Technician - WC10'),
(18, 1069, 21,'Production Supervisor - WC60'),
(19, 1075, 185,'Production Technician - WC10'),
(20, 1129, 173,'Production Technician - WC30'),
(21, 1231, 148,'Production Control Manager'),
(22, 1172, 197,'Production Technician - WC45'),
(23, 1173, 197,'Production Technician - WC45'),
(24, 1113, 184,'Production Technician - WC30'),
(25, 1054, 21,'Production Supervisor - WC10'),
(109, 1287, NULL, 'Chief Executive Officer'),
(148, 1052, 109, 'Vice President of Production'),
(173, 1058, 21, 'Production Supervisor - WC30'),
(184, 1056, 21, 'Production Supervisor - WC30'),
(185, 1053, 21, 'Production Supervisor - WC10'),
(197, 1064, 21, 'Production Supervisor - WC45'),
(263, 1007, 3, 'Senior Tool Designer');

select	*
from	Employee

-- recursion
USE tempdb;
WITH OrgChart (EmployeeID, ManagerID, Title, Level,Node) AS (
	SELECT	EmployeeID, ManagerID, Title, 0, CONVERT(VARCHAR(30),'/') AS Node
	FROM	Employee
	WHERE	 ManagerID IS NULL

	UNION ALL

	SELECT	a.EmployeeID, a.ManagerID,a.Title, b.Level + 1,
			CONVERT(VARCHAR(30),b.Node + CONVERT(VARCHAR,a.ManagerID) + '/')
	FROM	Employee AS a INNER JOIN OrgChart AS b
			ON a.ManagerID = b.EmployeeID
)
SELECT	EmployeeID, ManagerID, SPACE(Level * 3) + Title AS Title, Level, Node
FROM	OrgChart
ORDER BY Node


-- creating database (naloge spodaj)
USE [master]
GO

-- create the database needed
CREATE DATABASE [DoctorWho]
GO

USE [DoctorWho]
GO

/****** Object:  UserDefinedFunction [dbo].[fnCompanions]    Script Date: 12/05/2015 11:50:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- create table of authors of episodes
CREATE TABLE [dbo].[tblAuthor](
	[AuthorId] [int] IDENTITY(1,1) NOT NULL,
	[AuthorName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblAuthor] PRIMARY KEY CLUSTERED 
(
	[AuthorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- create table of companions of Dr Who
CREATE TABLE [dbo].[tblCompanion](
	[CompanionId] [int] IDENTITY(1,1) NOT NULL,
	[CompanionName] [nvarchar](50) NOT NULL,
	[WhoPlayed] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblCompanion] PRIMARY KEY CLUSTERED 
(
	[CompanionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- create table of Dr Who's
CREATE TABLE [dbo].[tblDoctor](
	[DoctorId] [int] IDENTITY(1,1) NOT NULL,
	[DoctorNumber] [int] NULL,
	[DoctorName] [nvarchar](50) NULL,
	[BirthDate] [date] NULL,
	[FirstEpisodeDate] [date] NULL,
	[LastEpisodeDate] [date] NULL,
 CONSTRAINT [PK_tblDoctor] PRIMARY KEY CLUSTERED 
(
	[DoctorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- create table of enemies of the Doctor
CREATE TABLE [dbo].[tblEnemy](
	[EnemyId] [int] IDENTITY(1,1) NOT NULL,
	[EnemyName] [nvarchar](100) NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblEnemy] PRIMARY KEY CLUSTERED 
(
	[EnemyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- create table of the episodes
CREATE TABLE [dbo].[tblEpisode](
	[EpisodeId] [int] IDENTITY(1,1) NOT NULL,
	[SeriesNumber] [int] NULL,
	[EpisodeNumber] [int] NULL,
	[EpisodeType] [nvarchar](50) NULL,
	[Title] [nvarchar](255) NULL,
	[EpisodeDate] [date] NULL,
	[AuthorId] [int] NULL,
	[DoctorId] [int] NULL,
	[Notes] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblEpisode] PRIMARY KEY CLUSTERED 
(
	[EpisodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- create table of which companions were in which episodes
CREATE TABLE [dbo].[tblEpisodeCompanion](
	[EpisodeCompanionId] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeId] [int] NULL,
	[CompanionId] [int] NULL,
 CONSTRAINT [PK_tblEpisodeCompanion] PRIMARY KEY CLUSTERED 
(
	[EpisodeCompanionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- create table of which enemies were in which episodes
CREATE TABLE [dbo].[tblEpisodeEnemy](
	[EpisodeEnemyId] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeId] [int] NULL,
	[EnemyId] [int] NULL,
 CONSTRAINT [PK_tbEpisodeEnemy] PRIMARY KEY CLUSTERED 
(
	[EpisodeEnemyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- add in the authors
SET IDENTITY_INSERT [dbo].[tblAuthor] ON 
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (1, N'Chris Chibnall')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (2, N'Gareth Roberts')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (3, N'Helen Raynor')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (4, N'James Moran')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (5, N'James Strong')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (6, N'Jamie Matheson')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (7, N'Keith Temple')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (8, N'Mark Gatiss')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (9, N'Matt Jones')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (10, N'Matthew Graham')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (11, N'Neil Cross')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (12, N'Neil Gaiman')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (13, N'Paul Cornell')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (14, N'Peter Harness')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (15, N'Phil Ford')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (16, N'Richard Curtis')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (17, N'Robert Shearman')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (18, N'Russell T. Davies')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (19, N'Simon Nye')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (20, N'Stephen Greenhorn')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (21, N'Steve Thompson')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (22, N'Steven Moffat')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (23, N'Toby Whithouse')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (24, N'Tom MacRae')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (25, N'Frank Cottrell Boyce')
GO
SET IDENTITY_INSERT [dbo].[tblAuthor] OFF
GO

-- add in the companions
SET IDENTITY_INSERT [dbo].[tblCompanion] ON 
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (1, N'River Song', N'Alex Kingston')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (2, N'Rory Williams', N'Arthur Darvill')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (3, N'Wilfred Mott', N'Bernard Cribbins')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (4, N'Rose Tyler', N'Billie Piper')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (5, N'Adam Mitchell', N'Bruno Langley')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (6, N'Donna Noble', N'Catherine Tate')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (7, N'Jackson Lake', N'David Morrissey')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (8, N'Sarah Jane Smith', N'Elisabeth Sladen')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (9, N'Martha Jones', N'Freema Agyeman')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (10, N'Craig Owens', N'James Corden')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (11, N'Clara Oswald', N'Jenna Coleman')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (12, N'Jack Harkness', N'John Barrowman')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (13, N'Amy Pond', N'Karen Gillan')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (14, N'Astrid Peth', N'Kylie Minogue')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (15, N'Adelaide Brooke', N'Lindsay Duncan')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (16, N'Lady Christina de Souza', N'Michelle Ryan')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (17, N'Mickey Smith', N'Noel Clarke')
GO
INSERT [dbo].[tblCompanion] ([CompanionId], [CompanionName], [WhoPlayed]) VALUES (18, N'Rosita Farisi', N'Velle Tshabalala')
GO
SET IDENTITY_INSERT [dbo].[tblCompanion] OFF
GO

-- add in the doctors
SET IDENTITY_INSERT [dbo].[tblDoctor] ON 
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (1, 9, N'Christopher Eccleston', CAST(0xD8F00A00 AS Date), CAST(0x7E2B0B00 AS Date), CAST(0xD22B0B00 AS Date))
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (2, 6, N'Colin Baker', CAST(0x52D30A00 AS Date), CAST(0x7E0D0B00 AS Date), CAST(0x61110B00 AS Date))
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (3, 10, N'David Tennant', CAST(0x12FB0A00 AS Date), CAST(0xD22B0B00 AS Date), CAST(0x4C320B00 AS Date))
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (4, 3, N'Jon Pertwee', CAST(0xDE3F0B00 AS Date), CAST(0x3CF90A00 AS Date), CAST(0x8DFF0A00 AS Date))
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (5, 11, N'Matt Smith', CAST(0x850B0B00 AS Date), CAST(0x4C320B00 AS Date), CAST(0xFA370B00 AS Date))
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (6, 2, N'Patrick Troughton', CAST(0x37B20A00 AS Date), CAST(0xB2F40A00 AS Date), CAST(0x78F80A00 AS Date))
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (7, 8, N'Paul McGann', CAST(0xC5EA0A00 AS Date), CAST(0xE51E0B00 AS Date), CAST(0xE51E0B00 AS Date))
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (8, 12, N'Peter Capaldi', CAST(0x82E80A00 AS Date), CAST(0xFA370B00 AS Date), NULL)
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (9, 5, N'Peter Davison', CAST(0x84DE0A00 AS Date), CAST(0x3B090B00 AS Date), CAST(0x7E0D0B00 AS Date))
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (10, 7, N'Sylvester McCoy', CAST(0x9BD30A00 AS Date), CAST(0x74120B00 AS Date), CAST(0xA9150B00 AS Date))
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (11, 4, N'Tom Baker', CAST(0xF0C50A00 AS Date), CAST(0x8DFF0A00 AS Date), CAST(0x3B090B00 AS Date))
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (12, 1, N'William Hartnell', CAST(0x782F0B00 AS Date), CAST(0x83F00A00 AS Date), CAST(0xB2F40A00 AS Date))
GO
SET IDENTITY_INSERT [dbo].[tblDoctor] OFF
GO

-- add in the enemies
SET IDENTITY_INSERT [dbo].[tblEnemy] ON 
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (1, N'The Autons', N'Murderous mannequins')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (2, N'Lady Cassandra', N'The last living human being')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (3, N'The Gelth', N'An alien species comprised of gas')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (4, N'The Slitheen', N'A baby-faced alien family')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (5, N'Daleks', N'Armoured aliens')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (6, N'Jagrafess', N'A hideous, giant slug-like creature')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (7, N'Reapers', N'Winged reptile-like creatures')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (8, N'The empty child', N'A by-product of a dead four-year-old child')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (9, N'The Sycorax', N'An alien race wearing bone-like masks')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (10, N'Face of Boe', N'A gigantic humanoid head')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (11, N'Sisters of Plenitude', N'A humanoid feline race, also known as "Catkind"')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (12, N'Werewolf', N'A werewolf moster')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (13, N'Krillitanes', N'Carnivorous, winged bat-like creatures')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (14, N'Clockwork Droids', N'Repair droids wearing scary masks')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (15, N'Cybermen', N'Cyborg race')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (16, N'The Wire', N'An alien lifeform of pure energy, taking human female form')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (17, N'The Ood', N'Aliens with tentacled faces carrying translation spheres')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (18, N'The Beast', N'Gigantic monster claiming to be Satan')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (19, N'The Abzorbaloff', N'Obese alien which absorbs victims through touch')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (20, N'Isolus', N'Alien resembling a small white flower, which will do anything not to be alone')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (21, N'Roboforms', N'Robots disguised as Santas')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (22, N'The empress of the Racnoss', N'The empress of a half-human, half arachnid race called the Racnoss')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (23, N'The Judoon', N'Galactic stormtroopers resembling rhinoceroses')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (24, N'Plasmavores', N'Blood-sucking aliens disguised as humans')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (25, N'The Carrionites', N'Witch-like beings')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (26, N'The Macra', N'Giant crab-like creatures living under a motorway')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (27, N'Lazarus', N'Large creature needing to absorb human energy')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (28, N'Scarecrows', N'Scarecrows brought to life by the Family of Blood')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (29, N'Weeping angels', N'Stone angels which kill when you stop looking at them')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (30, N'Futurekind', N'Humanoid race with large pointed teeth from the distant future')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (31, N'The Toclafane', N'Cyborgs from the distant future integrated into metallic spheres')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (32, N'The Master', N'A renegade Time Lord, the arch-enemy of Dr. Who')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (33, N'The Host', N'Golden robotic angels controlled by Max Capricorn')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (34, N'Max Capricorn', N'A cyborg head in a box')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (35, N'Adipose', N'Small creatures created from excess human fat')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (36, N'Pyroviles', N'Creatures constructed from volcanic magma')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (37, N'The Sontaran', N'Milatristic aliens with squat features and strange ears')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (38, N'The Hath', N'Fish-faced aliens')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (39, N'The Vespiform', N'Wasp-like aliens')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (40, N'Vashta Nerada', N'Microscopic carnivorous aliens')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (41, N'The Time Beetle', N'Beetle feeding off time energy which alters time')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (42, N'Davros', N'Creator of the Daleks')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (43, N'Prisoner Zero', N'A snake-like shape-shifting alien')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (44, N'The Atraxi', N'Giant eyeballs which act as a galactic police force')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (45, N'Smilers', N'Androids indicating danger according to which way they face')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (46, N'Saturnynian', N'Sea-dwelling aliens which change the perception of people looking at them')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (47, N'Eknodine', N'Aliens hiding inside humans which attack by making them emit a green stalk')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (48, N'Silurians', N'Lizard like creatures with green scaly skins')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (49, N'Krafayis', N'Invisible bird-like creature')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (50, N'Sky shark', N'A flying shark')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (51, N'The Silence', N'Aliens who make you forget they existed the moment you stop looking at them')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (52, N'The Siren', N'A virtual doctor disguised as a beautiful female')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (53, N'House', N'A green entity which feeds on TARDIS')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (54, N'Gangers', N'Clones created from living flesh, which can be manipulated into any creature')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (55, N'Headless Monks', N'Headless monks armed with energy blades')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (56, N'The Teselecta', N'A shape-shifting robot that travels in time to right past wrongs')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (57, N'Peg Dolls', N'Peg dolls which can transfom humans into one of their own')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (58, N'Handbots', N'Medical robots whose heads contain a concealed weapon')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (59, N'The Minotaur', N'A monster which feeds off the faith of victims')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (60, N'Solomon', N'A humanoid controlling the Silurians')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (61, N'Kahler-Tek', N'A Cyborg soldier, also known as "The Gunslinger"')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (62, N'Kahler-Jex', N'An alien doctor with a unique facial marking')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (63, N'The Shakri', N'Bald, decrepit-looking humanoids with a thing for cubes and the number seven')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (64, N'The Great Intelligence', N'Disembodied being trying to find a body, whose proper name is Yog-Sothoth')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (65, N'The Snowmen', N'Snowmen with psychic properties who attack people')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (66, N'Akhaten', N'A parasitic, sentient planet feeding on the souls of its inhabitants')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (67, N'Skaldak', N'An ice warrior')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (68, N'Time Zombies', N'Distorted future versions of the Doctor and associates')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (69, N'Mister Sweet', N'Also known as the crismon horror, a species of red leech')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (70, N'Winifred Gillyflower', N'A chemist who created Mister Sweet')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (71, N'Mr. Clever', N'An entity which tries to overtake the Doctor''s mind')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (72, N'Zygons', N'Reddish humanoids with cone-shaped heads, covered in suckers')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (73, N'The Sheriff of Nottingham', N'A cyborg posing as the real Sheriff')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (74, N'Ms Delphox', N'A clone heading a bank')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (75, N'Skovox Blitzer', N'A robot built for war')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (76, N'Foretold', N'An ancient soldier kept alive by technology')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (77, N'Gus', N'A computer trying to take control of the Foretold')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (78, N'Boneless', N'Two-dimensional shape-shifting creatures which can reduce others to 2D')
GO
INSERT [dbo].[tblEnemy] ([EnemyId], [EnemyName], [Description]) VALUES (79, N'Dream crabs', N'Predators resembling human hands which work by telepathy, properly called Kantrofarri')
GO
SET IDENTITY_INSERT [dbo].[tblEnemy] OFF
GO

-- add the episodes
SET IDENTITY_INSERT [dbo].[tblEpisode] ON 
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (1, 1, 1, N'Normal episode', N'Rose', CAST(0x7E2B0B00 AS Date), 18, 1, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (2, 1, 2, N'Normal episode', N'The End of the World', CAST(0x852B0B00 AS Date), 18, 1, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (3, 1, 3, N'Normal episode', N'The Unquiet Dead', CAST(0x8C2B0B00 AS Date), 18, 1, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (4, 1, 4, N'Normal episode', N'Aliens of London (Part 1)', CAST(0x932B0B00 AS Date), 18, 1, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (5, 1, 5, N'Normal episode', N'World War Three (Part 2)', CAST(0x9A2B0B00 AS Date), 18, 1, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (6, 1, 6, N'Normal episode', N'Dalek', CAST(0xA12B0B00 AS Date), 17, 1, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (7, 1, 7, N'Normal episode', N'The Long Game', CAST(0xA82B0B00 AS Date), 18, 1, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (8, 1, 8, N'Normal episode', N'Father''s Day', CAST(0xAF2B0B00 AS Date), 13, 1, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (9, 1, 9, N'Normal episode', N'The Empty Child (Part 1)', CAST(0xB62B0B00 AS Date), 22, 1, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (10, 1, 10, N'Normal episode', N'The Doctor Dances (Part 2)', CAST(0xBD2B0B00 AS Date), 22, 1, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (11, 1, 11, N'Normal episode', N'Boom Town', CAST(0xC42B0B00 AS Date), 18, 1, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (12, 1, 12, N'Normal episode', N'Bad Wolf (Part 1)', CAST(0xCB2B0B00 AS Date), 18, 1, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (13, 1, 13, N'Normal episode', N'The Parting of the Ways (Part 2)', CAST(0xD22B0B00 AS Date), 18, 1, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (14, 2, NULL, N'Christmas special', N'The Christmas Invasion', CAST(0x902C0B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (15, 2, 1, N'Normal episode', N'New Earth', CAST(0xFF2C0B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (16, 2, 2, N'Normal episode', N'Tooth and Claw', CAST(0x062D0B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (17, 2, 3, N'Normal episode', N'School Reunion', CAST(0x0D2D0B00 AS Date), 23, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (18, 2, 4, N'Normal episode', N'The Girl in the Fireplace', CAST(0x142D0B00 AS Date), 22, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (19, 2, 5, N'Normal episode', N'Rise of the Cybermen (Part 1)', CAST(0x1B2D0B00 AS Date), 24, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (20, 2, 6, N'Normal episode', N'The Age of Steel (Part 2)', CAST(0x222D0B00 AS Date), 24, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (21, 2, 7, N'Normal episode', N'The Idiot''s Lantern', CAST(0x292D0B00 AS Date), 8, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (22, 2, 8, N'Normal episode', N'The Impossible Planet (Part 1)', CAST(0x302D0B00 AS Date), 9, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (23, 2, 9, N'Normal episode', N'The Satan Pit (Part 2)', CAST(0x372D0B00 AS Date), 9, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (24, 2, 10, N'Normal episode', N'Love & Monsters', CAST(0x3E2D0B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (25, 2, 11, N'Normal episode', N'Fear Her', CAST(0x452D0B00 AS Date), 10, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (26, 2, 12, N'Normal episode', N'Army of Ghosts (Part 1)', CAST(0x4C2D0B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (27, 2, 13, N'Normal episode', N'Doomsday (Part 2)', CAST(0x532D0B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (28, 3, NULL, N'Christmas special', N'The Runaway Bride', CAST(0xFD2D0B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (29, 3, 1, N'Normal episode', N'Smith and Jones', CAST(0x5D2E0B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (30, 3, 2, N'Normal episode', N'The Shakespeare Code', CAST(0x642E0B00 AS Date), 2, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (31, 3, 3, N'Normal episode', N'Gridlock', CAST(0x6B2E0B00 AS Date), 18, 3, N'Guest appearance by Ardal O''Hanlon 
')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (32, 3, 4, N'Normal episode', N'Daleks in Manhattan (Part 1)', CAST(0x722E0B00 AS Date), 5, 3, N'Technically monster is a human-dalek hybrid
')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (33, 3, 5, N'Normal episode', N'Evolution of the Daleks (Part 2)', CAST(0x792E0B00 AS Date), 5, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (34, 3, 6, N'Normal episode', N'The Lazarus Experiment', CAST(0x802E0B00 AS Date), 20, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (35, 3, 7, N'Normal episode', N'42', CAST(0x8E2E0B00 AS Date), 1, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (36, 3, 8, N'Normal episode', N'Human Nature (Part 1)', CAST(0x952E0B00 AS Date), 13, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (37, 3, 9, N'Normal episode', N'The Family of Blood (Part 2)', CAST(0x9C2E0B00 AS Date), 13, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (38, 3, 10, N'Normal episode', N'Blink', CAST(0xA32E0B00 AS Date), 22, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (39, 3, 11, N'Normal episode', N'Utopia (Part 1)', CAST(0xAA2E0B00 AS Date), 18, 3, N'Guest appearance by Derek Jacobi
')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (40, 3, 12, N'Normal episode', N'The Sound of Drums (Part 2)', CAST(0xB12E0B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (41, 3, 13, N'Normal episode', N'Last of the Time Lords (Part 3)', CAST(0xB82E0B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (42, 4, NULL, N'Christmas special', N'Voyage of the Damned', CAST(0x6A2F0B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (43, 4, 1, N'Normal episode', N'Partners in Crime', CAST(0xD02F0B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (44, 4, 2, N'Normal episode', N'The Fires of Pompeii', CAST(0xD72F0B00 AS Date), 4, 3, N'Both Peter Capaldi and Karen Gillan play characters in this episode (future Doctor and companion)
')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (45, 4, 3, N'Normal episode', N'Planet of the Ood', CAST(0xDE2F0B00 AS Date), 7, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (46, 4, 4, N'Normal episode', N'The Sontaran Stratagem (Part 1)', CAST(0xE52F0B00 AS Date), 3, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (47, 4, 5, N'Normal episode', N'The Poison Sky (Part 2)', CAST(0xEC2F0B00 AS Date), 3, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (48, 4, 6, N'Normal episode', N'The Doctor''s Daughter', CAST(0xF32F0B00 AS Date), 20, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (49, 4, 7, N'Normal episode', N'The Unicorn and the Wasp', CAST(0xFA2F0B00 AS Date), 2, 3, N'Felicity Kendal guest stars
')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (50, 4, 8, N'Normal episode', N'Silence in the Library (Part 1)', CAST(0x08300B00 AS Date), 22, 3, N'Count the shadows �
')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (51, 4, 9, N'Normal episode', N'Forest of the Dead (Part 2)', CAST(0x0F300B00 AS Date), 22, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (52, 4, 10, N'Normal episode', N'Midnight', CAST(0x16300B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (53, 4, 11, N'Normal episode', N'Turn Left', CAST(0x1D300B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (54, 4, 12, N'Normal episode', N'The Stolen Earth (Part 1)', CAST(0x24300B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (55, 4, 13, N'Normal episode', N'Journey''s End (Part 2)', CAST(0x2B300B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (56, 4, NULL, N'Christmas special', N'The Next Doctor', CAST(0xD8300B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (57, 4, NULL, N'Easter special', N'Planet of the Dead', CAST(0x43310B00 AS Date), 2, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (58, 4, NULL, N'Autumn special', N'The Waters of Mars', CAST(0x1D320B00 AS Date), 15, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (59, 4, NULL, N'Christmas special', N'The End of Time (Part 1)', CAST(0x45320B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (60, 4, NULL, N'Christmas special', N'The End of Time (Part 2)', CAST(0x4C320B00 AS Date), 18, 3, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (61, 5, 1, N'Normal episode', N'The Eleventh Hour', CAST(0xA8320B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (62, 5, 2, N'Normal episode', N'The Beast Below', CAST(0xAF320B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (63, 5, 3, N'Normal episode', N'Victory of the Daleks', CAST(0xB6320B00 AS Date), 8, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (64, 5, 4, N'Normal episode', N'The Time of Angels (Part 1)', CAST(0xBD320B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (65, 5, 5, N'Normal episode', N'Flesh and Stone (Part 2)', CAST(0xC4320B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (66, 5, 6, N'Normal episode', N'The Vampires of Venice', CAST(0xCB320B00 AS Date), 23, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (67, 5, 7, N'Normal episode', N'Amy''s Choice', CAST(0xD2320B00 AS Date), 19, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (68, 5, 8, N'Normal episode', N'The Hungry Earth (Part 1)', CAST(0xD9320B00 AS Date), 1, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (69, 5, 9, N'Normal episode', N'Cold Blood (Part 2)', CAST(0xE0320B00 AS Date), 1, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (70, 5, 10, N'Normal episode', N'Vincent and the Doctor', CAST(0xE7320B00 AS Date), 16, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (71, 5, 11, N'Normal episode', N'The Lodger', CAST(0xEE320B00 AS Date), 2, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (72, 5, 12, N'Normal episode', N'The Pandorica Opens (Part 1)', CAST(0xF5320B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (73, 5, 13, N'Normal episode', N'The Big Bang (Part 2)', CAST(0xFC320B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (74, 6, NULL, N'Christmas special', N'A Christmas Carol', CAST(0xB2330B00 AS Date), 22, 5, N'Michael Gambon guest stars
')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (75, 6, 1, N'Normal episode', N'The Impossible Astronaut (Part 1)', CAST(0x29340B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (76, 6, 2, N'Normal episode', N'Day of the Moon (Part 2)', CAST(0x30340B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (77, 6, 3, N'Normal episode', N'The Curse of the Black Spot', CAST(0x37340B00 AS Date), 21, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (78, 6, 4, N'Normal episode', N'The Doctor''s Wife', CAST(0x3E340B00 AS Date), 12, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (79, 6, 5, N'Normal episode', N'The Rebel Flesh (Part 1)', CAST(0x45340B00 AS Date), 10, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (80, 6, 6, N'Normal episode', N'The Almost People (Part 2)', CAST(0x4C340B00 AS Date), 10, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (81, 6, 7, N'Normal episode', N'A Good Man Goes to War', CAST(0x53340B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (82, 6, 8, N'Normal episode', N'Let''s Kill Hitler', CAST(0xA7340B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (83, 6, 9, N'Normal episode', N'Night Terrors', CAST(0xAE340B00 AS Date), 8, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (84, 6, 10, N'Normal episode', N'The Girl Who Waited', CAST(0xB5340B00 AS Date), 24, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (85, 6, 11, N'Normal episode', N'The God Complex', CAST(0xBC340B00 AS Date), 23, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (86, 6, 12, N'Normal episode', N'Closing Time', CAST(0xC3340B00 AS Date), 2, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (87, 6, 13, N'Normal episode', N'The Wedding of River Song', CAST(0xCA340B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (88, 7, NULL, N'Christmas special', N'The Doctor, the Widow and the Wardrobe', CAST(0x1F350B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (89, 7, 1, N'Normal episode', N'Asylum of the Daleks', CAST(0x1A360B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (90, 7, 2, N'Normal episode', N'Dinosaurs on a Spaceship', CAST(0x21360B00 AS Date), 1, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (91, 7, 3, N'Normal episode', N'A Town Called Mercy', CAST(0x28360B00 AS Date), 23, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (92, 7, 4, N'Normal episode', N'The Power of Three', CAST(0x2F360B00 AS Date), 1, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (93, 7, 5, N'Normal episode', N'The Angels Take Manhattan', CAST(0x36360B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (94, 7, NULL, N'Christmas special', N'The Snowmen', CAST(0x8D360B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (95, 7, 6, N'Normal episode', N'The Bells of Saint John', CAST(0xEC360B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (96, 7, 7, N'Normal episode', N'The Rings of Akhaten', CAST(0xF3360B00 AS Date), 11, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (97, 7, 8, N'Normal episode', N'Cold War', CAST(0xFA360B00 AS Date), 8, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (98, 7, 9, N'Normal episode', N'Hide', CAST(0x01370B00 AS Date), 11, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (99, 7, 10, N'Normal episode', N'Journey to the Centre of the TARDIS', CAST(0x08370B00 AS Date), 21, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (100, 7, 11, N'Normal episode', N'The Crimson Horror', CAST(0x0F370B00 AS Date), 8, 5, N'Diana Rigg plays the main baddie in this episode
')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (101, 7, 12, N'Normal episode', N'Nightmare in Silver', CAST(0x16370B00 AS Date), 12, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (102, 7, 13, N'Normal episode', N'The Name of the Doctor', CAST(0x1D370B00 AS Date), 22, 5, N'Features cameo appearances from all of the previous doctors
')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (103, 8, NULL, N'50th anniversary specia', N'The Day of the Doctor', CAST(0xDA370B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (104, 8, NULL, N'Christmas special', N'The Time of the Doctor', CAST(0xFA370B00 AS Date), 22, 5, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (105, 8, 1, N'Normal episode', N'Deep Breath', CAST(0xEB380B00 AS Date), 22, 8, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (106, 8, 2, N'Normal episode', N'Into the Dalek', CAST(0xF2380B00 AS Date), 22, 8, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (107, 8, 3, N'Normal episode', N'Robot of Sherwood', CAST(0xF9380B00 AS Date), 8, 8, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (108, 8, 4, N'Normal episode', N'Listen', CAST(0x00390B00 AS Date), 22, 8, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (109, 8, 5, N'Normal episode', N'Time Heist', CAST(0x07390B00 AS Date), 21, 8, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (110, 8, 6, N'Normal episode', N'The Caretaker', CAST(0x0E390B00 AS Date), 2, 8, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (111, 8, 7, N'Normal episode', N'Kill the Moon', CAST(0x15390B00 AS Date), 14, 8, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (112, 8, 8, N'Normal episode', N'Mummy on the Orient Express', CAST(0x1C390B00 AS Date), 6, 8, N'John Sessions was the voice actor for this episode
')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (113, 8, 9, N'Normal episode', N'Flatline', CAST(0x23390B00 AS Date), 6, 8, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (114, 8, 10, N'Normal episode', N'In the Forest of the Night', CAST(0x2A390B00 AS Date), 25, 8, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (115, 8, 11, N'Normal episode', N'Dark Water (Part 1)', CAST(0x31390B00 AS Date), 22, 8, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (116, 8, 12, N'Normal episode', N'Death in Heaven (Part 2)', CAST(0x38390B00 AS Date), 22, 8, NULL)
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (117, 9, NULL, N'Christmas special', N'Last Christmas', CAST(0x67390B00 AS Date), 22, 8, NULL)
GO
SET IDENTITY_INSERT [dbo].[tblEpisode] OFF
GO

-- add which companions were in which episodes
SET IDENTITY_INSERT [dbo].[tblEpisodeCompanion] ON 
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (1, 1, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (2, 2, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (3, 3, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (4, 4, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (5, 5, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (6, 6, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (7, 7, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (8, 8, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (9, 9, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (10, 10, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (11, 11, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (12, 12, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (13, 13, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (14, 14, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (15, 15, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (16, 16, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (17, 17, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (18, 18, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (19, 19, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (20, 20, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (21, 21, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (22, 22, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (23, 23, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (24, 24, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (25, 25, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (26, 26, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (27, 27, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (28, 28, 6)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (29, 29, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (30, 30, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (31, 31, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (32, 32, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (33, 33, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (34, 34, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (35, 35, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (36, 36, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (37, 37, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (38, 38, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (39, 39, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (40, 40, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (41, 41, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (42, 42, 14)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (43, 43, 6)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (44, 44, 6)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (45, 45, 6)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (46, 46, 6)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (47, 47, 6)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (48, 48, 6)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (49, 49, 6)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (50, 50, 6)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (51, 51, 6)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (52, 52, 6)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (53, 53, 6)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (54, 54, 6)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (55, 55, 6)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (56, 56, 7)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (57, 57, 16)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (58, 58, 15)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (59, 59, 3)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (60, 60, 3)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (61, 61, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (62, 62, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (63, 63, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (64, 64, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (65, 65, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (66, 66, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (67, 67, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (68, 68, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (69, 69, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (70, 70, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (71, 71, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (72, 72, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (73, 73, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (74, 74, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (75, 75, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (76, 76, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (77, 77, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (78, 78, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (79, 79, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (80, 80, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (81, 81, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (82, 82, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (83, 83, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (84, 84, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (85, 85, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (86, 86, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (87, 87, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (88, 88, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (89, 89, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (90, 90, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (91, 91, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (92, 92, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (93, 93, 13)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (94, 94, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (95, 95, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (96, 96, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (97, 97, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (98, 98, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (99, 99, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (100, 100, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (101, 101, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (102, 102, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (103, 103, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (104, 104, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (105, 105, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (106, 106, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (107, 107, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (108, 108, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (109, 109, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (110, 110, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (111, 111, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (112, 112, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (113, 113, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (114, 114, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (115, 115, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (116, 116, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (117, 117, 11)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (118, 6, 5)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (119, 7, 5)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (120, 9, 12)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (121, 10, 12)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (122, 11, 12)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (123, 12, 12)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (124, 13, 12)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (125, 17, 17)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (126, 18, 17)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (127, 19, 17)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (128, 20, 17)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (129, 39, 12)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (130, 40, 12)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (131, 41, 12)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (132, 43, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (133, 46, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (134, 47, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (135, 48, 9)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (136, 50, 1)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (137, 51, 1)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (138, 52, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (139, 53, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (140, 54, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (141, 55, 4)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (142, 56, 18)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (143, 61, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (144, 64, 1)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (145, 65, 1)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (146, 66, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (147, 67, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (148, 68, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (149, 69, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (150, 71, 10)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (151, 72, 1)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (152, 73, 1)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (153, 74, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (154, 75, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (155, 76, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (156, 77, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (157, 78, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (158, 79, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (159, 80, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (160, 81, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (161, 82, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (162, 83, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (163, 84, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (164, 85, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (165, 86, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (166, 87, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (167, 88, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (168, 89, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (169, 90, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (170, 91, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (171, 92, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (172, 93, 2)
GO
INSERT [dbo].[tblEpisodeCompanion] ([EpisodeCompanionId], [EpisodeId], [CompanionId]) VALUES (173, 102, 1)
GO
SET IDENTITY_INSERT [dbo].[tblEpisodeCompanion] OFF
GO

-- add which enemies were in which episodes
SET IDENTITY_INSERT [dbo].[tblEpisodeEnemy] ON 
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (1, 15, 10)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (2, 26, 15)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (3, 27, 15)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (4, 72, 15)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (5, 73, 15)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (6, 116, 15)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (7, 54, 42)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (8, 55, 42)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (9, 31, 10)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (10, 112, 77)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (11, 91, 62)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (12, 101, 71)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (13, 29, 24)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (14, 61, 44)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (15, 22, 18)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (16, 23, 18)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (17, 28, 22)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (18, 42, 33)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (19, 40, 32)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (20, 41, 32)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (21, 59, 17)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (22, 86, 51)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (23, 104, 51)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (24, 87, 51)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (25, 75, 56)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (26, 103, 72)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (27, 15, 11)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (28, 15, 2)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (29, 26, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (30, 27, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (31, 72, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (32, 73, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (33, 116, 32)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (34, 54, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (35, 55, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (36, 31, 26)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (37, 112, 76)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (38, 91, 61)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (39, 101, 15)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (40, 29, 23)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (41, 61, 43)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (42, 22, 17)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (43, 23, 17)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (44, 28, 21)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (45, 42, 34)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (46, 40, 31)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (47, 41, 31)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (48, 59, 32)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (49, 86, 15)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (50, 104, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (51, 87, 56)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (52, 75, 51)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (53, 103, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (54, 43, 35)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (55, 96, 66)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (56, 113, 78)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (57, 18, 14)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (58, 105, 14)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (59, 19, 15)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (60, 20, 15)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (61, 56, 15)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (62, 6, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (63, 12, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (64, 13, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (65, 32, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (66, 33, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (67, 63, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (68, 89, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (69, 106, 5)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (70, 67, 47)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (71, 39, 30)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (72, 79, 54)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (73, 80, 54)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (74, 84, 58)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (75, 81, 55)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (76, 78, 53)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (77, 25, 20)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (78, 7, 6)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (79, 117, 79)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (80, 70, 49)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (81, 17, 13)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (82, 2, 2)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (83, 34, 27)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (84, 109, 74)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (85, 83, 57)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (86, 44, 36)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (87, 8, 7)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (88, 66, 46)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (89, 36, 28)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (90, 37, 28)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (91, 68, 48)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (92, 69, 48)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (93, 97, 67)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (94, 110, 75)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (95, 74, 50)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (96, 62, 45)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (97, 90, 60)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (98, 24, 19)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (99, 1, 1)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (100, 30, 25)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (101, 9, 8)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (102, 10, 8)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (103, 3, 3)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (104, 95, 64)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (105, 102, 64)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (106, 48, 38)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (107, 60, 32)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (108, 115, 32)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (109, 85, 59)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (110, 45, 17)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (111, 92, 63)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (112, 107, 73)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (113, 76, 51)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (114, 77, 52)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (115, 4, 4)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (116, 5, 4)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (117, 11, 4)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (118, 94, 65)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (119, 46, 37)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (120, 47, 37)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (121, 14, 9)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (122, 82, 56)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (123, 53, 41)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (124, 21, 16)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (125, 99, 68)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (126, 50, 40)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (127, 51, 40)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (128, 38, 29)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (129, 64, 29)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (130, 65, 29)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (131, 93, 29)
GO
INSERT [dbo].[tblEpisodeEnemy] ([EpisodeEnemyId], [EpisodeId], [EnemyId]) VALUES (132, 16, 12)
GO
SET IDENTITY_INSERT [dbo].[tblEpisodeEnemy] OFF
GO

-- create relationships between tables
ALTER TABLE [dbo].[tblEpisode]  WITH CHECK ADD  CONSTRAINT [FK_tblEpisode_tblAuthor] FOREIGN KEY([AuthorId])
REFERENCES [dbo].[tblAuthor] ([AuthorId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEpisode] CHECK CONSTRAINT [FK_tblEpisode_tblAuthor]
GO
ALTER TABLE [dbo].[tblEpisode]  WITH CHECK ADD  CONSTRAINT [FK_tblEpisode_tblDoctor] FOREIGN KEY([DoctorId])
REFERENCES [dbo].[tblDoctor] ([DoctorId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEpisode] CHECK CONSTRAINT [FK_tblEpisode_tblDoctor]
GO
ALTER TABLE [dbo].[tblEpisodeCompanion]  WITH CHECK ADD  CONSTRAINT [FK_tblEpisodeCompanion_tblCompanion] FOREIGN KEY([CompanionId])
REFERENCES [dbo].[tblCompanion] ([CompanionId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEpisodeCompanion] CHECK CONSTRAINT [FK_tblEpisodeCompanion_tblCompanion]
GO
ALTER TABLE [dbo].[tblEpisodeEnemy]  WITH CHECK ADD  CONSTRAINT [FK_tbEpisodeEnemy_tblEnemy] FOREIGN KEY([EnemyId])
REFERENCES [dbo].[tblEnemy] ([EnemyId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEpisodeEnemy] CHECK CONSTRAINT [FK_tbEpisodeEnemy_tblEnemy]
GO

-- create a couple of useful functions to list companions and enemies
CREATE FUNCTION [dbo].[fnCompanions](
	@EpisodeId int
)
RETURNS varchar(100)
AS
begin
	declare @c varchar(100) = ''

	SELECT
		@c = @c + 
			CASE WHEN len(@c) > 0 THEN ', ' ELSE '' END + 
			c.CompanionName
			
	FROM
		tblEpisodeCompanion AS ec
		INNER JOIN tblCompanion AS c ON ec.CompanionId = c.CompanionId
	WHERE
		ec.EpisodeId = @EpisodeId

	return @c
end
GO

CREATE FUNCTION [dbo].[fnEnemies](
	@EpisodeId int
)
RETURNS varchar(100)
AS
begin
	declare @c varchar(100) = ''

	SELECT
		@c = @c + 
			CASE WHEN len(@c) > 0 THEN ', ' ELSE '' END + 
			c.EnemyName
			
	FROM
		tblEpisodeEnemy AS ec
		INNER JOIN tblEnemy AS c ON ec.EnemyId = c.EnemyId
	WHERE
		ec.EpisodeId = @EpisodeId

	return @c
end
GO

-- create procedure to list out all episodes
CREATE PROC [dbo].[spEpisodes]
AS

SELECT 
	SeriesNumber,
	EpisodeNumber,
	Title,
	a.AuthorName,
	d.DoctorName,
	dbo.fnCompanions(e.EpisodeId) AS Companions,
	dbo.fnEnemies(e.EpisodeId) AS Enemies
FROM
	tblEpisode AS e
	INNER JOIN tblAuthor AS a ON a.AuthorId = e.AuthorId
	INNER JOIN tblDoctor AS d on e.DoctorId = d.DoctorId
ORDER BY
	EpisodeDate
GO




USE Master
go

-- drop database if exists
BEGIN TRY
	DROP Database Carnival
END TRY

BEGIN CATCH
	-- database can't exist
END CATCH

-- create new database
CREATE DATABASE Carnival
go

USE Carnival
GO

CREATE TABLE [dbo].[tblMenu](
	[MenuId] [int] IDENTITY(1,1) NOT NULL,
	[MenuName] [varchar](50) NULL,
	[ParentMenuId] [int] NULL,
	[SortOrder] [int] NULL,
	[Tooltip] [varchar](100) NULL,
	[VisibleText] [varchar](100) NULL,
	[WebPage] [varchar](50) NULL,
	[FolderName] [varchar](50) NULL,
 CONSTRAINT [PK_tblMenu] PRIMARY KEY CLUSTERED 
(
	[MenuId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tblMenu] ON
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (1, N'Home page', NULL, 0, N'Carnival home page', N'Carnival home', N'frmIndex', N'home')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (2, N'Home - about carnival', 1, 10, N'About the 2010 carnival', N'2010 carnival', N'frmCarnival', N'carnival')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (3, N'Home - photos', 1, 20, N'Photo gallery', N'Photo gallery', N'frmPhotos', N'photos')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (4, N'Home - fell race', 1, 30, N'Senior and junior fell races', N'Fell races', N'frmFellRace', N'fellrace')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (5, N'Home - scarecrows', 1, 40, N'Scarecrow competition', N'Scarecrows', N'frmScarecrow', N'scarecrow')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (6, N'Home - help us', 1, 50, N'Carnival organisation', N'Help us', N'frmHelp', N'help')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (7, N'About carnival - dates and times', 2, 10, N'Carnival date and times', N'Dates/times', N'frmWhen', N'carnival')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (8, N'About carnival - on the field', 2, 20, N'Activities on the field', N'On the field', N'frmRec', N'carnival')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (9, N'About carnival - parade', 2, 30, N'Carnival parade', N'The parade', N'frmParade', N'carnival')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (10, N'About carnival - where', 2, 40, N'Where the carnival is', N'Where it happens', N'frmWhere', N'carnival')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (11, N'Photos - parade', 3, 10, N'Photos of the parade', N'Parade', N'frmPhotoParade', N'photos')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (12, N'Photos - field', 3, 20, N'Photos on the field', N'Rec', N'frmPhotoRec', N'photos')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (13, N'Photos - other', 3, 30, N'Other photos', N'Other', N'frmPhotoOther', N'photos')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (14, N'Photos - fell races', 3, 40, N'Fell race photos', N'Fell race', N'frmPhotoFellRace', N'photos')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (15, N'Photos - scarecrows', 3, 50, N'Scarecrow photos', N'Scarecrows', N'frmScarecrow', N'photos')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (16, N'Fell race - senior', 4, 10, N'Senior fell race', N'Senior', N'frmFellRaceSenior', N'fellrace')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (17, N'Fell race - junior', 4, 20, N'Junior fell race', N'Junior', N'frmFellRaceJunior', N'fellrace')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (18, N'Fell race - results', 4, 30, N'Search fell race results', N'Results', N'frmFellRaceResults', N'fellrace')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (19, N'Fell race - photos', 4, 40, N'Fell race photos', N'Photos', N'frmFellRacePhotos', N'fellrace')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (20, N'Scarecrows - 2010 competition', 5, 10, N'The 2010 scarecrow competition', N'2010 competiition', N'frmScarecrowCompetition', N'scarecrow')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (21, N'Scarecrows - photos', 5, 20, N'Scarecrow photos', N'Photos', N'frmScarecrowPhotos', N'scarecrow')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (22, N'Scarecrows- previous years', 5, 30, N'Previous year winners and scarecrow competitions', N'Previous years', N'frmScarecrowPrevious', N'scarecrow')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (23, N'Help us - committee', 6, 10, N'Meet the organisers', N'Who organises it', N'frmHelpCommittee', N'help')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (24, N'Help us - meetings', 6, 20, N'When we meet', N'When and where we meet', N'frmHelpMeetings', N'help')
INSERT [dbo].[tblMenu] ([MenuId], [MenuName], [ParentMenuId], [SortOrder], [Tooltip], [VisibleText], [WebPage], [FolderName]) VALUES (25, N'Help us - finances', 6, 30, N'Carnival finances', N'Finances', N'frmHelpFinaces', N'help')
SET IDENTITY_INSERT [dbo].[tblMenu] OFF


use DoctorWho

-- 1 naloga
-- Doctor WHO database: Get a list of all of the episodes written by authors with�MP�in their names.
select	a.AuthorName, e.Title
from	dbo.tblAuthor as a join dbo.tblEpisode as e on
		a.AuthorId = e.AuthorId
where	a.AuthorName like '%mp%'


-- 2 naloga
-- Doctor WHO database: Get a list of the companions featuring in these episodes.
select	e.EpisodeId, STRING_AGG(c.CompanionName, ', ') as Names
from	dbo.tblEpisode as e join dbo.tblEpisodeCompanion as ec  on
		e.EpisodeId = ec.EpisodeId join dbo.tblCompanion as c on
		ec.CompanionId = c.CompanionId join
		dbo.tblAuthor as a on
		a.AuthorId = e.AuthorId
where	a.AuthorName like '%mp%'		
group by e.EpisodeId


-- 3 naloga
-- The aim of this exercise is to show a list of all of the enemies appearing in
-- Doctor Who episodes featuring Rose Tyler, but not David Tennant.
select	distinct en.EnemyName Names
from	dbo.tblEpisode as e join
		dbo.tblEpisodeCompanion as ec  on
		e.EpisodeId = ec.EpisodeId join
		dbo.tblCompanion as c on
		ec.CompanionId = c.CompanionId join
		dbo.tblDoctor as d
		on d.DoctorId = e.DoctorId join
		dbo.tblEpisodeEnemy as ee on
		ee.EpisodeId = e.EpisodeId join
		dbo.tblEnemy as en on
		en.EnemyId = ee.EnemyId
where	c.CompanionName = 'Rose Tyler' and d.DoctorName != 'David Tennant'
--group by en.EnemyId


-- 4 naloga
-- Create a query which lists the David Tennant episodes for which none of the
-- enemies appear in any non-David Tennant episodes
with temp(Title, EnemyName, DoctorName) as (
	select	e.Title, en.EnemyName, d.DoctorName
	from	dbo.tblEpisode as e join
			dbo.tblDoctor as d
			on d.DoctorId = e.DoctorId join
			dbo.tblEpisodeEnemy as ee on
			ee.EpisodeId = e.EpisodeId join
			dbo.tblEnemy as en on
			en.EnemyId = ee.EnemyId
)
select	distinct Title
from	temp as t
where	DoctorName = 'David Tennant'
		and EnemyName not in (
			select	EnemyName
			from	temp
			where	DoctorName != 'David Tennant'
		)
order	by Title


-- 5 naloga
-- carneval database: show all of the menus, with breadcrumbs (Recursive)
use Carnival

select	*
from	dbo.tblMenu

WITH tmp  AS (
	SELECT	MenuId, MenuName, ParentMenuId, FolderName, 0 as Level, CONVERT(VARCHAR(30),'/') as Node
	FROM	dbo.tblMenu
	WHERE	ParentMenuId IS NULL

	UNION ALL

	SELECT	a.MenuId, a.MenuName, a.ParentMenuId, a.FolderName, b.Level + 1,
			CONVERT(VARCHAR(30), b.Node + CONVERT(VARCHAR,a.ParentMenuId) + '/')
	FROM	dbo.tblMenu AS a INNER JOIN tmp AS b
			ON a.ParentMenuId = b.MenuId
)
SELECT	MenuId, ParentMenuId, MenuName, SPACE(Level * 3) + FolderName, Level, Node
FROM	tmp
ORDER BY Node



-- vaja
USE tempdb;
WITH OrgChart (EmployeeID, ManagerID, Title, Level,Node) AS (
	SELECT	EmployeeID, ManagerID, Title, 0, CONVERT(VARCHAR(30),'/') AS Node
	FROM	Employee
	WHERE	EmployeeID = 23

	UNION ALL

	SELECT	a.EmployeeID, a.ManagerID,a.Title, b.Level + 1,
			CONVERT(VARCHAR(30), b.Node + CONVERT(VARCHAR,a.ManagerID) + '/')
	FROM	Employee AS a INNER JOIN OrgChart AS b
			ON b.ManagerID = a.EmployeeID
)
SELECT	*
FROM	OrgChart
ORDER BY Node