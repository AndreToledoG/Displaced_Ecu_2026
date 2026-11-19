local demographic_covariates                               ///
    age age_sq                                             ///
    female                                                 ///
    partnered                                              ///
    household_head                                         ///
    i.education_level                                      ///
    i.ethnicity                                            ///
    urban                                                  ///
    i.region
	
	oaxaca log_hourly_earnings `demographic_covariates'        ///
    if oaxaca_sample == 1, by(foreign_born)
	
	*No incluiría simultáneamente partnered y marital_status, ni region y efectos fijos provinciales. 
	*Para el modelo principal escogería las opciones más parsimoniosas: partnered y region.
	
	oaxaca log_hourly_earnings `demographic_covariates'        ///
    if oaxaca_sample == 1 & female == 1, by(foreign_born)
	
	