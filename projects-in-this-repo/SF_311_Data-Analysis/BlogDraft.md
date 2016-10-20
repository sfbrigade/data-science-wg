#Funky Numbers

{Did 311 use citysdk for census figures?}

What happens when you cross civic hacking with data science? Open data does not interpret itself. While open source tools for data science are improving all the time, it's still beyond the skillset of many public agencies and nonprofits. The DSWG offers their expertise as a resource for any group looking to use data science for the public good.

The Data Science Working Group (DSWG) of Code for San Francisco has been experimenting with this concept this for 8 months. This blog is the first in a series exploring their projects.

SF is not exactly famous for it’s sparkling clean streets. The city’s 311 system receives well over 1,000 requests on a normal day. All those sidewalk cleaning, dumped trash, and graffiti requests generate a ton of data. That data offers insights into how the city handles these issues as well as potential areas for improvement.

San Francisco publishes all 311 case records in real-time on their data portal. Anyone can access this information and perform some basic analyses and visualizations in the portal. The DSWG had two main interests in exploring the 311 data set: equity concerns and operational issues. 


##Equity Concerns

Are there any disparities between how the city responds to requests from less advantaged parts of San Francisco? The DSWG conducted constructed several inquiries to explore this topic. Does the city take longer to respond to 311 requests from poorer residents? What is the distribution of requests among richer and poorer neighborhoods?

While the open 311 data set includes extensive detail on each request, it does not say anything about the income of a reporting party or their home address. The next best data set for examining relationships between 311 requests and income is the census tract level per capita information from the American Community Survey (2014, 5 year estimates). The ACS income data make it possible to test correlations in R down to the neighborhood level.

For example, the first equity concern examined was whether the time taken to resolve a request (caselength) predicts the request location’s median income. If long caselengths are correlated with low income request locations, that would suggest the city taking longer to respond in poorer neighborhoods. Loading the 311 data set sample & the ACS data into an R database made it possible to examine these issues with precision.

For the full methodology of this analysis, head over to the project's [github repo](https://github.com/sfbrigade/data-science-wg/tree/master/projects-in-this-repo/SF_311_Data-Analysis). This is the TL;DR version. If you ask R to fit a regression model to the income and caselength data, the output shows a p value of 0.705. This p value indicates there is a very high probability caselength is not relevant to income, and therefore can’t be used to predict income. The general p value threshold for using a correlation is .05 or less.

[insert r output of equity concern 1.]

lm(formula = pc_inc2014 ~ caselength, data = income)

Use y hat guide & link for reference.

{pc_inc2014 = per capita income per census tract from the ACS? “Data = income” was defined by Mattvm & how?}

Using the same technique, it is possible to confirm that the source of a request is also not correlated with income. The city responds to 311 requests in roughly the same amount of time to requests whether they are made by phone, email, twitter, open311, online, by an integrated agency, or by another agency. The lack of any trend line in the scatterplot below reflects both of these conclusions.

[insert income & caselength scatterplot]


(http://blog.yhat.com/posts/r-lm-summary.html)

*Neighborhood*
{what was the process or prompt in R that returns the “multiple r squared (i.e. variance explained): 0.74149”

*Category*

##Operational Concerns

Does the 311 data reveal ways that the city can handle 311 requests more efficiently? 

At the request of Transferred cases The DSWG has also put together an interactive exploratory tool using Microsoft Power BI making it very simple to explore the 311 data.



If income were correlated with case length, case length should be able to predict income. The linear regression model demonstrates case length can't be used to predict income. The probability of this correlation happening by chance was not less than .05.
