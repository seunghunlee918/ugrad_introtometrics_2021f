***********************
* Demo files for Oct 18th recitation
* Seung-hun Lee
* No permission needed in using/reproducing/sharing this do file
***********************

*************** Things I put on the beginning of each code

clear all 
set more off 

* Install user-generated codes (they are for the trick today)
ssc install estout, replace
ssc install asdoc, replace

cd "/Users/seung-hunlee/Desktop/Columbia/Columbia Google Drive/TA work/Fall2021-Intro to Econometrics/Recitations_2021_2/Recitation4" 

global reci4 "/Users/seung-hunlee/Desktop/Columbia/Columbia Google Drive/TA work/Fall2021-Intro to Econometrics/Recitations_2021_2/Recitation4" 

* I will solve 6.2 only (pretty long, but doable stuff)
use "$reci4/CollegeDistance.dta", replace

*(a) ED onto dist
reg ed dist
eststo part_a /*gives name to the regression, for storage purposes*/

*(b) Ed onto dist, bytest, female, black, hispanic, incomehi, ownhome, dadcoll, cue80, stwmfg80
reg ed dist bytest female black hispanic incomehi ownhome dadcoll cue80 stwmfg80
eststo part_b

** Trick: How to get the tables with into excel or word
esttab part_a part_b using "$reci4/demo_oct18.csv", title("Regression results") b(%9.4g) se(%9.4g)   star(* .10 ** .05 *** .01)  stats( N r2 r2_a, label("Obs." "R-squared" "Adjusted R-squared" )) replace

** Trick: Stata to ms Word (note that observation and r^2 are default, so I just added r2_a only)
asdoc reg ed dist, nest  save(demo_oct18.doc)  replace title(Regression results) stat(r2_a) dec(4)
asdoc reg ed dist bytest female black hispanic incomehi ownhome dadcoll cue80 stwmfg80, nest  save(demo_oct18.doc) append   title(Regression results)  stat(r2_a)  dec(4) 

*(c) difference in coef: -.073 to -.032 (so the inclusion of omitted variables raised the estimates, implying that the earlier version may suffer from underestimation due to omitted variable bias)

*(d) two factors: n is reasonably large (so that (n-1)/(n-k-1) is practically 1) and new variables are largely relevant (so that SSR component of the adjusted-Rsquared practically approaches 0 quickly)

*(e) It is 1 if dad went to college. It measures whether father's education increases child education. In this case, it does by roughly 0.7 years

*(f) these variables are unemployment rate at county level and hourly wage in manufacturing sector at state level. 
* With increase in wages, there is an increasing opportunity cost of education (larger wages lost), so negative coefficient makes sense
* With rising unemployment, opportunity cost of education in terms of employment opportunities are decreasing, so years in education is expected to rise

* Parts (g) and (h) involve plugging right numbers next to the coefficients
*(g) -.0315*2 + .0938*58 + .1454*0 + .368*1 +.3985*0 + .3952*1 + .1521*1 + .6961*0 + .0232*(7.5) -.0518*9.75+8.8275= 14.78
*(h) -.0315*4 + .0938*58 + .1454*0 + .368*1 +.3985*0 + .3952*1 + .1521*1 + .6961*0 + .0232*(7.5) -.0518*9.75+8.8275= 14.72 (difference by 0.06) 
