USE [master]
GO
/****** Object:  Database [MartinaTiso.Gestione_Strutture]    Script Date: 18-Feb-22 15:28:26 ******/
CREATE DATABASE [MartinaTiso.Gestione_Strutture]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MartinaTiso.Gestione_Strutture', FILENAME = N'C:\Users\martina.tiso\MartinaTiso.Gestione_Strutture.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MartinaTiso.Gestione_Strutture_log', FILENAME = N'C:\Users\martina.tiso\MartinaTiso.Gestione_Strutture_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MartinaTiso.Gestione_Strutture].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET ARITHABORT OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET  MULTI_USER 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET QUERY_STORE = OFF
GO
USE [MartinaTiso.Gestione_Strutture]
GO
/****** Object:  Table [dbo].[Strutture]    Script Date: 18-Feb-22 15:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Strutture](
	[IdStruttura] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](50) NOT NULL,
	[Citta] [nvarchar](50) NOT NULL,
	[Stato] [nvarchar](50) NOT NULL,
	[Tipologia] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdStruttura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Strutture_Pernottamento]    Script Date: 18-Feb-22 15:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Strutture_Pernottamento](
	[IdStruttura] [int] NULL,
	[IdPernottamento] [int] NULL,
	[Costo] [float] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prenotazioni]    Script Date: 18-Feb-22 15:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prenotazioni](
	[IdPrenotazione] [int] IDENTITY(1,1) NOT NULL,
	[DataArrivo] [date] NOT NULL,
	[DataPartenza] [date] NOT NULL,
	[NumeroPersone] [int] NOT NULL,
	[IdCliente] [int] NULL,
	[IdStruttura] [int] NULL,
	[IdPernottamento] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPrenotazione] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Mostra.Prenotazioni]    Script Date: 18-Feb-22 15:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Mostra.Prenotazioni]
AS
SELECT
		p.IdCliente,
		p.DataArrivo,
		p.DataPartenza,
		p.NumeroPersone,
		st.Nome,
		st.Tipologia,
		Giorni= DATEDIFF ( day , DataArrivo, DataPartenza ) ,
		Costo= sp.Costo * NumeroPersone * DATEDIFF ( day , DataArrivo, DataPartenza )
		
FROM Prenotazioni as p
join Strutture as st
on p.IdStruttura=st.IdStruttura
join Strutture_Pernottamento as sp
on st.IdStruttura=sp.IdStruttura
GO
/****** Object:  View [dbo].[Mostra.Guadagno]    Script Date: 18-Feb-22 15:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Mostra.Guadagno]
AS
SELECT
st.IdStruttura,
Costo=SUM( sp.Costo * NumeroPersone * DATEDIFF ( day , DataArrivo, DataPartenza ))

FROM Prenotazioni as p
join Strutture as st
on p.IdStruttura=st.IdStruttura
join Strutture_Pernottamento as sp
on st.IdStruttura=sp.IdStruttura

GROUP BY ST.IdStruttura, Costo
GO
/****** Object:  Table [dbo].[Clienti]    Script Date: 18-Feb-22 15:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clienti](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](50) NOT NULL,
	[Cognome] [nvarchar](50) NOT NULL,
	[DataDiNascita] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pernottamenti]    Script Date: 18-Feb-22 15:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pernottamenti](
	[IdPernottamento] [int] IDENTITY(1,1) NOT NULL,
	[FormulaPernottamento] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPernottamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Servizi]    Script Date: 18-Feb-22 15:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Servizi](
	[IdServizio] [int] IDENTITY(1,1) NOT NULL,
	[TipologiaServizi] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdServizio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Strutture_Servizi]    Script Date: 18-Feb-22 15:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Strutture_Servizi](
	[IdStruttura] [int] NULL,
	[IdServizio] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Clienti] ON 

INSERT [dbo].[Clienti] ([IdCliente], [Nome], [Cognome], [DataDiNascita]) VALUES (1, N'Martina', N'Tiso', CAST(N'1991-04-23' AS Date))
INSERT [dbo].[Clienti] ([IdCliente], [Nome], [Cognome], [DataDiNascita]) VALUES (2, N'Serena', N'Rossi', CAST(N'1996-03-25' AS Date))
INSERT [dbo].[Clienti] ([IdCliente], [Nome], [Cognome], [DataDiNascita]) VALUES (3, N'Raffaele', N'Bianchi', CAST(N'1962-06-24' AS Date))
INSERT [dbo].[Clienti] ([IdCliente], [Nome], [Cognome], [DataDiNascita]) VALUES (4, N'Davide', N'Mazza', CAST(N'1984-12-08' AS Date))
INSERT [dbo].[Clienti] ([IdCliente], [Nome], [Cognome], [DataDiNascita]) VALUES (5, N'Maria', N'R', CAST(N'2001-12-09' AS Date))
SET IDENTITY_INSERT [dbo].[Clienti] OFF
GO
SET IDENTITY_INSERT [dbo].[Pernottamenti] ON 

INSERT [dbo].[Pernottamenti] ([IdPernottamento], [FormulaPernottamento]) VALUES (1, N'Solo Pernottamento')
INSERT [dbo].[Pernottamenti] ([IdPernottamento], [FormulaPernottamento]) VALUES (2, N'Prima Colazione')
INSERT [dbo].[Pernottamenti] ([IdPernottamento], [FormulaPernottamento]) VALUES (3, N'Mezza Pensione')
INSERT [dbo].[Pernottamenti] ([IdPernottamento], [FormulaPernottamento]) VALUES (4, N'Pensione Completa')
INSERT [dbo].[Pernottamenti] ([IdPernottamento], [FormulaPernottamento]) VALUES (5, N'Prima Colazione')
SET IDENTITY_INSERT [dbo].[Pernottamenti] OFF
GO
SET IDENTITY_INSERT [dbo].[Prenotazioni] ON 

INSERT [dbo].[Prenotazioni] ([IdPrenotazione], [DataArrivo], [DataPartenza], [NumeroPersone], [IdCliente], [IdStruttura], [IdPernottamento]) VALUES (1, CAST(N'2022-02-02' AS Date), CAST(N'2022-02-18' AS Date), 4, 1, 1, 2)
INSERT [dbo].[Prenotazioni] ([IdPrenotazione], [DataArrivo], [DataPartenza], [NumeroPersone], [IdCliente], [IdStruttura], [IdPernottamento]) VALUES (2, CAST(N'2022-02-04' AS Date), CAST(N'2022-02-14' AS Date), 1, 2, 2, 2)
INSERT [dbo].[Prenotazioni] ([IdPrenotazione], [DataArrivo], [DataPartenza], [NumeroPersone], [IdCliente], [IdStruttura], [IdPernottamento]) VALUES (3, CAST(N'2022-02-08' AS Date), CAST(N'2022-02-23' AS Date), 6, 3, 3, 4)
INSERT [dbo].[Prenotazioni] ([IdPrenotazione], [DataArrivo], [DataPartenza], [NumeroPersone], [IdCliente], [IdStruttura], [IdPernottamento]) VALUES (4, CAST(N'2022-02-14' AS Date), CAST(N'2022-02-20' AS Date), 3, 4, 4, 1)
INSERT [dbo].[Prenotazioni] ([IdPrenotazione], [DataArrivo], [DataPartenza], [NumeroPersone], [IdCliente], [IdStruttura], [IdPernottamento]) VALUES (5, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-04' AS Date), 2, 5, 2, 3)
SET IDENTITY_INSERT [dbo].[Prenotazioni] OFF
GO
SET IDENTITY_INSERT [dbo].[Servizi] ON 

INSERT [dbo].[Servizi] ([IdServizio], [TipologiaServizi]) VALUES (1, N'Piscina')
INSERT [dbo].[Servizi] ([IdServizio], [TipologiaServizi]) VALUES (2, N'WiFi')
INSERT [dbo].[Servizi] ([IdServizio], [TipologiaServizi]) VALUES (3, N'Cassaforte')
INSERT [dbo].[Servizi] ([IdServizio], [TipologiaServizi]) VALUES (4, N'spa&Centro benessere')
INSERT [dbo].[Servizi] ([IdServizio], [TipologiaServizi]) VALUES (5, N'Animali Ammessi')
SET IDENTITY_INSERT [dbo].[Servizi] OFF
GO
SET IDENTITY_INSERT [dbo].[Strutture] ON 

INSERT [dbo].[Strutture] ([IdStruttura], [Nome], [Citta], [Stato], [Tipologia]) VALUES (1, N'FantaGhirò', N'Roma', N'Italia', N'Hotel')
INSERT [dbo].[Strutture] ([IdStruttura], [Nome], [Citta], [Stato], [Tipologia]) VALUES (2, N'Disney', N'Parigi', N'Francia', N'Residence')
INSERT [dbo].[Strutture] ([IdStruttura], [Nome], [Citta], [Stato], [Tipologia]) VALUES (3, N'Baita', N'Dolomiti', N'Italia', N'Case Vacanze')
INSERT [dbo].[Strutture] ([IdStruttura], [Nome], [Citta], [Stato], [Tipologia]) VALUES (4, N'Frankfurt', N'Francoforte', N'Germania', N'Residence')
INSERT [dbo].[Strutture] ([IdStruttura], [Nome], [Citta], [Stato], [Tipologia]) VALUES (5, N'Hola', N'Andalucia', N'Spagna', N'Case Vacanze')
SET IDENTITY_INSERT [dbo].[Strutture] OFF
GO
INSERT [dbo].[Strutture_Pernottamento] ([IdStruttura], [IdPernottamento], [Costo]) VALUES (1, 3, 60)
INSERT [dbo].[Strutture_Pernottamento] ([IdStruttura], [IdPernottamento], [Costo]) VALUES (2, 4, 100)
INSERT [dbo].[Strutture_Pernottamento] ([IdStruttura], [IdPernottamento], [Costo]) VALUES (3, 1, 20)
INSERT [dbo].[Strutture_Pernottamento] ([IdStruttura], [IdPernottamento], [Costo]) VALUES (4, 2, 54)
INSERT [dbo].[Strutture_Pernottamento] ([IdStruttura], [IdPernottamento], [Costo]) VALUES (5, 5, 90)
GO
INSERT [dbo].[Strutture_Servizi] ([IdStruttura], [IdServizio]) VALUES (1, 1)
INSERT [dbo].[Strutture_Servizi] ([IdStruttura], [IdServizio]) VALUES (2, 2)
INSERT [dbo].[Strutture_Servizi] ([IdStruttura], [IdServizio]) VALUES (3, 1)
INSERT [dbo].[Strutture_Servizi] ([IdStruttura], [IdServizio]) VALUES (4, 3)
INSERT [dbo].[Strutture_Servizi] ([IdStruttura], [IdServizio]) VALUES (5, 4)
GO
ALTER TABLE [dbo].[Prenotazioni]  WITH CHECK ADD FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clienti] ([IdCliente])
GO
ALTER TABLE [dbo].[Prenotazioni]  WITH CHECK ADD FOREIGN KEY([IdPernottamento])
REFERENCES [dbo].[Pernottamenti] ([IdPernottamento])
GO
ALTER TABLE [dbo].[Prenotazioni]  WITH CHECK ADD FOREIGN KEY([IdStruttura])
REFERENCES [dbo].[Strutture] ([IdStruttura])
GO
ALTER TABLE [dbo].[Strutture_Pernottamento]  WITH CHECK ADD FOREIGN KEY([IdPernottamento])
REFERENCES [dbo].[Pernottamenti] ([IdPernottamento])
GO
ALTER TABLE [dbo].[Strutture_Pernottamento]  WITH CHECK ADD FOREIGN KEY([IdStruttura])
REFERENCES [dbo].[Strutture] ([IdStruttura])
GO
ALTER TABLE [dbo].[Strutture_Servizi]  WITH CHECK ADD FOREIGN KEY([IdServizio])
REFERENCES [dbo].[Servizi] ([IdServizio])
GO
ALTER TABLE [dbo].[Strutture_Servizi]  WITH CHECK ADD FOREIGN KEY([IdStruttura])
REFERENCES [dbo].[Strutture] ([IdStruttura])
GO
ALTER TABLE [dbo].[Pernottamenti]  WITH CHECK ADD  CONSTRAINT [CHK_FormulaPernottamento] CHECK  (([FormulaPernottamento]='Solo Pernottamento' OR [FormulaPernottamento]='Prima Colazione' OR [FormulaPernottamento]='Mezza Pensione' OR [FormulaPernottamento]='Pensione Completa'))
GO
ALTER TABLE [dbo].[Pernottamenti] CHECK CONSTRAINT [CHK_FormulaPernottamento]
GO
ALTER TABLE [dbo].[Servizi]  WITH CHECK ADD  CONSTRAINT [CHK_TipologiaServizi] CHECK  (([TipologiaServizi]='Piscina' OR [TipologiaServizi]='WiFi' OR [TipologiaServizi]='Cassaforte' OR [TipologiaServizi]='Spa&Centro benessere' OR [TipologiaServizi]='Animali Ammessi'))
GO
ALTER TABLE [dbo].[Servizi] CHECK CONSTRAINT [CHK_TipologiaServizi]
GO
ALTER TABLE [dbo].[Strutture]  WITH CHECK ADD  CONSTRAINT [CHK_tipologia] CHECK  (([Tipologia]='Hotel' OR [Tipologia]='Case Vacanze' OR [Tipologia]='Residence'))
GO
ALTER TABLE [dbo].[Strutture] CHECK CONSTRAINT [CHK_tipologia]
GO
/****** Object:  StoredProcedure [dbo].[Inserimento]    Script Date: 18-Feb-22 15:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Inserimento]
 @dataArrivo date, @dataPartenza  date, @persone int, @idCliente int,@idstruttura int, @idPernottamento int 
AS
INSERT Prenotazioni values (@dataArrivo,@dataPartenza,@persone,@idCliente,@idstruttura,@idPernottamento)
SELECT
		
				
		p.DataArrivo,
		p.DataPartenza,
		p.NumeroPersone,
		c.IdCliente,
		st.IdStruttura,
		p.IdPernottamento

FROM Prenotazioni as p
join Strutture as st
on p.IdStruttura=st.IdStruttura
join Clienti as c
on p.IdCliente= c.IdCliente
where st.IdStruttura=@idstruttura 
and p.IdPernottamento=@idPernottamento
and p.IdCliente=@idCliente
AND P.DataArrivo=@dataArrivo
and p.DataPartenza=@dataPartenza
and p.NumeroPersone=@persone
GO
/****** Object:  StoredProcedure [dbo].[Mostra.Servizi]    Script Date: 18-Feb-22 15:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Mostra.Servizi]
@servizio NVARCHAR(50)
AS

SELECT
		
		st.IdStruttura,
		st.Nome,
		s.TipologiaServizi


FROM Servizi AS S
JOIN Strutture_Servizi AS SS 
ON S.IdServizio=SS.IdServizio
join Strutture as st
on st.IdStruttura=Ss.IdStruttura
WHERE TipologiaServizi=@servizio
GO
/****** Object:  StoredProcedure [dbo].[Mostra.Tipo]    Script Date: 18-Feb-22 15:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Mostra.Tipo]
@tipologia NVARCHAR(50)
AS

SELECT
		
		st.IdStruttura,
		st.Nome,
		st.Tipologia


FROM  Strutture as st

WHERE Tipologia=@tipologia 
GO
/****** Object:  StoredProcedure [dbo].[Mostra.TipoPernottamento]    Script Date: 18-Feb-22 15:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Mostra.TipoPernottamento]
@tipoPernottamento NVARCHAR(50)
AS

SELECT
		
		st.IdStruttura,
		st.Nome,
		st.Citta,
		st.Stato,
		st.Tipologia


FROM  Strutture as st
JOIN Strutture_Pernottamento as SS
ON st.IdStruttura=SS.IdStruttura
join Pernottamenti as p
on p.IdPernottamento=SS.IdPernottamento

WHERE p.FormulaPernottamento=@tipoPernottamento 
GO
/****** Object:  StoredProcedure [dbo].[Strutture.Disponibili]    Script Date: 18-Feb-22 15:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Strutture.Disponibili]
 @tipoStrutture nvarchar(50), @servizio nvarchar(50)
as
select
		st.IdStruttura,
		se.TipologiaServizi,
		Pt.FormulaPernottamento


from Strutture as ST
join Strutture_Pernottamento AS P ON 
ST.IdStruttura=p.IdStruttura
JOIN Pernottamenti AS PT
ON PT.IdPernottamento=P.IdPernottamento
JOIN Strutture_Servizi AS  SS
ON SS.IdStruttura=ST.IdStruttura
join Servizi as se
on se.IdServizio=ss.IdServizio

WHERE st.Tipologia=@tipoStrutture
AND se.TipologiaServizi=@servizio
GO
USE [master]
GO
ALTER DATABASE [MartinaTiso.Gestione_Strutture] SET  READ_WRITE 
GO
