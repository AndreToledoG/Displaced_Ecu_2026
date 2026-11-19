* 1. Prepare variables for labor-market series 

* Informal sector
* infsec: 0 = Formal, 1 = Informal, 2 = Other
* The resulting indicator equals one only for the informal sector=1
capture drop informal_sector
gen informal_sector = .
replace informal_sector = 0 if employed == 1 & !inlist(infsec,0,1,2)
replace informal_sector = 1 if employed == 1 & infsec == 1
label variable informal_sector "Employment informal sector"

* Self-employment
* job_status == 3 includes employers and own-account workers
capture drop self_employed
gen self_employed = .
replace self_employed = 0 if employed == 1 & !inrange(job_status,1,4)
replace self_employed = 1 if employed == 1 & job_status == 3
label variable self_employed "Self-employment"

* Weekly hours: Preserve the original variable included in variables.do
* Monthly labor earnings: Preserve the original variable included in variables.do
* Hourly labor earnings: Preserve the original variable included in variables.do

* Check the binary variables
assert inlist(employed,0,1)   if !missing(employed)
assert inlist(unemployed,0,1) if !missing(unemployed)
assert inlist(djubila,0,1)    if !missing(djubila)
assert inlist(informal_e,0,1) if !missing(informal_e)

* 2. Define outcomes and grouping variables

* foreign_born and nac are used to define population groups
local groupvars foreign_born nac

* Outcomes included in the series
local outcomes                                             ///
    employed                                               ///
    unemployed                                             ///
    informal_sector                                        ///
    djubila                                                ///
    informal_e                                             ///
    weekly_hours_series                                    ///
    ingrl_series                                           ///
    hourly_earnings_series                                 ///
    self_employed

* Binary outcomes reported as percentages
local percentage_outcomes                                  ///
    employed                                               ///
    unemployed                                             ///
    informal_sector                                        ///
    djubila                                                ///
    informal_e                                             ///
    self_employed

* 3. Open results file
tempfile labor_market_series
tempname results

postfile `results'                                         ///
    int    years                                           ///
    str20  grouping_variable                               ///
    double population_group                                ///
    str30  population_group_label                          ///
    str32  indicator                                       ///
    str60  indicator_label                                 ///
    str24  indicator_type                                  ///
    double estimate                                        ///
    double standard_error                                  ///
    double ci_lower                                        ///
    double ci_upper                                        ///
    double coefficient_variation                           ///
    long   observations                                    ///
    double expanded_population                             ///
    using `labor_market_series', replace

* Identify the available years
quietly levelsof year if inrange(year,2018,2025), ///
    local(year_list)

* 4. Estimate series
foreach groupvar of local groupvars {
    display as text "Estimating results by `groupvar'..."
    * Identify all categories
    quietly levelsof `groupvar' if !missing(`groupvar'), ///
        local(group_values)
    local number_groups : word count `group_values'
    * Verify expected number of categories
    if "`groupvar'" == "foreign_born" & ///
       `number_groups' != 2 {
        display as error ///
            "foreign_born should contain two categories."
        continue
    }
    if "`groupvar'" == "nac" & ///
       `number_groups' != 4 {
        display as error ///
            "nac should contain four categories."
        continue
    }

    * Loop over years
    foreach y of local year_list {
        * Loop over population groups
        foreach g of local group_values {

            * Obtain value label
            local value_label : value label `groupvar'
            if "`value_label'" != "" {
                local group_label : label (`groupvar') `g'
            }
            else {
                local group_label "`groupvar' = `g'"
            }
            * Loop over outcomes
            foreach v of local outcomes {
                * Indicator name, type, and scale
                local output_name "`v'"
                local scale 1
                local indicator_type "Mean"

                * Report binary outcomes as percentages
                if strpos(" `percentage_outcomes' ", " `v' ") {
                    local scale 100
                    local indicator_type "Percentage"
                }

                * Continuous outcomes
                if "`v'" == "weekly_hours_series" {
                    local output_name "weekly_hours"
                    local indicator_type "Mean: hours/week"
                }

                if "`v'" == "ingrl_series" {
                    local output_name "ingrl"
                    local indicator_type "Mean: monthly earnings"
                }

                if "`v'" == "hourly_earnings_series" {
                    local output_name "hourly_earnings"
                    local indicator_type "Mean: hourly earnings"
                }

                if "`v'" == "informal_sector" {
                    local output_name "infsec"
                }

                local indicator_label : variable label `v'
                if "`indicator_label'" == "" {
                    local indicator_label "`output_name'"
                }
                * Estimation sample
                local estimation_sample                    ///
                    years == `y'                           ///
                    & `groupvar' == `g'                   ///
                    & !missing(`v')                       ///
                    & !missing(fexp)                      ///
                    & fexp > 0

                * Unweighted observations
                quietly count if `estimation_sample'
                local sample_n = r(N)
                * Estimate when observations are available
                if `sample_n' > 0 {
                    * Expanded population
                    quietly summarize fexp                ///
                        if `estimation_sample', meanonly

                    scalar expanded_n = r(mean)*r(N)

                    * Survey-weighted domain estimate
                    capture quietly svy, subpop(           ///
                        if `estimation_sample'): mean `v'

                    if _rc == 0 {

                        * Estimate and standard error
                        scalar point_estimate =            ///
                            _b[`v']*`scale'

                        scalar estimate_se =               ///
                            _se[`v']*`scale'

                        * Critical value for 95% confidence interval
                        scalar critical_value =            ///
                            invnormal(0.975)

                        capture scalar survey_df = e(df_r)

                        if _rc == 0 {
                            if survey_df > 0 & survey_df < . {
                                scalar critical_value =    ///
                                    invttail(survey_df,0.025)
                            }
                        }

                        * Confidence interval
                        scalar lower_bound =               ///
                            point_estimate                 ///
                            - critical_value*estimate_se
                        scalar upper_bound =               ///
                            point_estimate                 ///
                            + critical_value*estimate_se

                        * Coefficient of variation: CV = |standard error / estimate| × 100
                        scalar cv = .

                        if abs(point_estimate) > 0 &       ///
                           point_estimate < . {

                            scalar cv =                    ///
                                abs(estimate_se /          ///
                                point_estimate)*100
                        }

                        * Store successful estimate
                        post `results'                     ///
                            (`y')                          ///
                            ("`groupvar'")                 ///
                            (`g')                          ///
                            ("`group_label'")              ///
                            ("`output_name'")              ///
                            ("`indicator_label'")          ///
                            ("`indicator_type'")           ///
                            (point_estimate)               ///
                            (estimate_se)                  ///
                            (lower_bound)                  ///
                            (upper_bound)                  ///
                            (cv)                           ///
                            (`sample_n')                   ///
                            (expanded_n)
                    }

                    * Store row when survey estimation fails
                    else {
                        post `results'                     ///
                            (`y')                          ///
                            ("`groupvar'")                 ///
                            (`g')                          ///
                            ("`group_label'")              ///
                            ("`output_name'")              ///
                            ("`indicator_label'")          ///
                            ("`indicator_type'")           ///
                            (.)                            ///
                            (.)                            ///
                            (.)                            ///
                            (.)                            ///
                            (.)                            ///
                            (`sample_n')                   ///
                            (expanded_n)
                    }
                }

                * Store empty cells
                else {

                    post `results'                         ///
                        (`y')                              ///
                        ("`groupvar'")                     ///
                        (`g')                              ///
                        ("`group_label'")                  ///
                        ("`output_name'")                  ///
                        ("`indicator_label'")              ///
                        ("`indicator_type'")               ///
                        (.)                                ///
                        (.)                                ///
                        (.)                                ///
                        (.)                                ///
                        (.)                                ///
                        (0)                                ///
                        (0)
                }
            }
        }
    }
}

postclose `results'
* 5. Prepare and save the series database
preserve
use `labor_market_series', clear

* Identify the survey period represented
gen str20 period_type = "Annual survey"
replace period_type = "December round" if ///
    inrange(years,2015,2017)
replace period_type = "Fourth quarter" if ///
    years == 2020

* Variable labels
label variable years                   "Survey year"
label variable grouping_variable "Definition used to construct population groups"
label variable population_group "Numeric population-group category"
label variable population_group_label "Population-group label"
label variable indicator "Labor-market indicator"
label variable indicator_label "Indicator description"
label variable indicator_type          ///
    "Type of indicator"
label variable estimate                ///
    "Weighted estimate"
label variable standard_error          ///
    "Standard error"
label variable ci_lower                ///
    "Lower bound, 95% confidence interval"
label variable ci_upper                ///
    "Upper bound, 95% confidence interval"
label variable coefficient_variation   ///
    "Coefficient of variation (%)"
label variable observations            ///
    "Unweighted observations"
label variable expanded_population     ///
    "Expanded population"
label variable period_type             ///
    "Survey period represented"

* Variable order
order years period_type                             ///
      grouping_variable                             ///
      population_group population_group_label       ///
      indicator indicator_label indicator_type      ///
      estimate standard_error                       ///
      ci_lower ci_upper                             ///
      coefficient_variation                         ///
      observations expanded_population

* Sort observations
sort grouping_variable indicator years population_group

* Formatting
format estimate coefficient_variation %9.2f
format standard_error ci_lower ci_upper %9.3f
format observations %12.0fc
format expanded_population %15.0fc

* Save results
capture mkdir "outputs"
save "outputs/labor_market_series.dta", replace
export excel using                                  ///
    "$graficos/labor_market_series.xlsx",             ///
    firstrow(varlabels) replace
export delimited using                              ///
    "$graficos/labor_market_series.csv", replace
restore