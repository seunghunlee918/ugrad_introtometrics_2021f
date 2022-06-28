***********************
* Demo files for Nov 25th recitation
* Seung-hun Lee
* No permission needed in using/reproducing/sharing this do file
***********************

*************** Things I put on the beginning of each code

clear all 
set more off 

cd "/Volumes/GoogleDrive/내 드라이브/TA work/Fall2021-Intro to Econometrics/Recitations_2021_2/Recitation7"

global reci7 "/Volumes/GoogleDrive/내 드라이브/TA work/Fall2021-Intro to Econometrics/Recitations_2021_2/Recitation7"



* Open a dta file
use "$reci7/deregulate.dta", replace

* Since word variables themselves cannot be used as id variables in xtset, we need to do this trick
encode airline, generate(id)
xtset id year
xtset id
{/* Here are the questions for this exercise

(a) Regress the log of costs on the regulation dummy, year and the natural logs of three price variables and of stage (i) using OLS (ii) using firm-specific fixed effects without cluster (iii) with cluster
(b) What is the interpretation of regulation dummy’s coefficient?

(c) What is the interpretation of year’s coefficient?

(d) Briefly explain why we can conclude that the estimated standard errors reported for OLS are probably incorrect as well as the ones in fixed effects regression without cluster errors?

(e) What does the fixed effects regression imply about the effect of deregulation on airlines’ variable cost?

(f) How do you counter the objection that technical change would have reduced airline costs even without the deregulation?

(g) Add the squares of the logged regressors to the fixed effects regression in (a). What does this regression suggest about the conclusions in (e)?

(h) Are the added terms in regression (g), taken together, jointly statistically significant? Show the needed test results.

(i) Some have argued that deregulation enables airlines to better plan their flight. This could mean that more efficient flight lengths were chosen after deregulation. How does this affect the interpretations in (e) and (g), and how would you take this consideration into account?
*/
}
* (a) -(f) OLS vs FE without cluster vs FE with cluster
* Local macro and loop: Useful for repetitive tasks (local macros are alive only for each trial and not the whole session where the STATA is turned on before clear command is activated)

local logvar "vc pl pf pm stage" /*define a list of words called logvar*/
local n: word count `logvar' /*n = number of words in logvar (useful if lists are long)*/
forvalues i=1/`n'{
	local a: word `i' of `logvar' /*for each i, `a' will have a different name*/
	gen l`a' = log(`a')
}

reg lvc reg lpl lpf lpm lstage year, vce(robust)
xtreg lvc reg lpl lpf lpm lstage year,fe 
xtreg lvc reg lpl lpf lpm lstage year,fe vce(cluster id)

* Compare with (notice the standard errors)
areg lvc reg lpl lpf lpm lstage year,absorb(id) cluster(id)

* Part (g)
local log2var "pl pf pm stage"
local n: word count `log2var'
forvalues i=1/`n'{
	local a: word `i' of `log2var'
	gen l`a'2 = log(`a')^2
}
xtreg lvc reg lpl* lpf* lpm* lstage*  year,fe vce(cluster id) /*Asterisk: include all variables sharing the sale lpl, so both lpl and lpl2 are included*/

*(h) test for joing significance
test lpl2 lpf2 lpm2 lstage2 

* Differencing a variable across time within the same entity
sort id year
local diffvar "vc pl pf pm stage"
local n: word count `diffvar'
forvalues i=1/`n'{
	local a: word `i' of `diffvar'
	gen diff`a' = `a'[_n]-`a'[_n-1] if id[_n]==id[_n-1] /*subtract variable a_n - a_(n-1) only if the two terms share the same id*/
}




