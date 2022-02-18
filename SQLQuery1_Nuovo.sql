CREATE DATABASE [MartinaTiso.Gestione_Strutture]

                                                                                --CREAZIONE TABELLA STRUTTURE--

CREATE TABLE Strutture(
IdStruttura									INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Nome										NVARCHAR(50) NOT NULL,
Citta										NVARCHAR(50) NOT NULL,
Stato										NVARCHAR(50) NOT NULL,
Tipologia									NVARCHAR(50) NOT NULL,
CONSTRAINT CHK_tipologia CHECK (Tipologia='Hotel'OR Tipologia='Case Vacanze' OR Tipologia='Residence'),
)
                                                                      ---Inserimento dei dati della tabella Strutture---
INSERT Strutture VALUES('FantaGhirò','Roma','Italia','Hotel'),
						('Disney','Parigi','Francia','Residence'),
						('Baita','Dolomiti','Italia','Case Vacanze'),
						('Frankfurt','Francoforte','Germania','Residence'),
						('Hola','Andalucia','Spagna','Case Vacanze')



                                                                                         --CREAZIONE TABELLA SERVIZI--
CREATE TABLE Servizi(
IdServizio									INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
TipologiaServizi							NVARCHAR(50) NOT NULL,
CONSTRAINT CHK_TipologiaServizi CHECK (TipologiaServizi='Piscina'OR TipologiaServizi='WiFi' OR TipologiaServizi='Cassaforte'OR TipologiaServizi='Spa&Centro benessere'OR TipologiaServizi='Animali Ammessi'),
)
                                                                        ---Inserimento valori nella tabella Servizi---

INSERT Servizi VALUES('Piscina'),
					('WiFi'),
					('Cassaforte'),
					('spa&Centro benessere'),
					('Animali Ammessi')


 select * from Servizi                                                                      ---CREAZIONE TABELLA STRUTTURE_SERVIZI--

CREATE TABLE Strutture_Servizi(
IdStruttura INT FOREIGN KEY REFERENCES Strutture(IdStruttura),
IdServizio INT FOREIGN KEY REFERENCES Servizi(IdServizio))

                                                                          --inserimento valori nella tabella Strutture_servizi--
INSERT Strutture_Servizi VALUES(1,1),
							(2,2),
							(3,1),
							(4,3),
							(5,4)


select * from Strutture_Servizi
                                                                                 --CREAZIONE TABELLA PERNOTTAMENTI--
CREATE TABLE Pernottamenti(
IdPernottamento								INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
FormulaPernottamento						NVARCHAR(50) NOT NULL,
CONSTRAINT CHK_FormulaPernottamento CHECK (FormulaPernottamento='Solo Pernottamento'OR FormulaPernottamento='Prima Colazione' OR FormulaPernottamento='Mezza Pensione'OR FormulaPernottamento='Pensione Completa'),

)


                                                                     --inserimento dei valori nella tabella Pernottamento---

INSERT Pernottamenti VALUES('Solo Pernottamento'),
							('Prima Colazione'),
							('Mezza Pensione'),
							('Pensione Completa'),
							('Prima Colazione')
                                                                            --CREAZIONE TABELLA STRUTTURE_PERNOTTAMENTI--

CREATE TABLE Strutture_Pernottamento(
IdStruttura INT FOREIGN KEY REFERENCES Strutture(IdStruttura),
IdPernottamento INT FOREIGN KEY REFERENCES Pernottamenti(IdPernottamento),
Costo			FLOAT NOT NULL)
																	---INSERIMENTO VALORI TABELLA sTRUTTURE_PERNOTTAMENTI--
INSERT Strutture_Pernottamento VALUES(1,3,60),
										(2,4,100),
										(3,1,20),
										(4,2,54),
										(5,5,90)



                                                                               --CREAZIONE TABELLA CLIENTI--
CREATE TABLE Clienti(
IdCliente			INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Nome				NVARCHAR(50) NOT NULL,
Cognome				NVARCHAR(50) NOT NULL,
DataDiNascita		DATE NOT NULL)
																		---inserimento dei valori nella tabella clienti--
INSERT Clienti VALUES('Martina','Tiso','1991-04-23'),
						('Serena','Rossi','1996-03-25'),
						('Raffaele','Bianchi','1962-06-24'),
						('Davide','Mazza','1984-12-08'),
						('Maria','R','2001-12-09')

                                                                               ---CREAZIONE TABELLA PRENOTAZIONI---
CREATE TABLE Prenotazioni(
IdPrenotazione		INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
DataArrivo			DATE NOT NULL,
DataPartenza		DATE NOT NULL,
NumeroPersone		INT NOT NULL,
IdCliente			INT FOREIGN KEY REFERENCES Clienti(IdCliente),
IdStruttura			INT FOREIGN KEY REFERENCES Strutture(IdStruttura),
IdPernottamento		INT FOREIGN KEY REFERENCES Pernottamenti(IdPernottamento))


--Creare una stored procedure che, scelto un servizio, mostri tutte le strutture che lo offrono.

CREATE PROCEDURE [Mostra.Servizi]
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

EXEC [Mostra.Servizi]  'Piscina'
EXEC [Mostra.Servizi] 'spa&Centro benessere'

--Creare una stored procedure che, scelto un tipo di struttura, mostri le strutture di quel tipo.

CREATE PROCEDURE [Mostra.Tipo]
@tipologia NVARCHAR(50)
AS

SELECT
		
		st.IdStruttura,
		st.Nome,
		st.Tipologia


FROM  Strutture as st

WHERE Tipologia=@tipologia 

EXEC [Mostra.Tipo]  'Hotel'
EXEC [Mostra.Tipo] 'Residence'




--Creare una stored procedure che, scelto un tipo di pernottamento, mostri le strutture di quel tipo.

CREATE PROCEDURE [Mostra.TipoPernottamento]
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

exec [Mostra.TipoPernottamento] 'Mezza Pensione'
EXEC [Mostra.TipoPernottamento] 'Prima Colazione'




--Creare una stored procedure che scelta una struttura, una data di arrivo, una data di partenza 
--e il numero di persone per cui si vuole prenotare, salvi le informazioni in una tabella 
--chiamata Prenotazioni.



CREATE PROCEDURE Inserimento
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

exec Inserimento '2022-02-02', '2022-02-18',4 , 1, 1 ,2
exec Inserimento '2022-02-14','2022-02-14' ,1,  2, 2 ,2
exec Inserimento '2022-02-18','2022-02-01' ,6,  3, 3, 4
exec Inserimento '2022-02-14','2022-02-13' ,3,  4, 4, 1
exec Inserimento '2022-01-01','2022-01-04' ,2,  5, 2, 3



--Creare una vista che mostri tutte le prenotazioni(cliente, data arrivo, data partenza, numero persone,
--nome struttura, tipo struttura, totale(prezzo * giorni * persone)

CREATE VIEW [Mostra.Prenotazioni]
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

SELECT *  from [Mostra.Prenotazioni]


--Creare una vista che mostri il guadagno di ogni struttura.

CREATE VIEW [Mostra.Guadagno]
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


--Quindi creare una stored procedure che ricevuti in ingresso la tipologia della struttura,
--un servizio offerto e una tipologia di pernottamento, mostri le strutture disponibili.

create procedure [Strutture.Disponibili]
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


exec [Strutture.Disponibili] 'Piscina','Solo Pernottamento'