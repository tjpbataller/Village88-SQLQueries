USE lead_gen_business;
SET sql_mode="";
-- 1. What query would you run to get all the sites that client=15 owns?
SELECT domain_name AS website, client_id
FROM sites
WHERE client_id = 15;
-- 2. What query would you run to get total count of domain created for June 2011?
SELECT DATE_FORMAT(created_datetime, "%M") AS month, count(*)
FROM sites
WHERE DATE_FORMAT(created_datetime, "%Y") = "2011"
GROUP BY month
HAVING month = "June";
-- 3. What query would you run to get the total revenue for the date November 19th 2012?
SELECT DATE(charged_datetime) AS date, sum(amount)
FROM billing
GROUP BY date
HAVING date="2012-11-19";
-- 4. What query would you run to get total revenue earned monthly each year for the client with an id of 1?
SELECT client_id, SUM(amount) AS total_revenue, DATE_FORMAT(charged_datetime, "%M") AS month, YEAR(charged_datetime) AS year
FROM billing
WHERE client_id = 1
GROUP BY DATE_FORMAT(charged_datetime, "%M %Y")
ORDER BY year, month;
-- 5. What query would you run to get total revenue of each client every month per year? Order it by client id.
SELECT CONCAT(first_name," ",last_name) AS client_name, sum(billing.amount) AS total_revenue, DATE_FORMAT(billing.charged_datetime,"%M") AS month_charged, DATE_FORMAT(billing.charged_datetime,"%Y") AS year_charged
FROM clients
INNER JOIN billing ON clients.client_id = billing.client_id
GROUP BY client_name, month_charged, year_charged
ORDER BY clients.client_id, billing.charged_datetime;
-- 6. What query would you run to get which sites generated leads between March 15, 2011 to April 15, 2011? Show how many leads for each site. 
SELECT sites.domain_name AS website, count(leads_id) AS number_of_lead
FROM leads
INNER JOIN sites ON leads.site_id = sites.site_id
WHERE DATE(leads.registered_datetime) BETWEEN "2011-03-15" AND "2011-04-15"
GROUP BY website
ORDER BY leads.site_id;
-- 7. What query would you run to show all the site owners, the site name(s), and the total number of leads generated from each site for all time?
SELECT CONCAT(clients.first_name," ",clients.last_name) AS client_name, domain_name, count(leads.leads_id) AS num_leads
FROM clients
INNER JOIN sites ON sites.client_id = clients.client_id
INNER JOIN leads ON leads.site_id = sites.site_id
GROUP BY sites.domain_name
ORDER BY clients.client_id, sites.domain_name;

-- 8. What query would you run to get a list of site owners who had leads, and the total of each for the whole 2012?
SELECT CONCAT(clients.first_name," ",clients.last_name) AS client_name, COUNT(leads.leads_id) AS number_of_leads
FROM clients
INNER JOIN sites ON sites.client_id = clients.client_id
INNER JOIN leads ON leads.site_id = sites.site_id
WHERE DATE_FORMAT(leads.registered_datetime,"%Y") = "2012"
GROUP BY clients.client_id
ORDER BY clients.client_id;
-- 9. What query would you run to get a list of site owners and the total # of leads we've generated for each owner per month for the first half of Year 2012?
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SELECT CONCAT(clients.first_name, " ", clients.last_name) AS client_name, count(leads.leads_id) AS num_leads, DATE_FORMAT(registered_datetime, "%M") AS month FROM leads
INNER JOIN sites ON leads.site_id = sites.site_id
INNER JOIN clients ON clients.client_id = sites.client_id
WHERE MONTH(registered_datetime) IN ("01","02","03","04","05","06") && YEAR(registered_datetime) = "2012"
GROUP BY sites.client_id, month
ORDER BY leads.registered_datetime, sites.client_id;
-- 10. Write a single query that retrieves all the site names that each client owns and its total count. Group the results so that each row shows a new client. (Tip: use GROUP_CONCAT)
SELECT CONCAT(clients.first_name," ",clients.last_name) AS client_name, count(sites.site_id) AS number_of_sites, GROUP_CONCAT(sites.domain_name) AS sites
FROM clients
LEFT JOIN sites ON sites.client_id = clients.client_id
GROUP BY client_name
ORDER BY clients.client_id, sites.site_id;