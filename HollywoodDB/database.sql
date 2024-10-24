CREATE TABLE Person (
    PID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Address VARCHAR(200),
    Gender VARCHAR(10),
    Type VARCHAR(20) CHECK (Type IN ('MovieProfessional', 'Celebrity', 'Sponsor'))
);

CREATE TABLE Married (
    PID_A INT,
    PID_B INT,
    PRIMARY KEY (PID_A, PID_B),
    FOREIGN KEY (PID_A) REFERENCES Person(PID) ON DELETE CASCADE,
    FOREIGN KEY (PID_B) REFERENCES Person(PID) ON DELETE CASCADE
);

CREATE TABLE Celebrity (
    PID INT PRIMARY KEY,
    BirthDate DATE,
    Agent_ID INT,
    FOREIGN KEY (PID) REFERENCES Person(PID) ON DELETE CASCADE,
    FOREIGN KEY (Agent_ID) REFERENCES Person(PID) ON DELETE SET NULL
);

CREATE TABLE Agent (
    PID INT PRIMARY KEY,
    Agency VARCHAR(100),
    FOREIGN KEY (PID) REFERENCES Person(PID) ON DELETE CASCADE
);

CREATE TABLE Project (
    Project_ID INT PRIMARY KEY,
    Cost DECIMAL(10,2),
    Location VARCHAR(200),
    Type VARCHAR(20) CHECK (Type IN ('FilmProject', 'ModelingProject')) 
);

CREATE TABLE Sponsor (
    Sponsor_ID INT PRIMARY KEY,
    Company VARCHAR(100),
    FOREIGN KEY (Sponsor_ID) REFERENCES Person(PID) ON DELETE CASCADE 
);

CREATE TABLE MovieProfessional (
    PID INT PRIMARY KEY,
    Company VARCHAR(100),
    FOREIGN KEY (PID) REFERENCES Person(PID) ON DELETE CASCADE
);

CREATE TABLE Critic (
    PID INT PRIMARY KEY,
    Popularity DECIMAL(5,2),
    FOREIGN KEY (PID) REFERENCES MovieProfessional(PID) ON DELETE CASCADE
);

CREATE TABLE MovieStar (
    PID INT PRIMARY KEY,
    MovieType VARCHAR(100),
    FOREIGN KEY (PID) REFERENCES Celebrity(PID) ON DELETE CASCADE
);

CREATE TABLE Models (
    PID INT PRIMARY KEY,
    Preferences VARCHAR(100),
    FOREIGN KEY (PID) REFERENCES Celebrity(PID) ON DELETE CASCADE
);

CREATE TABLE ActsIn (
    PID INT,
    Project_ID INT,
    PRIMARY KEY (PID, Project_ID),
    FOREIGN KEY (PID) REFERENCES MovieStar(PID) ON DELETE CASCADE,
    FOREIGN KEY (Project_ID) REFERENCES Project(Project_ID) ON DELETE CASCADE
);

CREATE TABLE FilmProject (
    Project_ID INT PRIMARY KEY,
    Title VARCHAR(200),
    FOREIGN KEY (Project_ID) REFERENCES Project(Project_ID) ON DELETE CASCADE
);

CREATE TABLE ModelsIn (
    PID INT,
    Project_ID INT,
    Paid VARCHAR(20),
    PRIMARY KEY (PID, Project_ID),
    FOREIGN KEY (PID) REFERENCES Models(PID) ON DELETE CASCADE,
    FOREIGN KEY (Project_ID) REFERENCES Project(Project_ID) ON DELETE CASCADE
);

CREATE TABLE Company (
    PID INT PRIMARY KEY,
    Name VARCHAR(100),
    FOREIGN KEY (PID) REFERENCES Person(PID) ON DELETE CASCADE
);

CREATE TABLE ModelingProject (
    Project_ID INT PRIMARY KEY,
    Description VARCHAR(200),
    Type VARCHAR(100),
    FOREIGN KEY (Project_ID) REFERENCES Project(Project_ID) ON DELETE CASCADE
);

CREATE TABLE SponsorModelingProject (
    Sponsor_ID INT,
    Project_ID INT,
    PRIMARY KEY (Sponsor_ID, Project_ID),
    FOREIGN KEY (Sponsor_ID) REFERENCES Sponsor(Sponsor_ID) ON DELETE CASCADE,
    FOREIGN KEY (Project_ID) REFERENCES ModelingProject(Project_ID) ON DELETE CASCADE
);

--ignorar daqui pra baixo
--insercao de dados pra testes

INSERT INTO Person (PID, Name, Phone, Address, Gender, Type) VALUES 
(1, 'Alice Johnson', '123-456-7890', '123 Elm St', 'Female', 'Celebrity'),
(2, 'Bob Smith', '234-567-8901', '456 Oak St', 'Male', 'MovieProfessional'),
(3, 'Carol White', '345-678-9012', '789 Pine St', 'Female', 'Sponsor'),
(4, 'David Brown', '456-789-0123', '321 Maple St', 'Male', 'MovieProfessional'),
(5, 'Eve Davis', '567-890-1234', '654 Cedar St', 'Female', 'Celebrity');

INSERT INTO Married (PID_A, PID_B) VALUES 
(1, 2), 
(1, 4); 

INSERT INTO Celebrity (PID, BirthDate, Agent_ID) VALUES 
(1, '1990-01-01', NULL), 
(5, '1995-05-15', NULL);

INSERT INTO Agent (PID, Agency) VALUES 
(2, 'Top Talent Agency'), 
(4, 'Best Movie Agency');

INSERT INTO Project (Project_ID, Cost, Location, Type) VALUES 
(101, 50000.00, 'Los Angeles', 'FilmProject'), 
(102, 30000.00, 'New York', 'ModelingProject');

INSERT INTO Sponsor (Sponsor_ID, Company) VALUES 
(3, 'Big Corp');

INSERT INTO MovieProfessional (PID, Company) VALUES 
(2, 'Production Co.'), 
(4, 'Film Makers Inc.');

INSERT INTO Critic (PID, Popularity) VALUES 
(2, 75.5), 
(4, 80.2);

INSERT INTO MovieStar (PID, MovieType) VALUES 
(1, 'Action'), 
(5, 'Drama');

INSERT INTO Models (PID, Preferences) VALUES 
(5, 'Fashion, Commercial');

INSERT INTO ActsIn (PID, Project_ID) VALUES 
(1, 101), 
(5, 102);

INSERT INTO FilmProject (Project_ID, Title) VALUES 
(101, 'Super Action Movie');

INSERT INTO ModelsIn (PID, Project_ID, Paid) VALUES 
(5, 102, 'Yes');

INSERT INTO Company (PID, Name) VALUES 
(2, 'Production Co.'), 
(4, 'Film Makers Inc.');

INSERT INTO ModelingProject (Project_ID, Description, Type) VALUES 
(102, 'Fashion Show 2024', 'Fashion');

--testes de exibicao
SELECT * FROM Person;

SELECT 
    P1.Name AS Person_A, 
    P2.Name AS Person_B 
FROM Married M
JOIN Person P1 ON M.PID_A = P1.PID
JOIN Person P2 ON M.PID_B = P2.PID;

SELECT 
    C.Name, 
    C.BirthDate 
FROM Celebrity C
JOIN Person P ON C.PID = P.PID;

SELECT 
    Project_ID, 
    Cost, 
    Location, 
    Type 
FROM Project;

SELECT 
    M.Name, 
    MS.MovieType 
FROM MovieStar MS
JOIN Person M ON MS.PID = M.PID;

SELECT 
    M.Name, 
    MD.Preferences 
FROM Models MD
JOIN Person M ON MD.PID = M.PID;

SELECT 
    P.Name, 
    S.Company 
FROM Sponsor S
JOIN Person P ON S.Sponsor_ID = P.PID;
