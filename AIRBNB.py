#!/usr/bin/env python
# coding: utf-8

# # AIRBNB DATA OVERVIEW (Last 12 Months)

# ### Lets import data

# In[2]:


import pandas as pd


# In[3]:


df = pd.read_csv('C:\\Users\\61403\\Desktop\\AirBnB\\listings.csv')


# ### Descriptive Analysis

# In[4]:


df.head()


# In[5]:


df.info()


# In[6]:


df.describe()


# In[7]:


# Count of missing values per column
missing_values = df.isnull().sum()
print(missing_values)


# ### We can see from the overlook of data, there are five columns with null. we wil need find out what to do with those data
# * neighbourhood_group 
# * price
# * last_review
# * reviews_per_month
# * license

# #### We will drop neighbourhood_group column because its all null

# In[8]:


df.drop('neighbourhood_group', axis=1, inplace=True)


# #### For last_review and reviews_per_month , these has to be new listings and they haven't received reviews yet. so we will replace "last_review" with "NAN" and "reviews_per_month" with "0"

# In[9]:


# Impute missing values for 'reviews_per_month' with 0
df['reviews_per_month'] = df['reviews_per_month'].fillna(0)

# Impute missing values for 'last_review' with 'No Reviews'
df['last_review'] = df['last_review'].fillna(pd.NaT)


# #### For license, the null part could be because of following reasons:
# * Listings not being registered: listings might not be registered or licensed yet.
# * Pending Licenses: New listings may have pending licenses, and the license information might not be available yet.
# * Data Collection Issues: The data might simply not have been collected for some listings.
# 
# We will fill these NA with Pending at the moment and will do our analytics in SQL later on
# 

# In[10]:


# Impute 'license' with 'Unknown' for missing values

df['license'] = df['license'].fillna('Pending')


# #### For Price column, we can see most of the listings have received good number of reviews. So, considering these listings are not new, the field being null could suggests that:
# * Hosts might have set a dynamic or custom pricing
# * High Demand, Temporarily Out of Sync: seasonal adjustments, special rates
# * The price data might have been missed during the data collection process or was not properly scraped from the platform.

# In[11]:


# Impute missing prices with the median price of the same room type
df['price'] = df.groupby('room_type')['price'].transform(lambda x: x.fillna(x.median()))


# In[12]:


df.info()


# ### Connecting to MYSQL Server

# Before inserting data, let's makesure first our all column name will have lower_case

# In[12]:


# Convert all column names to lowercase
df.columns = df.columns.str.lower()


# In[13]:


df.head()


# In[14]:


import sqlalchemy
import pymysql
from sqlalchemy import create_engine


# In[15]:


# Database connection string
engine = sqlalchemy.create_engine('mysql+pymysql://username:password@server_name/database_name')

conn = engine.connect()


# In[19]:


df.to_sql(
        name='airbnb_listings',  
        con=conn,                
        index=False,             
        if_exists='append'
    )


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




