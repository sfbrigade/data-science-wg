![](../gis-parking-fix_header.png)
## Curb Assignment 

This is an R script to assign CNNs to curb segments in parallel, using R.

#### Requirements

The package requires the installation of several R packages: 

```
rgeos
dplyr
sp
geosphere
rgdal
doParallel
```

#### Usage

The script `CurbAssignment.R` will generate an `sp` object of type `SpatialLinesDataFrame` that can be converted  into a variety of formats (shapefile, geoJSON, etc.). The data frame represents a shapefile of curb segments with a property that labels them with the closest CNN. 

**Warning:** This script takes a while to run, as it is fairly computationally-intensive. This is why the process is done in parallel. 

The data that the script uses is downloaded from the SF Open Data website if it does not exist in the current directory, so the script is self-contained. 