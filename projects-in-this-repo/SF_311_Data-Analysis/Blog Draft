#Funky Numbers

What happens when you cross civic hacking with data science? The Data Science Working Group (DSWG) of Code for San Francisco has been experimenting with this concept this for 8 months. This blog is the first in a series exploring their projects.

SF is not exactly famous for it’s sparkling clean streets. The city’s 311 system receives well over 1,000 requests on a normal day. All those sidewalk cleaning, dumped trash, and graffiti requests generate a ton of data. That data can tell us some interesting things about how San Francisco works.

*“What gets measured gets managed.”* - Peter Drucker

San Francisco publishes all 311 case records in real-time on their data portal. Anyone can access this information and perform some basic analyses and visualizations in the portal. The DSWG is interested in using analytical techniques to uncover data insights that are well beyond the tools on the data portal and sometimes the abilities of the city itself.

The DSWG had two main interests in exploring the 311 data set: equity concerns and operational issues. 

##Equity Concerns

Does the city take longer to respond to 311 requests in poorer neighborhoods? What is the distribution of requests among richer and poorer neighborhoods?

While the open 311 data set describes each request in detail, answering the DSWG’s equity concerns required a creative approach. The data published by 311 records the location of a reported issue, not the home address or income of a reporting party. The DSWG used inferential techniques to compare 311 requests against census tract level income data from the American Community Survey.

[explain Equity Concern 1 formula]
Use y hat guide & link for reference.

The DSWG used R to fit a linear regression model to the income and case response time data. 

lm(formula = pc_inc2014 ~ caselength, data = income)

[pc_inc2014 = per capita income per census tract from the ACS? “Data = income” was defined by Mattvm & how?]

##Operational Issues

Does the 311 data reveal ways that the city can handle 311 requests more efficiently?



If income were correlated with case length, case length should be able to predict income. The linear regression model demonstrates case length can't be used to predict income. The probability of this correlation happening by chance was not less than .05.
