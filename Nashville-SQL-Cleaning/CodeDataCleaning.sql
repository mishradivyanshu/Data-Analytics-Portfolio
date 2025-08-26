--- converted the x;sx file into a csv file and uploaded that via import flat file task

SELECT * FROM NashvilleHousingdata

-- the SaleDate column, rn it is in date time format but time is irrelevant so we will get only the date part
-- it is in YYYY-MM-DD format if we need to change it to DD-MM-YYYY we use "CONVERT(VARCHAR, SaleDate, 105) AS FormattedDate"

SELECT SaleDate FROM NashvilleHousingData

-- to update the actual data in table and not just get the converted date using select as above

UPDATE NashvilleHousingData
SET SaleDate = CONVERT(Date,SaleDate)


-- Populate property address data as it has sone NULL values.
-- It's just a messy dataset, we may not find a particular reason for NULL values as logically a property shbould have an address

SELECT *
FROM NashvilleHousingData
WHERE PropertyAddress is null

-- we do have a lot of other information though for these properties(other columns are populated) so we need to figure out to populate this and can't just delete the entire data
-- Exploring the data we can see that rows with same parcelID also have same PropertyAddress that will help repopulate the NULL values

SELECT N1.ParcelId, N1.PropertyAddress, N2.ParcelId, N2.PropertyAddress, ISNULL(N1.PropertyAddress,  N2.PropertyAddress)
FROM NashvilleHousingData N1 JOIN NashvilleHousingData N2 
ON N1.ParcelId=N2.ParcelId AND N1.UniqueId <> N2.UniqueId
WHERE N1.PropertyAddress is null

-- ISNULL will get propertyadreess form N2 and set that in propertyaddress N1

UPDATE N1
SET N1.PropertyAddress = ISNULL(N1.PropertyAddress,  N2.PropertyAddress)
FROM NashvilleHousingData N1 JOIN NashvilleHousingData N2 
ON N1.ParcelId=N2.ParcelId AND N1.UniqueId <> N2.UniqueId
WHERE N1.PropertyAddress is null

SELECT * FROM NashvilleHousingData WHERE PropertyAddress is null


-- We need to splot address into multiple columns like state, country etc
-- We will get index of delimiter using char index and use substring to get the data from start to that index in one columns and from that index to end in another column
-- this works for Propertry address as it only has one delimitter

ALTER TABLE NashvilleHousingData
ADD PropertySplitAddress nvarchar(255)
ALTER TABLE NashvilleHousingData
ADD PropertySplitCity nvarchar(255)

UPDATE NashvilleHousingData 
SET PropertySplitAddress = SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress)-1 )
UPDATE NashvilleHousingData
SET PropertySplitCity = SUBSTRING(propertyaddress, CHARINDEX(',', propertyaddress)+1, LEN(propertyaddress))

--now, for owner address we need to find a different approacj
-- there is a function parsename that splits it using a period(.)
-- we will replace the , with a . and use that

SELECT PARSENAME(REPLACE(OwnerAddress, ',','.'), 3) AS OwAddress,
PARSENAME(REPLACE(OwnerAddress, ',','.'), 2)  AS City , 
PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)  AS State
FROM NashvilleHousingData

ALTER TABLE NashvilleHousingData
ADD OwnerSplitAddress nvarchar(225), OwnerSplitCity nvarchar(225), OwnerSplitState nvarchar(225)

UPDATE NashvilleHousingData
SET OwnerSplitAddress =  PARSENAME(REPLACE(OwnerAddress, ',','.'), 3),
OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',','.'), 2) ,
OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)

SELECT * FROM NashvilleHousingData


-- look at SoldAsvacant columns it has 1 and 0 and it is a bit datataype we need to convert this into a yes and no data which is varchar/string
SELECT 
CASE WHEN SoldAsVacant = 1 then 'Yes'
     WHEN SoldAsVacant = 0 then 'No'
	 --ELSE SoldAsVacant
END As newCo
FROM NashvilleHousingData

-- 1. Add a new column of VARCHAR type
-- Drop the old BIT column
ALTER TABLE NashvilleHousingData 
DROP COLUMN SoldAsVacant;

-- Add the new VARCHAR column
ALTER TABLE NashvilleHousingData 
ADD SoldAsVacant VARCHAR(10);


-- 2. Populate it with Yes/No
UPDATE NashvilleHousingData
SET SoldAsVacant = CASE 
                          WHEN SoldAsVacant = 1 THEN 'Yes'
                          ELSE 'No'
                       END;


---- Remove duplicates
-- if there are multiple columns which have the same data, it might be unusabel as in may be removed

SELECT * FROM NashvilleHousingData

WITH RnCTE AS (
SELECT ROW_NUMBER()OVER(
					Partition by ParcelId, PropertyAddress, SaleDate, SalePrice, LegalReference
					ORDER BY UniqueId ) AS RowNumber, *
FROM NashvilleHousingData )
DELETE FROM RnCTE
WHERE RowNumber >1

--Delete unused column: this will be depend on your requirement. this is done for views not the real data

ALTER TABLE NashvilleHousingData
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

SELECT * FROM NashvilleHousingData









