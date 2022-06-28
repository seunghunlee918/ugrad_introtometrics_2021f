***********************
* Demo files for Oct 11th recitation
* Seung-hun Lee
* No permission needed in using/reproducing/sharing this do file
***********************

*************** Things I put on the beginning of each code

clear all 
set more off 

cd "/Users/seung-hunlee/Desktop/Columbia/Columbia Google Drive/TA work/Fall2021-Intro to Econometrics/Recitations_2021_2/Recitation3" 

global reci3 "/Users/seung-hunlee/Desktop/Columbia/Columbia Google Drive/TA work/Fall2021-Intro to Econometrics/Recitations_2021_2/Recitation3" 


***
use "$reci3/auto.dta", replace

*** Generating new variables 

generate year = 2021 /*generates year variable*/

** Dummies (1 if price higher than 5,000 and 0 otherwise)
generate expensive = . /*produces empty column*/
replace expensive = 1 if price >5000
replace expensive = 0 if price <=5000

/*
Note, if your condition involves something equal, make sure to have ==
(You need two 'equals' sign)
*/

* Quick way of generating many dummy variables (useful for fixed effects in panels)
tabulate make, gen(carname) /*generate carname1 carname2 ....*/

*** Multivariate regression testing
regress price weight length headroom, vce(robust)
test length headroom /*tests whether two coefficients are zero*/
test length= headroom /*tests whether two coefficients are equal*/
test length + headroom = 0 /*tests whether two coefficients sum to zero*/
