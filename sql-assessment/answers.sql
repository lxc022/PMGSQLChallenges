-- Lawrence Cooper 
-- 1
SELECT SUM(impressions) as 'DAILY IMPRESSION TOTAL'
FROM marketing_data

--2
SELECT TOP 3 [State], Revenue
FROM website_revenue
ORDER BY Revenue DESC

--3
--Write a query that shows total cost, impressions, clicks, and revenue of each campaign. 
--Make sure to include the campaign name in the output.
SELECT name AS Name,
	SUM(Cost) AS [Total Cost], 
	SUM(Impressions) AS [Total Impressions],
	SUM(Clicks) AS [Total Clicks],
	SUM(Revenue) AS [Total Revenue]
FROM campaign_info AS c INNER JOIN marketing_data AS m 
		ON c.id = m.campaign_id
	INNER JOIN website_revenue AS w
		ON c.id = w.campaign_id
GROUP BY name

-- 4 
--Write a query to get the number of conversions of Campaign5 by state. 
--Which state generated the most conversions for this campaign?

SELECT SUM(conversions), State
FROM marketing_data AS m INNER JOIN website_revenue as W
	ON m.campaign_id = w.campaign_id
WHERE m.campaign_id = 5
GROUP BY State

--5



--6
SELECT DATENAME(weekday, date) AS Day, SUM(conversions)
FROM marketing_data
GROUP BY DATENAME(weekday, date)