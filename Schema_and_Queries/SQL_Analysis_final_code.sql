-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

SELECT cf_id, backers_count 
from campaign 
where outcome='live'
order by backers_count desc


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
select distinct(b.cf_id), count(c.backers_count) as backerscount
from campaign as c
INNER JOIN backers as b
ON c.cf_id = b.cf_id
where c.outcome='live'
group by b.cf_id
order by backerscount desc


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

select  c.first_name,c.last_name,c.email,(cg.goal - cg.pledged) as "Remaining Goal Amount" 
INTO email_contacts_remaining_goal_amount
from 
contacts c
LEFT JOIN 
campaign cg
ON c.contact_id = cg.contact_id
where cg.outcome='live'
order by "Remaining Goal Amount" desc

-- Check the table

select * from email_contacts_remaining_goal_amount

-- 4. (5 pts) -- Please note that output is different from the expected output in
-- https://courses.bootcampspot.com/courses/2457/assignments/42120?module_item_id=791779
-- Getting this output since we are ordering by email adddress descending which is done as per instructions
-- Added another query in the end 4b to match the expect output ehich orders differntly

-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

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



-- Check the table

select * from email_backers_remaining_goal_amount

-- Export it as csv file
-- Exported email_backers_remaining_goal_amount.csv file to Crowdfunding-ETL folder


-- 4b. (5 pts) -- Doing this way as well , since the output in the requirement is expecting this format
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
--order by last_name and email address

select b.email, b.first_name, b.last_name, b.cf_id, 
		c.company_name, c.description, c.end_date,
		(c.goal - c.pledged) as "Left of Goal" 
INTO email_backers_remaining_goal_amount_b
from backers b
LEFT JOIN
campaign c
ON b.cf_id = c.cf_id
where c.outcome='live'
order by last_name,email



-- Check the table

select * from email_backers_remaining_goal_amount_b


-- Export it as csv file
-- Exported email_backers_remaining_goal_amount_b.csv file to Crowdfunding-ETL folder



