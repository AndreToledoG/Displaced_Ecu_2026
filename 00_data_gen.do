/*
GENERATE DATASETS 

Ana Rivadeneira
Created Oct 22, 2026

Create pooled Enemdu datasets for JDC project on labor market of migrants and refugees 

*/
*==============================================================================
*= INITIAL SETTINGS
*==============================================================================

** 1. Seth path
cd "C:\Users\wb510246\OneDrive - WBG\0. Data\ECUADOR\ENEMDU\2_raw\"

*==============================================================================
*= APPEND DEC 15-17 LABOUR SURVEYS
*==============================================================================
** 1. Merge individual and household data
local year = "15 16 17 "
foreach x of local year {
	use "..\2_raw\enemdu_persona_20`x'_12.dta", clear
	gen year = 20`x'

	preserve
		use "..\2_raw\enemdu_vivienda_20`x'_12.dta", clear
		gen year = 20`x'
	
		tempfile aux
		save "`aux'"
	restore

	merge m:1 id_hogar using "`aux'", keep(1 3) nogen
	
	tempfile aux`x'
	save "`aux`x''"
}

** 2. Append data
use "`aux15'", clear
append using "`aux16'" "`aux17'" , force 

* 2.1 Correct lables
label define p15aa 1  "En esta ciudad" 2 "En otro lugar del país" 3 "En otro país", replace
label values p15aa p15aa 

tab year

** 3. Save dataset
compress
save "C:\Users\wb510246\OneDrive - WBG\14. Migracion 2026\Datos\inec\0_enemdu2015_2017", replace
	
*==============================================================================
*= APPEND ANNUAL LABOUR SURVEYS 2018 - 2025
*==============================================================================

** 1. Merge individual and household data
local year = "18 19 20 21 22 23 24 25"
foreach x of local year {
	use "..\2_raw\enemdu_personas_20`x'_anual.dta", clear
	gen year = 20`x'
	cap tostring ciudad, replace force
	cap destring prov, replace force
	
	preserve
		use "..\2_raw\enemdu_vivienda_20`x'_anual.dta", clear
		gen year = 20`x'
		cap tostring ciudad, replace force
		cap destring prov, replace force
		tempfile aux
		save "`aux'"
	restore

	merge m:1 id_hogar using "`aux'", keep(1 3) nogen
	
	tempfile aux`x'
	save "`aux`x''"
}

** 2. Append data
use "`aux18'", clear
append using "`aux19'" "`aux20'" "`aux21'" "`aux22'" "`aux23'" "`aux24'" "`aux25'" , force 

replace periodo = strofreal(year) + mes if periodo == ""

tab1 year periodo

** 3. Save dataset
compress
save "C:\Users\wb510246\OneDrive - WBG\14. Migracion 2026\Datos\inec\0_enemdu2018_2025", replace
	
