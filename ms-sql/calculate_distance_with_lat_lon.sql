/*
Method 1 – using formula (for all SQL versions, and of course you can apply to any programming languages)
*/
DECLARE @currentlocation_latitude float, @currentlocation_longitude float
DECLARE @destinationlocation_latitude float, @destinationlocation_longitude float
DECLARE @earthRadius float = 6371 --return result in kilometer, if you want to use in miles, replace by the number 3958.75
--------------------
SET @currentlocation_latitude = -36.87498611
SET @currentlocation_longitude = 174.73521111
SET @destinationlocation_latitude = -36.76176111
SET @destinationlocation_longitude = 174.72475000

SELECT (ACOS(SIN(PI()*@currentlocation_latitude/180.0)*SIN(PI()*@destinationlocation_latitude/180.0)+COS(PI()
			*@currentlocation_latitude/180.0)*COS(PI()*@destinationlocation_latitude/180.0)
			*COS(PI()*@destinationlocation_longitude/180.0-PI()*@destinationlocation_longitude/180.0))*@earthRadius) as Distance

/*
Method 2 – using new data type “geography” & formula “STDistance” (only for SQL 2008 or above)
*/
DECLARE @currentlocation geography
DECLARE @destinationlocation geography
--------------------
SET @currentlocation = geography::Point(-36.87498611,174.73521111,4326) --4326 is the Spatial Reference Identifiers (SRIDs), you can read more information on the Microsoft website
SET @destinationlocation = geography::Point(-36.76176111,174.72475000,4326)
	
SELECT @currloc.STDistance(geography::Point(@lat1, @lng1, 4326)) / 1000 as Distance --Return result in kilometer
