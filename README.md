# ds4eeb_FinalProject_Soil_Carbon
--> This is the GitHub data repository for my final ds4eeb project (2026).

Written by

Georgia Vasey<br>
Department of Environmental Studies<br>
University of California Santa Cruz<br>
Santa Cruz, CA USA

**The motivating question:** Does fire change soil carbon in coastal prairies? If yes, is this moderated by topography, soil properties, burn severity, or weather parameters?

**The rationale:**  As Earth continues to warm at unprecedented rates due to climate change, it is crucial that below-ground carbon pools are conserved and restored to offset global carbon emissions. Grasslands cover 40% of the Earth’s terrestrial surface and store an estimated 30% of the world’s soil carbon (He et al., 2024). They are considered one of the most resilient carbon pools, storing 24-80% of their carbon below-ground (Byrne, 2021). For degraded grasslands, restoration practices are predicted to capture up to 0.5 Pg C per year to a 1-m depth (Rivera & Chará, 2021), posing to be a feasible natural climate solution.

Practitioners have been restoring California coastal prairies, a grassland habitat, for decades using management techniques like grazing, mowing, and revegetation. One technique that has been largely absent is prescribed burning due to fire suppression policies. Recent policy changes have expanded prescribed fire in California to reduce fine ladder fuels that contribute to wildfires (Miller et al., 2020), however the effect of burning on carbon cycling varies (Bremer & Ham, 2010). Grassland burns are often low-intensity, allowing for the reincorporation of ash and burnt vegetative material to increase soil organic carbon (SOC) (Alcañiz et al., 2018). Burning is also known to increase aboveground and belowground growth, particularly stimulating fine root production that increases SOC (Neary & Leonard, 2020). However, moderate intensity burns (250–460°C) can cause opposite effects, where volatilization removes soil nutrients, emits greenhouse gases, and reduces SOC (Alcañiz et al., 2018). Additionally, the use of frequent fires can reduce SOC in the upper 5 cm of the soil surface (Xu et al., 2022). With a resurgence in fire management, it is critical to evaluate how burning affects soil carbon in coastal prairies. 

This study compared SOC in nine paired prescribed burn and unburned prairies in the Central Coast of California, specifically evaluating soil organic carbon in the top 5 cm, change in aboveground biomass (residual dry matter), and root biomass in the first growing season. For predictors, fuel metrics including change in litter (i.e., thatch) and burn severity (% cover in Black, Green, Unburned) were measured, additional soil samples measured pH and soil nutrients, DEM layers assessed topography, and weather data, such as long-term precipitation, burn-date weather, and antecedent moistured were retrieved from nearby weather stations. This repository includes data wrangling, exploratory plots, and explanatory models using transect-level response variables and predictors. 

**Target audience:** This repository is being prepared to eventually share with reviewers in a scientific journal for a future publication.

**Repository Structure:**<br>
data/<br>
   raw/              # Raw field and environmental datasets<br>
   processed/        # Cleaned datasets used for analysis (.rds files)<br>

figures/<br>
   exploratory/      # Automatically saved exploratory plots<br>

images/              # DAGs<br>

scripts/<br>
   data_wrangling.qmd        # Data cleaning and merging<br>
   exploratory_plots.qmd     # Exploratory visualizations<br>
   explantory_analysis.qmd              # Bayesian statistical models<br>

output/<br>
   models/           # Saved brms model objects**<br>

**How to Reproduce the Analysis:**
1. Run data_wrangling.qmd to create analysis datasets: merges vegetation, soil, climate, and burn datasets; creates the analysis dataset analysis_carbon
2. Run exploratory_plots.qmd for exploratory figures
3. Run explanatory_analysis.qmd to fit Bayesian models

**Software Information:**
R version 4.4.1 (2024-06-14 ucrt)
Platform: x86_64-w64-mingw32/x64
Running under: Windows 11 x64 (build 26200)

Matrix products: default

locale:
[1] LC_COLLATE=English_United States.utf8  LC_CTYPE=English_United States.utf8   
[3] LC_MONETARY=English_United States.utf8 LC_NUMERIC=C                          
[5] LC_TIME=English_United States.utf8    

time zone: America/Los_Angeles
tzcode source: internal

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] tidybayes_3.0.7    bayesplot_1.15.0   performance_0.16.0 GGally_2.3.0       ggeffects_2.3.0   
 [6] brms_2.23.0        Rcpp_1.0.13        corrplot_0.95      readxl_1.4.3       here_1.0.2        
[11] lubridate_1.9.4    forcats_1.0.0      stringr_1.5.1      dplyr_1.1.4        purrr_1.1.0       
[16] readr_2.1.5        tidyr_1.3.1        tibble_3.3.1       ggplot2_4.0.2      tidyverse_2.0.0   

loaded via a namespace (and not attached):
 [1] Rdpack_2.6.4          gridExtra_2.3         inline_0.3.21         sandwich_3.1-1       
 [5] rlang_1.1.4           magrittr_2.0.3        ggridges_0.5.7        matrixStats_1.5.0    
 [9] compiler_4.4.1        mgcv_1.9-1            loo_2.9.0             callr_3.7.6          
[13] vctrs_0.6.5           reshape2_1.4.4        arrayhelpers_1.1-0    pkgconfig_2.0.3      
[17] crayon_1.5.3          backports_1.5.0       labeling_0.4.3        utf8_1.2.6           
[21] tzdb_0.4.0            nloptr_2.1.1          haven_2.5.4           ps_1.9.1             
[25] bit_4.5.0.1           xfun_0.50             progress_1.2.3        parallel_4.4.1       
[29] prettyunits_1.2.0     R6_2.6.1              stringi_1.8.4         RColorBrewer_1.1-3   
[33] StanHeaders_2.32.10   boot_1.3-30           numDeriv_2016.8-1.1   cellranger_1.1.0     
[37] estimability_1.5.1    rstan_2.32.7          knitr_1.49            zoo_1.8-14           
[41] Matrix_1.7-1          splines_4.4.1         timechange_0.3.0      glmmTMB_1.1.12       
[45] tidyselect_1.2.1      rstudioapi_0.17.1     abind_1.4-8           TMB_1.9.17           
[49] codetools_0.2-20      processx_3.8.6        pkgbuild_1.4.8        lattice_0.22-6       
[53] plyr_1.8.9            withr_3.0.2           bridgesampling_1.2-1  bayestestR_0.17.0    
[57] S7_0.2.0              posterior_1.6.1       coda_0.19-4.1         evaluate_1.0.5       
[61] ggstats_0.10.0        RcppParallel_5.1.11-1 ggdist_3.3.3          pillar_1.11.1        
[65] tensorA_0.36.2.1      checkmate_2.3.4       stats4_4.4.1          reformulas_0.4.1     
[69] insight_1.4.6         distributional_0.6.0  generics_0.1.4        vroom_1.6.5          
[73] rprojroot_2.1.1       hms_1.1.3             rstantools_2.6.0      scales_1.4.0         
[77] minqa_1.2.8           xtable_1.8-4          glue_1.8.0            emmeans_1.11.2       
[81] tools_4.4.1           lme4_1.1-35.5         mvtnorm_1.3-3         grid_4.4.1           
[85] rbibutils_2.3         QuickJSR_1.9.0        datawizard_1.3.0      nlme_3.1-164         
[89] cli_3.6.5             svUnit_1.0.8          viridisLite_0.4.2     Brobdingnag_1.2-9    
[93] gtable_0.3.6          digest_0.6.37         farver_2.1.2          lifecycle_1.0.5      
[97] bit64_4.5.2           MASS_7.3-60.2

**References**:

**Alcañiz**, M., Outeiro, L., Francos, M., & Úbeda, X. (2018). Effects of prescribed fires on soil properties: A review. Science of The Total Environment, 613–614, 944–957. https://doi.org/10.1016/j.scitotenv.2017.09.144 

**Bremer**, D. J., & Ham, J. M. (2010). Net Carbon Fluxes Over Burned and Unburned Native Tallgrass Prairie. Rangeland Ecology & Management, 63(1), 72–81. https://doi.org/10.2111/REM-D-09-00010.1 

**Byrne**, K. M. (2021). Technical Note: A Rapid Method to Estimate Root Production in Grasslands, Shrublands, and Forests. Rangeland Ecology & Management, 76, 74–77. https://doi.org/10.1016/j.rama.2021.02.004 

**He**, T., Ding, W., Cheng, X., Cai, Y., Zhang, Y., Xia, H., Wang, X., Zhang, J., Zhang, K., & Zhang, Q. (2024). Meta-analysis shows the impacts of ecological restoration on greenhouse gas emissions. Nature Communications, 15(1), 2668. https://doi.org/10.1038/s41467-024-46991-5 

**Miller**, R. K., Field, C. B., & Mach, K. J. (2020). Barriers and enablers for prescribed burns for wildfire management in California. Nature Sustainability, 3(2), 101–109. https://doi.org/10.1038/s41893-019-0451-7 

**Neary**, D. G., & Leonard, J. M. (2020). Effects of Fire on Grassland Soils and Water: A Review. In Grasses and Grassland Aspects (p. 144). BoD – Books on Demand. 

**Rivera**, J. E., & Chará, J. (2021). CH4 and N2O Emissions From Cattle Excreta: A Review of Main Drivers and Mitigation Strategies in Grazing Systems. Frontiers in Sustainable Food Systems, 5. https://doi.org/10.3389/fsufs.2021.657936 

**Xu**, S., Eisenhauer, N., Pellegrini, A. F. A., Wang, J., Certini, G., Guerra, C. A., & Lai, D. Y. F. (2022). Fire frequency and type regulate the response of soil carbon cycling and storage to fire across soil depths and ecosystems: A meta-analysis. Science of The Total Environment, 825, 153921. https://doi.org/10.1016/j.scitotenv.2022.153921
