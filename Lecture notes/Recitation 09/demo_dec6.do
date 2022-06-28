***********************
* Demo files for Problem set 6
* Seung-hun Lee
* No permission needed in using/reproducing/sharing this do file
***********************

*************** Things I put on the beginning of each code

clear all 
set more off 

cd "/Volumes/GoogleDrive/내 드라이브/TA work/Fall2021-Intro to Econometrics/Recitations_2021_2/Recitation9"

global reci9 "/Volumes/GoogleDrive/내 드라이브/TA work/Fall2021-Intro to Econometrics/Recitations_2021_2/Recitation9"



* Open a dta file
use "$reci9/fertility.dta", replace
* Note: if your STATA is a student version, you may need to run fertility_small.dta

* Simple OLS
regress weeksm1 morekids, vce(robust)

* Ivregress (need to specify 2sls, firststage is optional)
ivregress 2sls weeksm1 (morekids = samesex), first vce(robust)

* Ivregress done wrong (can you tell me why?)
regress morekids samesex, vce(robust)
predict morekidshat
regress weeksm1 morekidshat, vce(robust)


* Thought experiment: Difference between boyboy and girlgirl combination (part d)
gen boyboy = 1 if boy1st==1 & boy2nd ==1
replace boyboy =0 if boyboy==.

gen girlgirl = 1 if boy1st==0 & boy2nd ==0
replace girlgirl =0 if girlgirl==.

regress morekids boyboy girlgirl, vce(robust)
test boyboy = girlgirl


* Ivregress (need to specify 2sls, firststage is optional)
ivregress 2sls weeksm1 (morekids = samesex) agem1 black hispan othrace, first vce(robust)


* Hardcore way of finding IV
ivregress 2sls weeksm1 (morekids =boyboy girlgirl) agem1 black hispan othrace, first vce(robust)
predict uhat, resid
regress uhat boyboy girlgirl agem1 black hispan othrace, vce(robust)
test boyboy girlgirl
scalar Jtest = 2*r(F)
display Jtest


* Ivregress extension: Overidentification test - easy way (using Sargan's test)
ivregress 2sls weeksm1 (morekids =boyboy girlgirl) agem1 black hispan othrace, first vce(robust)
estat overid


