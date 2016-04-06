calls = read.csv('Case_Data_from_San_Francisco_311__SF311_.csv')
abandonedVehiclesCalls = calls[calls$Category == 'Abandoned Vehicle', ]
abandonedVehiclesCalls$Opened.POSIXlt = as.POSIXlt(strptime(abandonedVehiclesCalls$Opened, format = "%m/%d/%Y %I:%M:%S %p"), tz = "America/Los_Angeles")
abandonedVehiclesCalls$mon = abandonedVehiclesCalls$Opened.POSIXlt$mon
abandonedVehiclesCalls$year = abandonedVehiclesCalls$Opened.POSIXlt$year
callsYearMonth = aggregate(Opened ~ mon + year, abandonedVehiclesCalls, length)
callsYearMonth.ts = ts(callsYearMonth$Opened, frequency = 12, start = c(2008,7))
library(forecast)
seasonplot(callsYearMonth.ts, year.labels = TRUE, main="Abandoned Vehicles", col = rainbow(8))
