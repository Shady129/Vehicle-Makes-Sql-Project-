use Vehicle_Makes EXEC sp_changedbowner 'sa'
--Create create view VehicleMasterDetails

SELECT VehicleDetails.ID , VehicleDetails.MakeID , Makes.Make as Make , VehicleDetails.ModelID ,
   MakeModels.ModelName as ModelName , VehicleDetails.SubModelID , SubModels.SubModelName As SubModelName,
   VehicleDetails.BodyID , Bodies.BodyName As BodyName  , VehicleDetails.Vehicle_Display_Name , VehicleDetails.Year,
   VehicleDetails.DriveTypeID , DriveTypes.DriveTypeName As DriveTypeName , VehicleDetails.Engine,
    VehicleDetails.Engine_CC ,VehicleDetails.Engine_Cylinders ,VehicleDetails.Engine_Liter_Display,
	 VehicleDetails.FuelTypeID , FuelTypes.FuelTypeName AS FuelTypeName , VehicleDetails.NumDoors FROM VehicleDetails 

 join Makes ON VehicleDetails.MakeID = Makes.MakeID
 join MakeModels ON VehicleDetails.ModelID = MakeModels.ModelID
 join SubModels on VehicleDetails.SubModelID = SubModels.SubModelID
 join Bodies on VehicleDetails.BodyID = Bodies.BodyID
 join DriveTypes on VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID
 join FuelTypes on VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID;

 --Get all vehicles made between 1950 and 2000

 SELECT Vehicle_Display_Name FROM VehicleDetails
 WHERE Year between 1950 and 2000;


 --Get number vehicles made between 1950 and 2000.

 SELECT COUNT(*) AS 'NumberOfVehicles'
 FROM VehicleDetails
 WHERE Year between 1950 and 2000;


 --Get number vehicles made between 1950 and 2000 per make and order them by Number Of Vehicles Descending

SELECT Makes.Make, COUNT(*) AS 'Number Of Vehicles'
FROM VehicleDetails
JOIN Makes 
ON	VehicleDetails.MakeID = Makes.MakeID
WHERE Year between 1950 and 2000
GROUP BY Makes.Make
ORDER BY 'Number Of Vehicles' DESC;


--Get All Makes that have manufactured more than 12000 Vehicles in years 1950 to 2000.

SELECT Make, COUNT(*) AS 'Number Of Vehicles'
FROM VehicleDetails
JOIN Makes 
ON VehicleDetails.MakeID = Makes.MakeID
WHERE Year between 1950 and 2000
GROUP BY Makes.Make
Having COUNT(*) > 12000
ORDER BY 'Number Of Vehicles' DESC;


-- Another Solution By using SubQuery Without HAVING.

SELECT * FROM
(SELECT Make, COUNT(*) AS NumberOfVehicles
FROM VehicleDetails
JOIN Makes 
ON VehicleDetails.MakeID = Makes.MakeID
WHERE Year between 1950 and 2000
GROUP BY Makes.Make) AS RI

WHERE NumberOfVehicles > 12000
ORDER BY NumberOfVehicles DESC;


--Get number of vehicles made between 1950 and 2000 per make and
--add total vehicles column beside it,
--then calculate it's percentage


SELECT *, CAST(NumberOfVehicles AS float) / CAST(TotalVehicles AS float) as p FROM
(SELECT Makes.Make, count(*) as NumberOfVehicles , (select count(*) from VehicleDetails)AS TotalVehicles
FROM VehicleDetails
JOIN Makes
ON VehicleDetails.MakeID = Makes.MakeID
WHERE Year between 1950 and 2000
GROUP BY Make)R1
ORDER BY NumberOfVehicles DESC;


--Get Make, FuelTypeName and Number of Vehicles per FuelType per Make

SELECT Makes.Make, FuelTypeName , COUNT(*) AS NumberofVehicles  
FROM
VehicleDetails
JOIN Makes
ON VehicleDetails.MakeID = Makes.MakeID
Join FuelTypes
ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
WHERE Year between 1950 and 2000
GROUP BY Make, FuelTypeName
ORDER BY Makes.Make;


--Get all vehicles that runs with GAS

SELECT *
FROM
VehicleDetails
Join FuelTypes
ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
WHERE FuelTypes.FuelTypeName = 'GAS';


--Get all Makes that runs with GAS

SELECT Distinct Makes.Make, FuelTypeName  
FROM VehicleDetails
JOIN Makes
ON VehicleDetails.MakeID = Makes.MakeID
Join FuelTypes
ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
WHERE FuelTypes.FuelTypeName = 'GAS'
ORDER BY Makes.Make;


 --Get Total Makes that runs with GAS

SELECT COUNT(Distinct Makes.Make) 'Total Makes that runs with GAS'
FROM VehicleDetails
JOIN Makes
ON VehicleDetails.MakeID = Makes.MakeID
Join FuelTypes
ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
WHERE FuelTypes.FuelTypeName = 'GAS'
GROUP BY FuelTypeName;


--Count Vehicles by make and order them by NumberOfVehicles from high to low.

SELECT Makes.Make, COUNT(*) NumberOfVehicles FROM VehicleDetails
JOIN Makes
ON VehicleDetails.MakeID = Makes.MakeID
GROUP BY Make
ORDER BY NumberOfVehicles DESC;


--Get all Makes/Count Of Vehicles that manufactures more than 20K Vehicles

SELECT Make, COUNT(*) AS NumberOfVehicles FROM VehicleDetails
JOIN Makes 
ON VehicleDetails.MakeID = Makes.MakeID
GROUP BY Make
HAVING COUNT(*) > 20000
ORDER BY NumberOfVehicles DESC;


--Get all Makes with make starts with 'B'

SELECT Make FROM Makes
WHERE Make LIKE 'B%';


--Write a query to get all Makes with make ends with 'W'.

SELECT Make FROM Makes
WHERE Make LIKE '%%W';


--Get all Makes that manufactures DriveTypeName = FWD

SELECT * FROM VehicleDetails
JOIN DriveTypes
ON VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID
Join Makes
ON VehicleDetails.MakeID = Makes.MakeID
WHERE DriveTypeName = 'FWD';


--Get total Makes that Mantufactures DriveTypeName=FWD

SELECT COUNT(distinct Make) AS MakeWithFWD FROM VehicleDetails
JOIN DriveTypes
ON VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID
Join Makes
ON VehicleDetails.MakeID = Makes.MakeID
WHERE DriveTypeName = 'FWD';


--Get total vehicles per DriveTypeName Per Make and order them per make asc then per total Desc

SELECT DISTINCT Make, DriveTypeName, COUNT(*) TotalVehicles FROM VehicleDetails
JOIN Makes 
ON VehicleDetails.MakeID = Makes.MakeID
JOIN DriveTypes
ON VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID
GROUP BY Make , DriveTypeName
ORDER BY Make ASC, DriveTypeName DESC;


--Get total vehicles per DriveTypeName Per Make then filter only results with total > 10,000

SELECT Makes.Make, DriveTypes.DriveTypeName, COUNT(*) AS TotalVehicles FROM VehicleDetails
JOIN Makes
ON VehicleDetails.MakeID = Makes.MakeID
JOIN DriveTypes
ON  VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID
GROUP BY DriveTypes.DriveTypeName, Makes.Make 
HAVING COUNT(*)  > 10000
ORDER BY Make ASC, TotalVehicles DESC;


--Get all Vehicles that number of doors is not specified

SELECT count(*) as TotalWithSpecifiedDoors FROM VehicleDetails
WHERE VehicleDetails.NumDoors IS NULL;


--Get Total Vehicles that number of doors is not specified

SELECT count(*) as TotalWithNoSpecifiedDoors FROM VehicleDetails
WHERE VehicleDetails.NumDoors IS NOT NULL;


--Get percentage of vehicles that has no doors specified

SELECT (
CAST (  (SELECT count(*) as TotalWithNoSpecifiedDoors FROM VehicleDetails
WHERE VehicleDetails.NumDoors IS NULL )AS FLOAT) 
/ 
CAST( (SELECT count(*) as TotalWithSpecifiedDoors FROM VehicleDetails
WHERE NumDoors IS NOT NULL) AS FLOAT ) 

) AS  PercOfNoSpecifiedDoors;


--Get MakeID , Make, SubModelName for all vehicles that have SubModelName 'Elite'

SELECT  distinct VehicleDetails.MakeID , Make, SubModelName FROM VehicleDetails
JOIN Makes 
ON VehicleDetails.MakeID = Makes.MakeID
JOIN SubModels
ON VehicleDetails.SubModelID = SubModels.SubModelID
WHERE SubModels.SubModelName = 'Elite';


--Get all vehicles that have Engines > 3 Liters and have only 2 doors

SELECT * FROM VehicleDetails
WHERE (VehicleDetails.Engine_Liter_Display > 3 AND VehicleDetails.NumDoors = 2)


--Get make and vehicles that the engine contains 'OHV' and have Cylinders = 4

SELECT DISTINCT Makes.Make, VehicleDetails.* FROM VehicleDetails
JOIN Makes
ON VehicleDetails.MakeID = Makes.MakeID
WHERE (VehicleDetails.Engine LIKE '%OHV%') AND (VehicleDetails.Engine_Cylinders =4);


--Get all vehicles that their body is 'Sport Utility' and Year > 2020

SELECT Bodies.BodyName,VehicleDetails.* FROM VehicleDetails
JOIN Bodies
ON VehicleDetails.BodyID = Bodies.BodyID
WHERE (Bodies.BodyName = 'Sport Utility') AND (VehicleDetails.Year > 2020),


--Get all vehicles that their Body is 'Coupe' or 'Hatchback' or 'Sedan'

SELECT Bodies.BodyName,VehicleDetails.* FROM VehicleDetails
JOIN Bodies
ON VehicleDetails.BodyID = Bodies.BodyID
WHERE Bodies.BodyName IN ('Coupe', 'Hatchback' , 'Sedan')


--Get all vehicles that their body is 'Coupe' or 'Hatchback' or 'Sedan' and manufactured in year 2008 or 2020 or 2021

SELECT Bodies.BodyName,VehicleDetails.* FROM VehicleDetails
JOIN Bodies
ON VehicleDetails.BodyID = Bodies.BodyID
WHERE Bodies.BodyName IN ('Coupe', 'Hatchback' , 'Sedan') AND VehicleDetails.Year IN  (2008 , 2020 , 2021)


--Return found=1 if there is any vehicle made in year 1950



--Get all Vehicle_Display_Name, NumDoors and add extra column to describe number of doors by words, and if door is null display 'Not Set'


SELECT DISTINCT VehicleDetails.Vehicle_Display_Name, VehicleDetails.NumDoors,
CASE 
	WHEN VehicleDetails.NumDoors = 0 THEN 'ZERO DOORS'
	WHEN VehicleDetails.NumDoors = 2 THEN 'ONE DOORS'
	WHEN VehicleDetails.NumDoors = 3 THEN 'TWO DOORS'
	WHEN VehicleDetails.NumDoors = 4 THEN 'THREE DOORS'
	WHEN VehicleDetails.NumDoors = 5 THEN 'FOUR DOORS'
	WHEN VehicleDetails.NumDoors = 6 THEN 'FIVE DOORS'
	WHEN VehicleDetails.NumDoors = 7 THEN 'SIX DOORS'
	WHEN VehicleDetails.NumDoors IS NULL THEN 'NOT SET'
	ELSE 'UNKNOWN'
END AS DOORDESCRIPTION
FROM VehicleDetails;


--Get all Vehicle_Display_Name, year and add extra column to calcuate the age of the car then sort the results by age desc.

SELECT Vehicle_Display_Name, year, YEAR(GetDate()) - Year AS AGE
FROM VehicleDetails


--Get all Vehicle_Display_Name, year, Age for vehicles that their age between 15 and 25 years old 

SELECT * FROM
(SELECT Vehicle_Display_Name, year, YEAR(GETDATE()) - YEAR AS AGE
FROM VehicleDetails)R1
WHERE AGE BETWEEN 15 and 25;


--Get Minimum Engine CC , Maximum Engine CC , and Average Engine CC of all Vehicles

SELECT MIN(VehicleDetails.Engine_CC)AS MinimumEngineCC, MAX(VehicleDetails.Engine_CC)AS MaximumEngineCC, AVG(VehicleDetails.Engine_CC) AS AverageEngineCC
FROM VehicleDetails;


--Get all vehicles that have the minimum Engine_CC

SELECT VehicleDetails.Vehicle_Display_Name from VehicleDetails
WHERE VehicleDetails.Engine_CC = (SELECT MIN(VehicleDetails.Engine_CC) FROM VehicleDetails)


--Get all vehicles that have the Maximum Engine_CC

SELECT VehicleDetails.Vehicle_Display_Name FROM VehicleDetails
WHERE VehicleDetails.Engine_CC = (SELECT MAX(VehicleDetails.Engine_CC) FROM VehicleDetails)


--Get all vehicles that have Engin_CC below average

SELECT VehicleDetails.Vehicle_Display_Name, VehicleDetails.Engine_CC  FROM VehicleDetails
WHERE VehicleDetails.Engine_CC < (SELECT AVG(VehicleDetails.Engine_CC) FROM VehicleDetails)


--Get all vehicles that have Engin_CC above average

SELECT VehicleDetails.Vehicle_Display_Name, VehicleDetails.Engine_CC  FROM VehicleDetails
WHERE VehicleDetails.Engine_CC > (SELECT AVG(VehicleDetails.Engine_CC) FROM VehicleDetails)


--Get Total vehicles that have Engin_CC above average

SELECT COUNT(*) AS NumberOfVehiclesAboveAverageEngineCC FROM
(SELECT VehicleDetails.Vehicle_Display_Name, VehicleDetails.Engine_CC  FROM VehicleDetails
WHERE VehicleDetails.Engine_CC > (SELECT AVG(VehicleDetails.Engine_CC) FROM VehicleDetails))R1


--Get all unique Engin_CC and sort them Desc

SELECT DISTINCT VehicleDetails.Engine_CC
FROM VehicleDetails
ORDER BY VehicleDetails.Engine_CC DESC;


--Get the maximum 3 Engine CC

SELECT DISTINCT TOP 3 VehicleDetails.Engine_CC
FROM VehicleDetails
Order By Engine_CC Desc;


--Get all vehicles that has one of the Max 3 Engine CC

SELECT  VehicleDetails.Engine_CC FROM VehicleDetails
WHERE VehicleDetails.Engine_CC IN ( SELECT DISTINCT TOP 3 VehicleDetails.Engine_CC
FROM VehicleDetails);



Select Vehicle_Display_Name, VehicleDetails.Engine_CC from VehicleDetails
where Engine_CC in 
(
	Select  distinct top 3 Engine_CC from VehicleDetails
	Order By Engine_CC Desc
);


--Get all Makes that manufactures one of the Max 3 Engine CC

SELECT DISTINCT Makes.Make, VehicleDetails.Engine_CC FROM VehicleDetails
JOIN Makes
ON VehicleDetails.MakeID = Makes.MakeID
WHERE (VehicleDetails.Engine_CC IN
(SELECT DISTINCT TOP (3) VehicleDetails.Engine_CC FROM VehicleDetails
Order By Engine_CC Desc));


---- Get a table of unique Engine_CC and calculate tax per Engine CC as follows:
	-- 0 to 1000    Tax = 100
	-- 1001 to 2000 Tax = 200
	-- 2001 to 4000 Tax = 300
	-- 4001 to 6000 Tax = 400
	-- 6001 to 8000 Tax = 500
	-- Above 8000   Tax = 600
	-- Otherwise    Tax = 0

SELECT DISTINCT Engine_CC, 
CASE 

	WHEN Engine_CC BETWEEN 0 AND 1000 THEN 100
	WHEN Engine_CC BETWEEN 1001 AND 2000 THEN 200
	WHEN Engine_CC BETWEEN 2001 AND 4000 THEN 300
	WHEN Engine_CC BETWEEN 4001 AND 6000 THEN 400
	WHEN Engine_CC BETWEEN 6001 AND 8000 THEN 500
	WHEN Engine_CC > 8000 THEN 600
	ELSE  0

END AS Tax

FROM VehicleDetails
ORDER BY Engine_CC DESC;


--Get Make and Total Number Of Doors Manufactured Per Make

SELECT Makes.Make, SUM(VehicleDetails.NumDoors) AS TotalNumberOfDoorsManufacturedPerMake
FROM VehicleDetails 
JOIN Makes
ON VehicleDetails.MakeID = Makes.MakeID
GROUP BY Makes.Make
ORDER BY TotalNumberOfDoorsManufacturedPerMake DESC;	


--Get Make and Total Number Of Doors Manufactured by 'Ford' Per Make 

SELECT Makes.Make,SUM(VehicleDetails.NumDoors) AS TotalNumberOfDoorsManufacturedbyFord
FROM VehicleDetails 
JOIN Makes
ON VehicleDetails.MakeID = Makes.MakeID
WHERE Makes.Make = 'Ford'
GROUP BY Makes.Make


--Get Number of Models Per Make
 
 SELECT Makes.Make,COUNT(MakeModels.ModelName) AS NumberofModelsPerMake FROM
 Makes
 JOIN MakeModels 
 ON Makes.MakeID = MakeModels.MakeID
 GROUP BY Make
 ORDER BY NumberofModelsPerMake DESC;


--Get the highest 3 manufacturers that make the highest number of models

SELECT DISTINCT TOP 3 Makes.Make, COUNT(MakeModels.ModelName) AS highest3manufacturers FROM 
 Makes
 JOIN MakeModels 
 ON Makes.MakeID = MakeModels.MakeID
 GROUP BY Makes.Make
 ORDER BY highest3manufacturers DESC;


 --Get the highest number of models manufactured
 
 SELECT MAX(highestmanufacturer) AS highestmanufacturer FROM
 
 (SELECT Makes.Make, COUNT(MakeModels.ModelName) AS highestmanufacturer FROM 
 Makes
 JOIN MakeModels 
 ON Makes.MakeID = MakeModels.MakeID
 GROUP BY Makes.Make
)R1



-- Get the highest Manufacturers manufactured the highest number of models , 
-- remember that they could be more than one manufacturer have the same high number of models

SELECT MAX(Manufacturers) AS thehighestManufacturers FROM(

SELECT Make AS MAKER , COUNT(MakeModels.ModelName) AS Manufacturers
FROM Makes
JOIN MakeModels
ON Makes.MakeID = MakeModels.MakeID
GROUP BY Make)R1

--Another Solution

SELECT TOP 1 MAX(Manufacturers) AS thehighestManufacturers FROM(

SELECT Make AS MAKER , COUNT(MakeModels.ModelName) AS Manufacturers
FROM Makes
JOIN MakeModels
ON Makes.MakeID = MakeModels.MakeID
GROUP BY Make)R1




-- Get the Lowest  Manufacturers manufactured the lowest number of models , 
-- remember that they could be more than one manufacturer have the same Lowest  number of models

SELECT TOP 1 MIN(Manufacturers) AS ThelowestManufacturers  FROM  
(SELECT Make, COUNT(MakeModels.ModelName) AS Manufacturers FROM Makes
JOIN MakeModels
ON MakeModels.MakeID = Makes.MakeID
GROUP BY Makes.Make)R1


-- Get all FuelTypes , each time the result should be showed in random order

SELECT * FROM FuelTypes
ORDER BY NewID();





