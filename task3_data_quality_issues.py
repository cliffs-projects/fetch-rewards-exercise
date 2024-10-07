# import libraries
import pandas as pd
import numpy as np
import json


# ------------------------------
# Section 0: Data Preprocessing
# ------------------------------

# Read in data 
brands = []
receipts = [] 
users = []

# brands.json
with open("./data/brands.json", 'r') as f1:
    for line in f1:
        brands.append(json.loads(line))

# receipts.json
with open("./data/receipts.json", 'r') as f2:
    for line in f2:
        receipts.append(json.loads(line))

# users.json
with open("./data/users.json", 'r') as f3:
    for line in f3:
        users.append(json.loads(line))
                      
# convert each json into a dataframe for easier data manipulation
df_brands = pd.DataFrame(brands)
df_receipts = pd.DataFrame(receipts)
df_users = pd.DataFrame(users)


"""
Assumptions: 
- values with dummy data (test brand) or difficult to interpret (date = 1609963174996) 
will not be counted as poor data quality
"""

# --------------------------------------
# Section 1: Check Brands dataset
# --------------------------------------

# Step 0: Overall Check (Eye test)
# print head for general check
print(df_brands.head())
print('\n-----------------------------------\n')

# print datatype for each column
for col in df_brands.columns:
    print(f"{col}: {type(df_brands[col][0])}")
print('\n-----------------------------------\n')

# print shape of dataset
print(f"Overall Shape: {df_brands.shape}")
print('\n-----------------------------------\n')


# Step 1: Check Accuracy between corresponding fields
# check unique values of category - should correspond heavily with categorycode
print(sorted(df_brands['category'].dropna().unique()))

# check unique values of categorycode
print(sorted(df_brands['categoryCode'].dropna().unique()))

# check unique values of brand names
print(sorted(df_brands['name'].dropna().unique()))

# check unique values of brand
print(sorted(df_brands['brandCode'].dropna().unique()))

# Finding: some categories do not have corresponding category code, same with name and brandcode


# Step 2: Check completeness: missing values/NA values 
print(df_brands.isna().sum())

# Finding: approximately half the columns are missing categoryCode, whether TopBrand


# Step 3: Check duplicate values
check_dup = df_brands[['barcode', 'category', 'name']]
print(check_dup.groupby(check_dup.columns.tolist(),as_index=False).size())

# Finding: items in brands are mostly unique


# Step 4: Outliers / Anomolies
# check range of brand barcodes
out = df_brands["barcode"].astype(float)
print(f"Range of barcodes: {out.min()} - {out.max()}")

# Finding: different data types in columns - brandCode, inconsistent fields - first entry has no brandCode

# --------------------------------
# Section 2: Check Users dataset
# --------------------------------

# Step 0: Overall Check (Eye test)
# check preview of dataset
print(df_users.head())
print('\n-----------------------------------\n')

# check datatypes of each column
for col in df_users.columns:
    print(f"{col}: {type(df_users[col][0])}")
print('\n-----------------------------------\n')

# check overall shape of data
print(f"Overall Shape: {df_users.shape}")
print('\n-----------------------------------\n')


# Step 1: Check Accuracy of strings
# check unique values of 'active' field
print(sorted(df_users['active'].dropna().unique()))

# check unique values of 'role' field
print(sorted(df_users['role'].dropna().unique()))

# check unique values of 'signUpSource' field
print(sorted(df_users['signUpSource'].dropna().unique()))

# check unique values of 'state' field
print(sorted(df_users['state'].dropna().unique()))


# Step 2: Check completeness: missing values/NA values 
# print(df_users.isna().sum())
nan_rows = df_users[df_users.isna().any(axis=1)]
print(nan_rows)

# Finding: active flag should be reviewed, some without lastLogin have True

# Step 3: Check duplicate values
check_dup = df_users[['active', 'role', 'signUpSource', 'state']]
print(check_dup.groupby(check_dup.columns.tolist(),as_index=False).size())

# Finding: Heavily imbalanced dataset with emphasis on tuple (True, consumer, email, WI)


# -------------------------------
# Section 3: Check Receipts Dataset
# -------------------------------

# # Step 0: Overall Check (Eye test)
# check preview of dataset
print(df_receipts.head())
print('\n-----------------------------------\n')

# check datatype of each column
for col in df_receipts.columns:
    print(f"{col}: {type(df_receipts[col][0])}")
print('\n-----------------------------------\n')

# check overall shape of dataset
print(f"Overall Shape: {df_receipts.shape}")
print('\n-----------------------------------\n')


# Step 1: Check Accuracy: Do Values make sense?
pt_check = df_receipts['pointsEarned'].dropna().astype(float)
print(f"Range of pointsEarned: {pt_check.min()} - {pt_check.max()}")

bonus_pt_check = df_receipts['bonusPointsEarned'].dropna().astype(float)
print(f"Range of bonusPointsEarned: {bonus_pt_check.min()} - {bonus_pt_check.max()}")

item_count_check = df_receipts['purchasedItemCount'].dropna().astype(float)
print(f"Range of purchasedItemCount: {item_count_check.min()} - {item_count_check.max()}")

total_spent_check = df_receipts['totalSpent'].dropna().astype(float)
print(f"Range of purchasedItemCount: {total_spent_check.min()} - {total_spent_check.max()}")

# Deeper dive into purchase of 689 items:
max_val = df_receipts['purchasedItemCount'].max()
print(df_receipts[df_receipts['purchasedItemCount'] == max_val])
print(df_receipts.iloc[543, :]["rewardsReceiptItemList"])

# Finding: Double check validity of receipt: 600f2fc80a720f0535000030, 689 items purchased


# Step 2: Check completeness: missing values/NA values 
print(df_receipts.isna().sum())
nan_rows = df_receipts[df_receipts.isna().any(axis=1)]
print(nan_rows)

# Finding: high level of NA's in receipts: 50% for several columns: purchaseDate, totalSpent, pointsEarned, rewardsReceiptItemList

