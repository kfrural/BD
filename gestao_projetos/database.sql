--exercicio 1
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ParentProjectID INT NULL,
    ProjectName VARCHAR(255),
    Description TEXT,
    FOREIGN KEY (ParentProjectID) REFERENCES Projects(ProjectID)
);

INSERT INTO Projects (ProjectID, ParentProjectID, ProjectName, Description)
VALUES 
(1, NULL, 'Projeto Principal', 'Descrição do projeto principal'),
(2, 1, 'Subprojeto 1', 'Descrição do subprojeto 1'),
(3, 1, 'Subprojeto 2', 'Descrição do subprojeto 2'),
(4, 2, 'Subprojeto 1.1', 'Descrição do subprojeto 1.1');

WITH RECURSIVE ProjectHierarchy AS (
    SELECT ProjectID, ParentProjectID, ProjectName, 1 AS Level
    FROM Projects
    WHERE ParentProjectID IS NULL
    UNION ALL
    SELECT p.ProjectID, p.ParentProjectID, p.ProjectName, ph.Level + 1
    FROM Projects p
    INNER JOIN ProjectHierarchy ph ON p.ParentProjectID = ph.ProjectID
)
SELECT * FROM ProjectHierarchy ORDER BY Level, ProjectID;

--exercicio 2
CREATE VIEW ProjectOverview AS
SELECT 
    p.ProjectID,
    p.ProjectName,
    COUNT(t.TaskID) AS TotalTasks,
    SUM(t.EstimatedHours) AS TotalEstimatedHours,
    SUM(t.ActualHours) AS TotalActualHours
FROM Projects p
LEFT JOIN Tasks t ON p.ProjectID = t.ProjectID
GROUP BY p.ProjectID, p.ProjectName;

SELECT * FROM ProjectOverview;

--exerccio 3
CREATE TRIGGER UpdateScheduleAfterTaskInsert
AFTER INSERT ON Tasks
FOR EACH ROW
BEGIN
    UPDATE Schedule
    SET EndDate = (SELECT MAX(EndDate) FROM Tasks WHERE ProjectID = NEW.ProjectID)
    WHERE ProjectID = NEW.ProjectID;
END;

-- exercico4
DECLARE
    TotalCost NUMBER;
    TotalDuration NUMBER;
BEGIN
    SELECT SUM(EstimatedCost), SUM(EstimatedHours)
    INTO TotalCost, TotalDuration
    FROM Tasks
    WHERE ProjectID = 1;

    DBMS_OUTPUT.PUT_LINE('Custo Total: ' || TotalCost);
    DBMS_OUTPUT.PUT_LINE('Duração Total: ' || TotalDuration);
END;


-- exercicio 5
CREATE INDEX idx_project_task ON Tasks (ProjectID, StartDate, EndDate);


--exercico 6
DELIMITER $$

CREATE FUNCTION TotalTimeSpent(ProjectID INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE TotalTime INT;
    SET TotalTime = 0;

    SELECT SUM(ActualHours)
    INTO TotalTime
    FROM Tasks
    WHERE ProjectID = ProjectID;

    RETURN TotalTime;
END$$

DELIMITER ;

--exercicio 7
SELECT *
FROM Employees e
WHERE EXISTS (
    SELECT 1
    FROM Tasks t
    WHERE t.EmployeeID = e.EmployeeID
    AND t.ProjectID = 1
);

--exercicoi 8
DELIMITER $$

CREATE PROCEDURE UpdateTaskDeadlines(ProjectID INT)
BEGIN
    UPDATE Tasks
    SET EndDate = DATE_ADD(StartDate, INTERVAL EstimatedDays DAY)
    WHERE ProjectID = ProjectID;
END$$

DELIMITER ;

