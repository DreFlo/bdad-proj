.mode	columns
.headers	on
.nullvalue	NULL

-- Cidade mais afetada em 2021

CREATE VIEW CC AS
SELECT County.name as CName, count(*) as Count
FROM COVIDCase JOIN (Parish JOIN County ON Parish.countyID = County.locID) ON parishID = Parish.locID
WHERE strftime('%Y', COVIDCase.detectionDate) = '2021'
GROUP BY County.locID;

SELECT CName as "County Name", max(Count) as "Number of Cases"
FROM CC;

DROP VIEW CC;