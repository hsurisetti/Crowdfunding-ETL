# Crowd Funding ETL

## Overview :
Independent Funding wants us to work on the new Data set that contains information about the backers who have pledged to the live projects . We would need to perform the ETL and data analysis on this new data set .

## Tools used:
 Python, Pandas,Jupyter notebooks, PostgreSQL

## Results :

### Extract Data : 
  With the knowledge of Python, Panda and ETL process, we are able to extract the raw backers data and create a new DataFrame for it.

### Transform and Clean Data :
 In additon to the knowledge of Python, Pandas , we are adding data cleaning strategies and transforming the data via formatting, splitting and converting the data types and restructuring to create a new DataFrame that can be loaded into PostgreSQl database as a csv file
 
### ERD :
A new table for Backers is created and added along with other tables

### SQL Analysis Results:
- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

#### Query :

```javascript
SELECT cf_id, backers_count 
from campaign 
where outcome='live'
order by backers_count desc
```
![img](https://github.com/hsurisetti/Crowdfunding-ETL/blob/main/ResultsandScreenshots/Query1_results.png)

- Using the "backers" table confirm the results in the first query.

#### Query :

```javascript
select distinct(b.cf_id), count(c.backers_count) as backerscount
from campaign as c
INNER JOIN backers as b
ON c.cf_id = b.cf_id
where c.outcome='live'
group by b.cf_id
order by backerscount desc
```
![img](https://github.com/hsurisetti/Crowdfunding-ETL/blob/main/ResultsandScreenshots/Query2_results.png)

- Create a table that has the first and last name, and email address of each contact and the amount left to reach the goal for all "live" projects in descending order. 

```javascript
select  c.first_name,c.last_name,c.email,(cg.goal - cg.pledged) as "Remaining Goal Amount" 
INTO email_contacts_remaining_goal_amount
from 
contacts c
LEFT JOIN 
campaign cg
ON c.contact_id = cg.contact_id
where cg.outcome='live'
order by "Remaining Goal Amount" desc
```
![img](https://github.com/hsurisetti/Crowdfunding-ETL/blob/main/ResultsandScreenshots/email_contacts_remaining_goal_amount.png)

- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
and has the first and last name of each backer, the cf_id, company name, description, end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

```javascript
select b.email, b.first_name, b.last_name, b.cf_id, 
		c.company_name, c.description, c.end_date,
		(c.goal - c.pledged) as "Left of Goal" 
INTO email_backers_remaining_goal_amount
from backers b
LEFT JOIN
campaign c
ON b.cf_id = c.cf_id
where c.outcome='live'
order by b.email desc
```
![img](https://github.com/hsurisetti/Crowdfunding-ETL/blob/main/ResultsandScreenshots/email_backers_remaining_goal_amount.png)
 
## Summary 
    
In Summary, based on our analysis and results , we can see that Independent Funding would have all the essential data and reports needed to send to it their contacts and backers.
