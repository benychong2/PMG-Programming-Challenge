/* Question 1 */
SELECT date, SUM(impressions) AS total_impressions
FROM marketing_performance
GROUP BY date;

/* Question 2 */
SELECT TOP 3 state, SUM(revenue) AS total_revenue
FROM website_revenue
GROUP BY state
ORDER BY total_revenue desc;
/* The third best state (Ohio) generated $37577 in revenue */

/* Question 3 */
SELECT C.name, Metrics.total_cost, Metrics.total_impressions, Metrics.total_clicks, Metrics.total_revenue
FROM 
	(SELECT *
     FROM
     	(SELECT campaign_id, SUM(cost) as total_cost, SUM(impressions) as total_impressions, SUM(clicks) as total_clicks
         FROM marketing_performance
		 GROUP BY campaign_id) AS M
	INNER JOIN
     	(SELECT campaign_id as campaign_idT, sum(revenue) as total_revenue
         from website_revenue
		 GROUP BY campaign_id) AS T
	ON M.campaign_id = T.campaign_idT) AS Metrics
INNER JOIN campaign_info C
ON C.id = Metrics.campaign_id
order by C.name;

/* Question 4 */
SELECT C.name, M.geo, SUM(M.conversions) FROM marketing_performance M
INNER JOIN campaign_info C
ON M.campaign_id = C.id
WHERE C.name = 'Campaign5'
GROUP BY M.geo, C.name;
/* Georgia generated the most conversions in Campaign 5 with 672*/

/* Question 5 */
SELECT C.name, SUM(M.cost)/SUM(M.conversions) AS cost_per_conversion
FROM marketing_performance M
INNER JOIN campaign_info C
ON C.id = M.campaign_id
GROUP BY C.name
ORDER BY cost_per_conversion ASC;
/* Campaign 4 was the most efficient campaign because the cost per conversion was the lowest amongst all 5 campaigns */

/* Bonus Question 6 */
SELECT DATENAME(WEEKDAY, date) as day_of_week, AVG(cost)/AVG(conversions) AS avg_conversion_cost 
FROM marketing_performance
GROUP BY DATENAME(WEEKDAY, date)
ORDER BY avg_conversion_cost ASC;
/* Wednesday is the best day to run ads because the cost per conversion is the lowest on that specific day */


