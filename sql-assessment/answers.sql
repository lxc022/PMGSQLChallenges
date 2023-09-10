-- Lawrence Cooper, 2024 PMG Graduate Leadership Program
-- SQL Answers

--	1) Write a query to get the sum of impressions by day.

		SELECT date as 'Date', COUNT(date) as '# of Ads Running', SUM(impressions) as 'Total Impressions'
		FROM marketing_performance
		GROUP BY date

--	2) Write a query to A) get the top three revenue-generating states,  B) in order of best to worst. 
--		How much revenue did the third best state generate? 
		--ANSWER: OHIO RANKED 3RD WITH $37577 IN REVENUE

		SELECT TOP (3) State, SUM(Revenue) as [Total Revenue]
		FROM website_revenue
		GROUP BY State
		ORDER BY SUM(Revenue) desc
	
--	3) Write a query that shows total cost, impressions, clicks, and revenue of each campaign. 
--		Make sure to include the campaign name in the output.
	
		SELECT name AS CampaignName,
			SUM(Cost) AS [Total Cost], 
			SUM(Impressions) AS [Total Impressions],
			SUM(Clicks) AS [Total Clicks],
			SUM(Revenue) AS [Total Revenue]
		FROM campaign_info AS c 
			INNER JOIN marketing_performance AS m 
				ON c.id = m.campaign_id
			INNER JOIN website_revenue AS w
				ON c.id = w.campaign_id
		GROUP BY name

--	4) Write a query to get the number of conversions of Campaign5 by state. 
--		Which state generated the most conversions for this campaign?
			--ANSWER: GEORGIA HAD MOST WITH 3342 CONVERSIONS
		SELECT SUM(conversions)as [Total Conversions], State, name as [CampaignName]
		FROM marketing_performance AS m 
			INNER JOIN website_revenue as w
			ON m.campaign_id = w.campaign_id
			INNER JOIN campaign_info as c
			ON w.campaign_id = c.id
		WHERE c.id = 99058240
		GROUP BY State, name
			
	-- OR THIS CODE BELOW WITH SLIGHT CHANGE IN WHERE CLAUSE
		SELECT SUM(conversions)as [Total Conversions], State, name as [CampaignName]
		FROM marketing_performance AS m 
		INNER JOIN website_revenue as w
			ON m.campaign_id = w.campaign_id
		INNER JOIN campaign_info as c
			ON w.campaign_id = c.id	
		WHERE c.name = 'Campaign5'
		GROUP BY State, name
		ORDER BY SUM(conversions) desc

--	5) In your opinion, which campaign was the most efficient, and why?
	-- ANSWER: CAMPAIGN 4 BASED ON THE CODING BELOW

		SELECT name AS CampaignName,
			SUM(Cost) AS [Total Cost], 
			SUM(Impressions) AS [Total Impressions],
			SUM(Clicks) AS [Total Clicks],
			SUM(Revenue) AS [Total Revenue],
			SUM(Revenue) / SUM(Cost) as [Rev/Cost]
		FROM campaign_info AS c 
			INNER JOIN marketing_performance AS m 
				ON c.id = m.campaign_id
			INNER JOIN website_revenue AS w
				ON c.id = w.campaign_id
		GROUP BY name
		ORDER BY SUM(Revenue) / SUM(Cost) desc


--Bonus Question
--	6) Write a query that showcases the best day of the week to run ads.
	 --		(e.g., Sunday, Monday, Tuesday, etc.)
		SELECT DATENAME(weekday, date) AS [Day of Week], 
				SUM(conversions) as [Total Conversions],
				SUM(clicks) as [Total Clicks],
				SUM(impressions) as [Total Impressions]
		FROM marketing_performance
		GROUP BY DATENAME(weekday, date)
		ORDER BY SUM(conversions) desc
