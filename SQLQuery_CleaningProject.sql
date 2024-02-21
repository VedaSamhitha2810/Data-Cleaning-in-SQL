/* Cleaning the data */

/* Adding a new column i.e., 'SaleDateConverted' from 'SaleDate' column to put it in only in Date format */

Select * from dbo.NashvilleHousing;

select SaleDate from dbo.NashvilleHousing;

select SaleDate, convert(Date,SaleDate)
from NashvilleHousing;

Alter table NashvilleHousing 
Add SaleDateConverted Date;

Update NashvilleHousing
Set SaleDateConverted = Convert(Date,SaleDate);

-- Populate Property Address Data
-- For Example: Check Parcel ID = 015 14 0 060.00, when two rows have same ParcelID,then the Property Address is same

Select * from dbo.NashvilleHousing order by ParcelID;

select PropertyAddress from NashvilleHousing
where PropertyAddress is Null;

select * from NashvilleHousing A join NashvilleHousing B
on A.ParcelID = B.ParcelID
AND A.[UniqueID ] <> B.[UniqueID ]
where a.PropertyAddress is NULL;

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL( a.PropertyAddress,b.PropertyAddress)
from NashvilleHousing A join NashvilleHousing B
on A.ParcelID = B.ParcelID
AND A.[UniqueID ] <> B.[UniqueID ]
where a.PropertyAddress is NULL;

Update A
SET PropertyAddress= ISNULL( a.PropertyAddress,b.PropertyAddress)
from NashvilleHousing A join NashvilleHousing B
on A.ParcelID = B.ParcelID
AND A.[UniqueID ] <> B.[UniqueID ]
where a.PropertyAddress is NULL;

/* Breaking the Property Address into Individual Columns (Address, City, State) */

Select PropertyAddress from dbo.NashvilleHousing;

use SQL_CleaningProject;

Select SUBSTRING( PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address,
SUBSTRING( PropertyAddress,CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) as City from dbo.NashvilleHousing;

Alter table dbo.NashvilleHousing 
Add PropertySplitAddress NVarchar(255);

Alter table dbo.NashvilleHousing 
Add PropertySplitCity NVarchar(255);

Update dbo.NashvilleHousing
SET PropertySplitAddress = SUBSTRING( PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1);


Update dbo.NashvilleHousing
SET PropertySplitCity = SUBSTRING( PropertyAddress,CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress));

Select * from dbo.NashvilleHousing;

/* Breaking the Owner Address into Individual Columns (Address, City, State) */

Select owneraddress from dbo.NashvilleHousing;

Select
PARSENAME(Replace(OwnerAddress,',','.'), 1),
PARSENAME(Replace(OwnerAddress,',','.'), 2),
PARSENAME(Replace(OwnerAddress,',','.'), 3)
from dbo.NashvilleHousing;

Select
PARSENAME(Replace(OwnerAddress,',','.'), 3),
PARSENAME(Replace(OwnerAddress,',','.'), 2),
PARSENAME(Replace(OwnerAddress,',','.'), 1)
from dbo.NashvilleHousing;

Alter table dbo.NashvilleHousing 
add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(Replace(OwnerAddress,',','.'), 3);

Alter table dbo.NashvilleHousing 
add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(Replace(OwnerAddress,',','.'), 2);

Alter table dbo.NashvilleHousing 
add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(Replace(OwnerAddress,',','.'), 1);

-- Change Y and N to Yes and No in 'Sold as Vacant' field

Select Distinct(SoldasVacant),Count(SoldasVacant) as Count1
from NashvilleHousing
group by SoldAsVacant
order by Count1;

Select SoldasVacant,
CASE when SoldAsVacant = 'Y' then 'Yes'
     when SoldAsVacant = 'N' then 'NO'
	 ELSE SoldAsVacant
	 END
from NashvilleHousing
order by SoldAsVacant;

Update dbo.NashvilleHousing
set SoldAsVacant = CASE when SoldAsVacant = 'Y' then 'Yes'
     when SoldAsVacant = 'N' then 'NO'
	 ELSE SoldAsVacant
	 END
from NashvilleHousing;



-- Remove Duplicates

Select * from dbo.NashvilleHousing;

With RowNumCTE AS(
Select *,
ROW_NUMBER() OVER (
Partition by ParcelID,
PropertyAddress, SalePrice, SaleDate, LegalReference
ORDER By UniqueID) row_num
from dbo.NashvilleHousing
-- order by ParcelID
)

Select * from RowNumCTE
where row_num > 1
order by PropertyAddress;

With RowNumCTE AS(
Select *,
ROW_NUMBER() OVER (
Partition by ParcelID,
PropertyAddress, SalePrice, SaleDate, LegalReference
ORDER By UniqueID) row_num
from dbo.NashvilleHousing
-- order by ParcelID
)

Delete from RowNumCTE
where row_num > 1;

-- Delete Unused Columns

Select * from dbo.NashvilleHousing; 

Alter table dbo.NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress;


Alter table dbo.NashvilleHousing
Drop Column SaleDate;















