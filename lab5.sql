-- Can be used in Lab 5

SET search_path = "Lab2" ;

CREATE TABLE Artist 
( 
AName VARCHAR(20), 
Birthplace VARCHAR(20), 
Style VARCHAR(20), 
DateOfBirth DATE, 
PRIMARY KEY (AName)
); 

CREATE TABLE Artwork 
(Title VARCHAR(20), 
Year INTEGER, 
Type VARCHAR(20), 
Price NUMERIC(8,2), 
AName VARCHAR(20), 
PRIMARY KEY (Title), 
FOREIGN KEY(AName) 
REFERENCES Artist); 


CREATE TABLE Customer 
(
CustId INTEGER, 
Name VARCHAR(20), 
Address VARCHAR(20), 
Amount NUMERIC(8,2), 
PRIMARY KEY (CustId) 
);

CREATE TABLE LikeArtist 
(
CustId INTEGER, 
AName VARCHAR(20), 
PRIMARY KEY(Aname, CustId), 
FOREIGN KEY (Aname) 
REFERENCES Artist, 
FOREIGN KEY (CustId) 
REFERENCES Customer);

insert Into Customer(CustId,Name,Address,Amount) values
 (1,'John','Ottawa',8.5),
 (2,'Amy','Orleans',9.0) ,
 (3,'Peter','Gatineau',6.3);


insert Into Artist(AName,Birthplace, Style, DateOfBirth) values
 ('Van','Milan','Baroque','1571-09-28' ) ,
 ('Smith', 'Ottawa', 'Modern', '1977-12-12'), 
 ('Picasso','Malaga','Cubism','1881-10-25') ;


Insert InTo Artwork(Title,Year,Type,Price,AName) values 
('Blue', 2000,'Modern',10000.00,'Smith'),
 ('The Cardsharps', 1594,'Baroque',40000.00,'Van');

SELECT Style FROM Artist WHERE AName = 'Smith';   

select Aname from Artist where Birthplace = 'Ottawa';

select Title, Price from Artwork where Year = '2000';

select name from customer where Amount > 8;

UPDATE Customer 
SET Name = 'Bruce' WHERE CustId = 1;

Update Customer 
Set (Address, Amount) = ('Gatineau' , 9.8);
/* similar statment*/
Update Customer 
Set Address = 'Gatineau',  Amount = 9.8;

select * from artist;
insert into artwork values
('Saints', 1470, 'Renaissance', 30000.00, 'Van') ,
 ('Hand of god', 1510, 'Renaissance', 52000.00, 'Smith') ,
 ('Murder', 1600, 'Baroque', 15000.00, 'Van') ,
 ('Green', 1950, 'Modern', 5000.00, 'Picasso') ;
 
 insert into likeartist values 
 (1,'Van'),
 (1,'Smith'),
 (1,'Picasso'),
 (2,'Picasso');

			


