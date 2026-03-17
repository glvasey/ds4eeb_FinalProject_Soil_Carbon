This is the metadata for the raw data files.

10_5_Weather.xlsx
<br>
DEM_10m.xlsx

- Created polygons around each burn and control prairie in ArcGIS Pro
- Downloaded topography raster (DEM) from The National Map (3DEP) with 10m resolution (10 m x 10 m = 100 m2 on the ground): https://index.nationalmap.gov/arcgis/rest/services/3DEPElevationIndex/MapServer (includes elevation, slope, and aspect)
- Clipped raster to the prairie perimeters
- Used Zonal Statistics
  - OBJECTID: Assigned object number from ArcGIS
  - Site: One of the nine sites
  - Elevation (m), Slope (Deg from 0-90), and Aspect (Deg in Compass Direction from 0-360) depeding on the tab
<br>
Weather.xlsx

- Obtained local weather data
- RAWS for CSR (Pulgas California; 37.475, -122.298056), CF (Coast Dairies California; 37.030833,	-122.187778), AM (Big Sur California; 36.235556, -121.785)
- CIMIS for WR22, WR13, WR5, and MF (De Laveagea (104); 36.997444, -121.99676), PL (Pacific Grove (193); 36.63322, -121.93486), TKR (Pescadero (253); 37.255333, -122.3708)
- Used weather station data to get a measure of antecedent precipitation or perhaps time since last rain event as a proxy for pre-fire soil moisture conditions. 

| Name | Description | Units |
| --- | --- | --- |
| date | Date of burn | mm/yyyy |
| year | Year of burn | yyyy |
| Jul | Day of year | d |
| wind_speed | Mean wind speed | m/s |
| mean_temp | Average air temperature | Deg C (Celsius) |
| max_temp | Maximum temperature | Deg C (Celsius) |
| min_temp | Minimum temperature | Deg C (Celsius) |
| mean_humidity | Average relative humidity | % |
| max_humidity | Maximum humidity | % |
| min_humidity | Minimum humidity | % |
| precipitation | Total precipitation | millimeters (mm) |
| days_since_precip | Days since last rainfall event pre-burn (> 7mm) | d |
| antecedent_precip | Antecedent rainfall event (> 7mm) | millimeters (mm) |
<br>
bulk_density.csv

- The small cores were 4.9 cm diameter x 5.1 cm deep, thus:
  - V = π r2 h
  - V = π (2.46^2) (5.1) = 96.96 cm^3
- The larger cores from the first three burns were 5 cm diameter x 13 cm deep
  - V = π (2.5^2) (13) = 255.25 cm^3
- Originally, the soil volume was calculated incorrectly, so now the true bulk density in the 11th column (K) called "Correct bulk density"

| Name | Description | Units |
| --- | --- | --- |
| Date | Date | mm/dd/yyyy |
| Time | Time of sampling | 00:00:00 AM/PM |
| Site | Sampling site | Three letter code |
| Treatment | Prescribed burn or unburned | Burn/Control |
| Initial Weight (g) | Inititial weight before drying samples | grams (g) |
| Initial Weight + Tin (g) | Inititial weight before drying samples including weighing tin | grams (g) |
| Dried Weight + Tin (g) | After drying sample with tin weight | grams (g) |
| Dried Soil Weight (g) | (Initial + Tin) - (Dried + Tin) | grams (g) |
| Weight Change (g) | Inititial Weight - Dried Soil Weight | grams (g) |
| Bulk Density = Dry Weight/Soil Volume | Inititial bulk density calculation (wrong volume) | g/cm3 |
| Correct bulk density | Dried Soil Weight / 96.96 (5 cm samples) and 255.25 (15 cm samples) | g/cm3 |
| % weight = water | Weight Change (g) / Inititial Weight (g) | % |
<br>

