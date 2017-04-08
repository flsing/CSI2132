1.
REFERENCIAL INTEGRITY CONSTRAINTS. 

ALL OF THE FOREIGN KEYS BELOW 

	FOREIGN KEY(Flight_number) references Flight(Flight_number),
	FOREIGN KEY(Departure_airport_code) references Airport(Airport_code),
	FOREIGN KEY(Arrival_airport_code) references Airport(Airport_code)
	FOREIGN KEY(Flight_number) references Flight_Leg(Flight_number),
	FOREIGN KEY(Leg_number) references Flight_Leg(Leg_number),
	FOREIGN KEY(Airplane_id) references Airplane(Airplane_id),
	FOREIGN KEY(Departure_airport_code) references Airport(Airport_code),
	FOREIGN KEY(Arrival_airport_code) references Airport(Airport_code)
	FOREIGN KEY(Flight_number) references Flight(Flight_number)
	FOREIGN KEY(Airplane_type_name) references Airplane_type(Airplane_type_name),
	FOREIGN KEY(Airport_code) references Airport(Airport_code)
	FOREIGN key(Airplane_type) references Airplane_type(Airplane_type_name)
	FOREIGN KEY(Flight_number) references Flight(Flight_number),
	FOREIGN KEY(Leg_number) references Leg_Instance(Leg_number),
	FOREIGN KEY(Date) references Leg_Instance(Date),
	FOREIGN KEY(Flight_number) references Leg_Instance(Flight_number)


CREATE SCHEMA airline;
set search_path = 'airline';


CREATE TABLE Airport(
	Airport_code	char(10),
	Name 			varchar(30),
	City		varchar(10),
	State	varchar(10),
	PRIMARY KEY (Airport_code)
);

CREATE TABLE Flight(
	Flight_number	varchar(30),
	Airline 	varchar(30),
	Weekdays	varchar(10)	NOT NULL,
	PRIMARY KEY (Flight_number)
);

CREATE TABLE Flight_Leg(
	Flight_number	varchar(30),
	Leg_number		integer,
	Departure_airport_code	char(3),
	Scheduled_departure_time	time with time zone,
	Arrival_airport_code	char(3),
	Scheduled_arrival_time	time with time zone,
	PRIMARY KEY(Flight_number, Leg_number),
	FOREIGN KEY(Flight_number) references Flight(Flight_number),
	FOREIGN KEY(Departure_airport_code) references Airport(Airport_code),
	FOREIGN KEY(Arrival_airport_code) references Airport(Airport_code)
);

CREATE TABLE Leg_Instance(
		Flight_number	varchar(30),
		Leg_number		integer,
		Date 	date,
		Number_of_available_seats	integer,
		Airplane_id	varchar(30),
		Departure_airport_code	char(3),
		Departure_time 	time with time zone,
		Arrival_airport_code	char(3),
		Arrival_time 	time with time zone,
		PRIMARY KEY(Flight_number,Leg_number,Date),
		FOREIGN KEY(Flight_number) references Flight_Leg(Flight_number),
		FOREIGN KEY(Leg_number) references Flight_Leg(Leg_number),
		FOREIGN KEY(Airplane_id) references Airplane(Airplane_id),
		FOREIGN KEY(Departure_airport_code) references Airport(Airport_code),
		FOREIGN KEY(Arrival_airport_code) references Airport(Airport_code)
);

CREATE TABLE Fare(
	Flight_number varchar(30),
	Fare_code	integer,
	Amount	money,
	Restrictions	text,
	PRIMARY KEY(Fare_code,Flight_number),
	FOREIGN KEY(Flight_number) references Flight(Flight_number)
);

CREATE TABLE Airplane_type(
	Airplane_type_name	varchar(30),
	Max_Seats integer	NOT NULL,
	Company	varchar(30),
	PRIMARY KEY(Airplane_type_name)
);

CREATE TABLE Can_Land(
	Airplane_type_name	varchar(30),
	Airport_code 	char(3)	NOT NULL,
	PRIMARY KEY(Airplane_type_name, Airport_code),
	FOREIGN KEY(Airplane_type_name) references Airplane_type(Airplane_type_name),
	FOREIGN KEY(Airport_code) references Airport(Airport_code)
);

CREATE TABLE Airplane(
	Airplane_id		varchar(30),
	Total_number_of_seats	integer NOT NULL,
	Airplane_type 		varchar(30)	NOT NULL,
	PRIMARY KEY(Airplane_id),
	FOREIGN key(Airplane_type) references Airplane_type(Airplane_type_name)
);

CREATE TABLE Seat_Reservation(
	Flight_number		varchar(30),
	Leg_number		varchar(30),
	Date 	date,
	Seat_number 	varchar(4),
	Customer_name 	varchar(30)	NOT NULL,
	Customer_phone 	varchar(14),
	PRIMARY KEY(Seat_number,Flight_number,Leg_number,Date),
	FOREIGN KEY(Flight_number) references Flight(Flight_number),
	FOREIGN KEY(Leg_number) references Leg_Instance(Leg_number),
	FOREIGN KEY(Date) references Leg_Instance(Date),
	FOREIGN KEY(Flight_number) references Leg_Instance(Flight_number)
);




CREATE SCHEMA assign2;
set search_path = 'assign2';

CREATE TABLE Student (
	Name varchar(30),
	Student_number integer,
	Class integer,
	Major varchar(10),
	primary key(Student_number)
);


CREATE TABLE Course(
	Course_name varchar(30),
	Course_number varchar(20),
	Credit_hours integer,
	Department varchar(5),
	primary key(Course_number)

);

CREATE TABLE Section(
	Section_identifier integer,
	Course_number	varchar(30),
	Semester	varchar(20),
	Year	integer,
	Instructor	varchar(30),
	primary KEY(Section_identifier),
	FOREIGN KEY (Course_number) references COURSE(Course_number)
);

CREATE TABLE Grade_report(
	Student_number integer,
	Section_identifier integer,
	Grade char,
	FOREIGN key (Student_number) references Student(Student_number),
	FOREIGN KEY (Section_identifier) references Section(Section_identifier)
);

CREATE TABLE Prerequisite( 
	Course_number varchar(10),
	Prerequisite_number varchar(10),
	FOREIGN KEY (Course_number) references Course (Course_number),
	FOREIGN KEY (Prerequisite_number) references Course(Course_number)
);

INSERT INTO Student
VALUES ('Smith',17,1,'CS'),('Brown',8,2,'CS');

INSERT INTO Course 
VALUES ('Intro to Computer Science','CS1310',4,'CS'),('Data Structures','CS3320',4,'CS'),
('Discrete Mathematics','MATH2410',3,'MATH'),('Database','CS3380',3,'CS');

INSERT INTO Section
VALUES (85,'MATH2410','FALL',07,'KING'),(92,'CS1310','FALL',07,'Anderson'),
(102,'CS3320','Spring',08,'Knuth'),(112,'MATH2410','FALL',08,'Chang'),
(119,'CS1310','FALL',08,'Anderson'),(135,'CS3380','FALL',08,'Stone');


INSERT INTO Grade_report
VALUES (17,112,'B'),(17,119,'C'),(8,85,'A'),(8,92,'A'),(8,102,'B'),
(8,135,'A');

INSERT INTO Prerequisite
VALUES ('CS3380','CS3320'),('CS3380','MATH2410'),('CS3320','CS1310');


2.

a) 
SELECT Name
FROM Student
WHERE Major = 'CS' AND Class=5;


b)
SELECT C.Course_name
FROM Course C, Section S
WHERE S.Instructor ='KING' AND (S.Year = 85 OR S.Year = 86)  AND C.Course_number = S.Course_number;
-- assumption: the question is not clear, im interpretting 85 and 86 to be years and not section identifiers. 
c)
SELECT S.Course_number, S.Semester, S.Year, Count(K.Student_Number)
FROM Section S, Grade_Report G, Student K
WHERE S.Instructor ='KING' AND S.Section_Identifier = G.Section_Identifier AND G.Student_number = K.Student_number
GROUP BY S.Course_number,S.Semester,S.Year;

d)
SELECT K.name, C.course_name, C.course_number, C.credit_hours, S.Semester, S.year, G.grade 
FROM Section S, Grade_Report G, Student K, Course C
WHERE K.student_number = G.student_number AND S.section_identifier = G.section_identifier AND S.course_number = C.course_number AND K.class=5 AND K.Major='CS';

e)
select S.name, S.major
from 	Student S
WHERE NOT EXISTS(SELECT *
			FROM Grade_report G
			WHERE S.student_number = g.student_number AND NOT(G.grade='A'));

f)
select S.name, S.major
from 	Student S
WHERE NOT EXISTS(SELECT *
			FROM Grade_report G
			WHERE S.student_number = g.student_number AND (G.grade='A'));



3

g)
INSERT INTO Student
values ('Johnson',25,1,'MATH');


h)
UPDATE Student
SET Class = 2
WHERE Name = 'Smith';


i)
INSERT INTO Course
VALUES ('Knowledge Engineering','CS4390',3,'CS')


j)
DELETE FROM Student
WHERE name='Smith' AND student_number = 17;


























