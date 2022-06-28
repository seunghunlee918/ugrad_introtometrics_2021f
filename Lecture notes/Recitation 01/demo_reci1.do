/*====================================================================*/
* STATA demo for Recitation 1              
* Date: Jan 18th, 2021
* Author: Seung-hun Lee                    
/*====================================================================*/


/* To-do list
1. Commenting on the codes
2. How best to start your codes
3. Setting up directories
4. Playing around with variables in the data.
*/


***** 1. `Note-taking' (or commenting) on STATA
/* Not everything on the code file has to be a STATA command. In fact,
I recommend commenting on the codes extensively to make sure that 
you are knowledgeable about what the codes are intended to do. 
The comments are in green. codes in other colors are commands that the 
STATA executes.														*/

* You can comment on one line using `*' (as I did for this line)


/* If you have multiple lines of codes or you want to begin commenting
from the middle of the line, you can wrap them around
`/*' and `*/', as I did for this set of comments
*/


***** 2. Starting the codes + 3. directories

clear all /*clears the memory of any previous coding work*/
set more off /*Prevents STATA from pausing when the results window is filled up*/

/* Directories: By default STATA directory is set to whereever you installed it
If you want to change them, do as follows
*/

* 1. using `cd' command (change directories): cd "your own filepath"
cd "/Users/seung-hunlee/Desktop/Columbia/Columbia Google Drive/TA work/Spring2021-Intro to Econometrics/Recitations_2021/Recitation1"

use "auto.dta", replace /*opens the STATA .dta file*/
* Note: I highly recommend putting ", replace". otherwise, the command won't work if you have something else opened in STATA

* (could be bit tricky): 2. using global macros
* Effectively, you are naming that filepath so that you don't need to write a very long name each time
global reci1 "/Users/seung-hunlee/Desktop/Columbia/Columbia Google Drive/TA work/Spring2021-Intro to Econometrics/Recitations_2021/Recitation1"

use "$reci1/auto.dta", replace


***** 4. Playing around with the data
** Logs
/*Logs can store your codes and outputs in a displaybale form. 
When you submit your problem set with codes, we recommend using logs.
Make sure to close them at the end of the code. */

log using "$reci1/log_demo.pdf", replace

** Organizing the data
sort headroom /*re-order observations from smallest headroom to largest*/
 * To do largest to lowest, use "gsort -headroom"
 
list headroom in 1/5 /* show the value of headroom in first five observations*/

* generating new variables
generate logweight = log(weight)
order logweight, after(weight) /*re-order variables*/

** Summary statistics
summarize /*show summary stats for all variables*/
summarize price /*for just one variable*/
summarize price if weight>2000  /*only for cars weighing above 2000*/
summarize price if foreign==1 /*only for foreign cars*/

sort foreign
by foreign: summarize price /*summarize separately by foreign/domestic categories*/
* you must sort by that variable first

summarize price,detail /*more details*/

* Graphs
histogram headroom /*make histogram using headroom */
graph save "$reci1/histogram_headroom.jpg", replace /*you can use other extensions like .png or .gph */

* graphs with two variables
twoway scatter price length /*price in y, length in x */
graph save "$reci1/scatterplot.jpg", replace

log close

