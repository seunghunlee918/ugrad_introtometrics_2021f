***********************
* Demo files for Oct 4th recitation
* Seung-hun Lee
* No permission needed in using/reproducing/sharing this do file
***********************

/*
Note: The green ones are comments: Stata ignores this as it runs
The reason you need comments is for yourself: You may need to explain others and your future self what each part of the code does.

For single line comment, putting * in front of each line would do
Surround multi-line comments with /*  */
*/


*************** Things I put on the beginning of each code

clear all /* This clears out all the files/records/macros I used in previous STATA run*/
set more off /* If the output table is extremely long, STATA stops running midway. Putting this code prevents this*/

cd "/Users/seung-hunlee/Desktop/Columbia/Columbia Google Drive/TA work/Fall2021-Intro to Econometrics/Recitations_2021_2/Recitation2" /*changes working directory (where you save files, so change this part to the suitable directory in your computer) */

global reci2 "/Users/seung-hunlee/Desktop/Columbia/Columbia Google Drive/TA work/Fall2021-Intro to Econometrics/Recitations_2021_2/Recitation2" /*give a short name to a long file (don't need to know this now)*/

*************** Loading up a file
 use "$reci2/auto.dta", replace  /*replace: tell Stata to replace the dataset to the one you are loading up.*/
 
*use "/Users/seung-hunlee/Desktop/Columbia/Columbia Google Drive/TA work/Fall2021-Intro to Econometrics/Recitations_2021_2/Recitation2/auto.dta", replace 
/* If I did not have a global command, i would need above */


* In case where you upload an excel file, you need a different command
* import excel "file name with file path similar to above", sheet("sheetname") firstrow

************* Logs (so that you can turn your output into a clean pdf file without doing all the messy labor)
log using "$reci2/demo_oct4.smcl", replace /* It will produce a smcl file that tracks the codes and output you produce*/


* Summary statistics for some variables
summarize price length headroom
sum price length headroom /* If you are just beginning Stata, I encourage typing the full command*/


* Y: price, X: length (try with other combinatiosn, or even more than one X)
regress price length
regress price length, vce(robust) /*heteroskedasticity adjusted std. errors*/
regress price length headroom

* Graphing the outcomes 
graph twoway (lfit price length) (scatter price length)
graph export "$reci2/graph.png", replace /*saves graph*/

* Further customization (The first two lines change the scheme to a different one, no need to worry about this)

graph twoway (lfit price length, lcolor(purple)) (scatter price length, msize(medsmall) mcolor(black)), title("Linear relation between price and length") xtitle("length") ytitle("price")
graph export "$reci2/graph_fance.png", replace 

* For more information on any command...
*help regress 
*help graph twoway

log close /*closes logs. You need to put this!*/
translate "$reci2/demo_oct4.smcl" "$reci2/demo_oct4.pdf", translator(smcl2pdf) replace /* Exports the log into a pdf!*/






