# Exploratory plots 
# Uses: analysis_carbon (transect-level master table)
# Responses: final_C_Mg_per_ha, Roots_g_per_m2, final_RDM

# Load the libraries
library(dplyr)
library(ggplot2)
library(stringr)

# Develop a small helper (mean ± SE) for each plot
# ----------------------------
mean_se_df <- function(x) {
  n <- sum(!is.na(x))  # Raw data (total occurrences)
  m <- mean(x, na.rm = TRUE) # Mean of the raw data
  se <- sd(x, na.rm = TRUE) / sqrt(n) # Function to compute standard error
  # Create a data frame with mean and error bars
  data.frame(y = m, ymin = m - se, ymax = m + se, n = n) 
}

# Can also enforce Treatment order
#analysis_carbon <- analysis_carbon %>%
#mutate(Treatment = factor(Treatment, levels = c("Control", "Burn")))

# Choose a consistent Site order
# This order could go from north to south (CSR, TKR, CF, WR22, WR13, WR5, MF, PL, AM)
# This order could also go wettest to driest?
#site_order <- sort(unique(analysis_carbon$Site))
#analysis_carbon <- analysis_carbon %>%
#mutate(Site = factor(Site, levels = site_order))

# Soil C change vs Treatment (overall)
p_soilC_treat <- ggplot(
  analysis_carbon %>% filter(!is.na(final_C_Mg_per_ha)),
  # Should swap out treatment since I don't compare treatments
  aes(x = Treatment, y = final_C_Mg_per_ha)
) +
  geom_jitter(width = 0.12, alpha = 0.6) +
  stat_summary(fun.data = mean_se_df, geom = "errorbar", width = 0.2) +
  stat_summary(fun = mean, geom = "point", size = 3) +
  labs(x = NULL, y = expression("Change in soil C("*Mg~ha^{-1}*")"))
theme_classic(base_size = 14)
p_soilC_treat

# ----------------------------
# 2) Roots vs Treatment (2024 subset if Year exists; otherwise just non-missing)
# ----------------------------
p_roots_treat <- ggplot(
  analysis_carbon %>% filter(!is.na(Roots_g_per_m2)),
  aes(x = Treatment, y = Roots_g_per_m2)
) +
  geom_jitter(width = 0.12, alpha = 0.6) +
  stat_summary(fun.data = mean_se_df, geom = "errorbar", width = 0.2) +
  stat_summary(fun = mean, geom = "point", size = 3) +
  labs(x = NULL, y = expression("Roots ("*g~m^{-2}*")")) +
  theme_classic(base_size = 14)

# ----------------------------
# 3) RDM change vs Treatment
# ----------------------------
p_rdm_treat <- ggplot(
  analysis_carbon %>% filter(!is.na(final_RDM)),
  aes(x = Treatment, y = final_RDM)
) +
  geom_jitter(width = 0.12, alpha = 0.6) +
  stat_summary(fun.data = mean_se_df, geom = "errorbar", width = 0.2) +
  stat_summary(fun = mean, geom = "point", size = 3) +
  labs(x = NULL, y = "Change in RDM (g)") +
  theme_classic(base_size = 14)

# ----------------------------
# 4) Treatment effects by Site (small multiples)
#    Great for seeing heterogeneity across sites
# ----------------------------
p_soilC_site <- ggplot(
  analysis_carbon %>% filter(!is.na(final_Carbon_pct)),
  aes(x = Treatment, y = final_Carbon_pct)
) +
  geom_jitter(width = 0.12, alpha = 0.6) +
  stat_summary(fun.data = mean_se_df, geom = "errorbar", width = 0.2) +
  stat_summary(fun = mean, geom = "point", size = 2.5) +
  facet_wrap(~ Site, scales = "free_y") +
  labs(x = NULL, y = "Percent change in soil C") +
  theme_classic(base_size = 12)

p_roots_site <- ggplot(
  analysis_carbon %>% filter(!is.na(Roots_g_per_m2)),
  aes(x = Treatment, y = Roots_g_per_m2)
) +
  geom_jitter(width = 0.12, alpha = 0.6) +
  stat_summary(fun.data = mean_se_df, geom = "errorbar", width = 0.2) +
  stat_summary(fun = mean, geom = "point", size = 2.5) +
  facet_wrap(~ Site, scales = "free_y") +
  labs(x = NULL, y = expression("Roots ("*g~m^{-2}*")")) +
  theme_classic(base_size = 12)

p_rdm_site <- ggplot(
  analysis_carbon %>% filter(!is.na(final_RDM)),
  aes(x = Treatment, y = final_RDM)
) +
  geom_jitter(width = 0.12, alpha = 0.6) +
  stat_summary(fun.data = mean_se_df, geom = "errorbar", width = 0.2) +
  stat_summary(fun = mean, geom = "point", size = 2.5) +
  facet_wrap(~ Site, scales = "free_y") +
  labs(x = NULL, y = "Change in RDM (g)") +
  theme_classic(base_size = 12)

# ----------------------------
# 5) Burn-only: Responses vs CBI

# When only evaluating the burn transects
burn_only <- analysis_carbon %>%
  filter(Treatment == "Burn")

# Change in soil C with CBI (Burn Transects Only)
p_soilC_cbi <- ggplot(
  burn_only %>% filter(!is.na(final_Carbon_pct), !is.na(CBI)),
  aes(x = CBI, y = final_Carbon_pct)
) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(x = "Composite Burn Index (CBI)", y = "Percent change in soil C") +
  theme_classic(base_size = 14)

# Change in RDM (this one instead of being filtered by burn-only, should be Year == 2024)
p_rdm_cbi <- ggplot(
  burn_only %>% filter(!is.na(final_RDM), !is.na(CBI)),
  aes(x = CBI, y = final_RDM)
) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(x = "Composite Burn Index (CBI)", y = "Change in RDM (g)") +
  theme_classic(base_size = 14)

# Responses vs precipitation (site-level predictor)
#  Can change `precipitation_5y` to any precipitation predictor variable 
# e.g., precipitation (day of burn), 5d_precipitation (average precipitation during the week of the burn), 5y_precipitation (average monthly precipitation over 5 years); days_since_precip (number of days since previous rainfall event prior to burn)

precip_var <- "precipitation_5y"  # <-- can change this variable

p_soilC_precip <- ggplot(
  # Filter all occureneces for final change in %C and precipitation (exclude NA)
  analysis_carbon %>% filter(!is.na(final_Carbon_pct), !is.na(.data[[precip_var]])),
  # x = data from precipitation variable ; y = change in % C ; shape = Treatment (make different shapes for burn vs. Control)
  aes(x = .data[[precip_var]], y = final_Carbon_pct, shape = Treatment)
) +
  # Add raw data
  geom_point(alpha = 0.75) +
  # Add a line (linear regression)
  geom_smooth(method = "lm", se = TRUE) +
  # Label with x-axis (precip_var) ; y = change in soil C (%)
  labs(x = precip_var, y = "Percent Change in soil C", shape = NULL) +
  theme_classic(base_size = 14)
p_soilC_precip

# If I want separate regressions for Burn vs. Control
aes(x = .data[[precip_var]],
    y = final_Carbon_pct,
    shape = Treatment,
    color = Treatment)



p_roots_precip <- ggplot(
  analysis_carbon %>% filter(!is.na(Roots_g_per_m2), !is.na(.data[[precip_var]])),
  aes(x = .data[[precip_var]], y = Roots_g_per_m2, shape = Treatment)
) +
  geom_point(alpha = 0.75) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(x = precip_var, y = expression("Roots ("*g~m^{-2}*")"), shape = NULL) +
  theme_classic(base_size = 14)

p_rdm_precip <- ggplot(
  analysis_carbon %>% filter(!is.na(final_RDM), !is.na(.data[[precip_var]])),
  aes(x = .data[[precip_var]], y = final_RDM, shape = Treatment)
) +
  geom_point(alpha = 0.75) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(x = precip_var, y = "Change in RDM (g)", shape = NULL) +
  theme_classic(base_size = 14)

# ----------------------------
# 7) Responses vs soil texture (sand/clay/silt)
# ----------------------------
p_soilC_sand <- ggplot(
  analysis_carbon %>% filter(!is.na(final_Carbon_pct), !is.na(sand)),
  aes(x = sand, y = final_Carbon_pct, shape = Treatment)
) +
  geom_point(alpha = 0.75) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(x = "% Sand", y = "Percent change in soil C", shape = NULL) +
  theme_classic(base_size = 14)

p_soilC_clay <- ggplot(
  analysis_carbon %>% filter(!is.na(final_Carbon_pct), !is.na(clay)),
  aes(x = clay, y = final_Carbon_pct, shape = Treatment)
) +
  geom_point(alpha = 0.75) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(x = "% Clay", y = "Percent change in soil C", shape = NULL) +
  theme_classic(base_size = 14)

p_soilC_silt <- ggplot(
  analysis_carbon %>% filter(!is.na(final_Carbon_pct), !is.na(silt)),
  aes(x = silt, y = final_Carbon_pct, shape = Treatment)
) +
  geom_point(alpha = 0.75) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(x = "% Silt", y = "Percent change in soil C", shape = NULL) +
  theme_classic(base_size = 14)

# Optional: Roots vs texture (often noisy but useful)
p_roots_sand <- ggplot(
  analysis_carbon %>% filter(!is.na(Roots_g_per_m2), !is.na(sand)),
  aes(x = sand, y = Roots_g_per_m2, shape = Treatment)
) +
  geom_point(alpha = 0.75) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(x = "% Sand", y = expression("Roots ("*g~m^{-2}*")"), shape = NULL) +
  theme_classic(base_size = 14)

# ----------------------------
# 8) Print plots (choose what you want)
# ----------------------------
p_soilC_treat
p_roots_treat
p_rdm_treat

p_soilC_site
p_roots_site
p_rdm_site

p_soilC_cbi
p_roots_cbi
p_rdm_cbi

p_soilC_precip
p_roots_precip
p_rdm_precip

p_soilC_sand
p_soilC_clay
p_soilC_silt
p_roots_sand

# ----------------------------
# 9) Optional: save high-res versions
# ----------------------------
# ggsave("Fig_SoilC_Treatment.png", p_soilC_treat, width = 6, height = 4, dpi = 600)
# ggsave("Fig_Roots_Treatment.png", p_roots_treat, width = 6, height = 4, dpi = 600)
# ggsave("Fig_RDM_Treatment.png", p_rdm_treat, width = 6, height = 4, dpi = 600)


#############################################

### Heat Map of All Predictors ###
# This is not very helpful! Need to consider all of my predictors and make DAGs

# Load libraries
library(dplyr)
library(corrplot)

# Your predictor names (copy/paste your list, but exclude response vars)
pred_vars_full <- c(
  "wind_speed",
  "mean_temp","max_temp","min_temp",
  "mean_humidity","max_humidity","min_humidity",
  "precipitation","days_since_precip","antec_precip",
  "5d_mean_temp","5d_max_temp","5d_min_temp",
  "5d_mean_humidity","5d_max_humidity","5d_min_humidity","5d_precipitation",
  "5y_mean_temp","5y_max_temp","5y_min_temp",
  "5y_mean_humidity","5y_max_humidity","5y_min_humidity","5y_precipitation",
  "elevation","slope","aspect",
  "Total Exchange Capacity (meq/100 g)","pH","Organic Matter (%)",
  "Estimated Nitrogen Release (# N/acre)",
  "S* (ppm)","P* (mg/kg)","Bray II P (mg/kg)",
  "Ca* (mg/kg)","Mg* (mg/kg)","K* (mg/kg)","Na* (mg/kg)",
  "Ca** (%)","Mg** (%)","K** (%)","Na** (%)","Other Bases** (%)","H** (%)",
  "B* (mg/kg)","Fe* (mg/kg)","Mn* (mg/kg)","Cu* (mg/kg)","Zn* (mg/kg)","Al* (mg/kg)",
  "NO3-N (ppm)","NH4-N (ppm)",
  "sand","clay","silt",
  "CBI","Litter_Score","RDM_Score","Severity_Score"
  # NOTE: exclude CBI_Category (categorical), and exclude response vars
)

pred_df <- analysis_carbon %>%
  # column names have spaces and symbols; this avoids backtick issues
  select(any_of(pred_vars_full)) %>%
  # drops non-numeric automatically
  select(where(is.numeric)) %>%
  # or keep NA and use pairwise later
  drop_na()  

# See all correlations
cor_preds <- cor(pred_df, use = "pairwise.complete.obs")
corrplot(cor_preds, type = "upper", method = "circle")

# Highlight only strong correlations
corrplot(cor_preds, type = "upper", method = "circle", tl.cex = 0.6)
## Can't really read the plot, but of all the variables, it seems like weather variables are the most correlated

### Response ~ Predictor Plots ###
# This will facet wrap one response variable against the list of predictors of interest

# Load libraries
library(tidyr)
library(scales) #helps rescale in ggplot

# Make predictor list from colnames(analysis_carbon) to input into correlation table
# Malin suggests to not do more than 12 of the best ones
# Need to create DAGS to draw out speculated relationships, so that spurious relationships are not found

# Currently, the predictor variables are in wide format
predictor_vars <- c(
  "CBI",
  "precipitation_5y", "precipitation_burn_day", "precip_5d", "Days_Since_Precip",
  "sand", "silt", "clay",
  "Mean_Temp_5y"      # example
)
# Anticipated predictor blocks
# Block 1: WeatherBurn = wind_speed, mean_temp, max_temp, min_temp, mean_humidity, max_humidity, min_humidity, precipitation
# Block 2: MoistureAnte = days_since_precip, antec_precip
# Block 3: Climate5y = 5y_precipitation, 5y_mean_temp
# Block 4: Topo = elevation, slope, aspect
# Block 5: SoilChem = CEC, OM, pH, P_Bray or P_Mehlich, NO3, NH4


# Need to make a long dataframe of predictors to complete facet wrap
pred_long <- analysis_carbon %>%
  pivot_longer(
    cols = all_of(precip_vars),
    # This is the predictor variable name within the analysis_carbon table
    names_to = "predictor_name",
    # This is the value for that predictor variable
    values_to = "predictor_value"
  )

#

# Now, I can facet wrap using "predictor_name" which is all of the predictors in that group
# facet_wrap(~ predictor_name)
# facet_wrap(~ predictor_name, scales = "free_x", ncol = 3) will keep the    panels readable

## Soil C is Burn Only (Compare with Predictors)
# Need to eventually swap out pred_long with the other Blocks
p_soilC_allprecip <- pred_long %>%
  # Filter for Treatment = Burn 
  filter(Treatment == "Burn",
         # Response variable (change in soil C) - don't include NA
         !is.na(final_Carbon_pct),
         # Predictor variable (Block of predictors) - don't include NA
         !is.na(predictor_value)) %>%
  # Plot response ~ all predictors
  ggplot(aes(x = predictor_value, y = final_Carbon_pct)) +
  # Add points
  geom_point(alpha = 0.75) +
  # Add regression line
  geom_smooth(method = "lm", se = TRUE) +
  # Facet wrap and scale with free_x (predictors might have diff units)
  facet_wrap(~ predictor_name, scales = "free_x") +
  # Label y-axis with response variable
  labs(x = NULL, y = "Percent change in soil C") +
  theme_classic(base_size = 12)

# Root Biomass
p_roots_allprecip <- pred_long %>%
  # Filter for Year = 2024
  filter(Treatment == "Burn",
         # Response variable (change in soil C) - don't include NA
         !is.na(Roots_g_per_m2),
         # Predictor variable (Block of predictors) - don't include NA
         !is.na(predictor_value)) %>%
  # Plot response ~ all predictors
  ggplot(aes(x = predictor_value, y = Roots_g_per_m2)) +
  # Add points
  geom_point(alpha = 0.75) +
  # Add regression line
  geom_smooth(method = "lm", se = TRUE) +
  # Facet wrap and scale with free_x (predictors might have diff units)
  facet_wrap(~ predictor_name, scales = "free_x") +
  # Label y-axis with response variable
  labs(x = NULL, y = expression("Roots ("*g~m^{-2}*")"), shape = NULL) +
  theme_classic(base_size = 12)

# Aboveground Biomass (Change in RDM)
p_rdm_allprecip <- pred_long %>%
  # Filter for Year = 2024
  filter(Treatment == "Burn",
         # Response variable (change in soil C) - don't include NA
         !is.na(final_RDM),
         # Predictor variable (Block of predictors) - don't include NA
         !is.na(predictor_value)) %>%
  # Plot response ~ all predictors
  ggplot(aes(x = predictor_value, y = final_RDM)) +
  # Add points
  geom_point(alpha = 0.75) +
  # Add regression line
  geom_smooth(method = "lm", se = TRUE) +
  # Facet wrap and scale with free_x (predictors might have diff units)
  facet_wrap(~ predictor_name, scales = "free_x") +
  # Label y-axis with response variable
  labs(x = NULL, y = "Change in RDM (g)", shape = NULL) +
  theme_classic(base_size = 12)

### Predictor-Predictor Correlation Checks ###
## GGpairs for sensible blocks of predictors
# Shows nonlinearity and outliers
# Always make sure to look at correlations for the same subset of predictors in the model

# Load library to look at paired plots
library(GGally)


# Need specific data frames depending on the response variable
# Burn Only since soil C only looks at burn transects
predictor_burn <- analysis_carbon %>%
  # Filter to only include predictors from the Treatment = Burn
  filter(Treatment == "Burn") %>% 
  # Select all predictor variables (will swap this out with Block)
  select(all_of(predictor_vars)) %>%
  # Make sure the predictor variables are numeric
  select(where(is.numeric)) %>%
  # Drop any NA
  drop_na()
# See correlation plot for subset
cor(predictor_burn, use = "pairwise.complete.obs")

# View the paired plots for those filtered predictors (Burn only)
GGally::ggpairs(predictor_burn)

# Do it again for Year = 2024 only, since this was for root biomass and change in aboveground biomass 
# 2024 Only
predictor_2024 <- analysis_carbon %>%
  # Filter to only include predictors from the Treatment = Burn
  filter(Year == "2024") %>% 
  # Select all predictor variables(Will swap this out with Block)
  select(all_of(predictor_vars)) %>%
  # Make sure the predictor variables are numeric
  select(where(is.numeric)) %>%
  # Drop any NA
  drop_na()
# See correlation plot for subset
cor(predictor_2024, use = "pairwise.complete.obs")

# View the paired plots for those filtered predictors (Burn only)
GGally::ggpairs(predictor_2024)
