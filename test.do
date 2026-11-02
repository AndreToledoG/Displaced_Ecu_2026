
clear all
set more off

sysuse auto, clear

summarize price mpg weight

regress price mpg weight

display "Sight is working!"

tabstat price mpg weight, statistics(mean sd)

twoway ///
    (scatter price mpg if foreign == 0, ///
        mcolor(navy) msymbol(circle) msize(medium)) ///
    (scatter price mpg if foreign == 1, ///
        mcolor(maroon) msymbol(circle) msize(medium)) ///
    (lfit price mpg, lcolor(black) lpattern(dash) lwidth(medthick)), ///
    title("Car price vs. mileage") ///
    xtitle("Mileage (mpg)") ///
    ytitle("Price (USD)") ///
    legend(order(1 "Domestic" 2 "Foreign" 3 "Overall linear fit") position(6) rows(1)) ///
    graphregion(color(white))