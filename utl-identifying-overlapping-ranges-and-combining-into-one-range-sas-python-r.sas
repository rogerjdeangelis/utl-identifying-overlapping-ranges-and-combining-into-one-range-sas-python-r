%let pgm=utl-identifying-overlapping-ranges-and-combining-into-one-range-sas-python-r;

Identifying overlapping ranges and combining into one range sas python r

SOAPBOX ON
 SAS is available on a local worstation
SOAPBOX OFF

   SOLUTIONS

       1 r
       2 sas
       3 don't understand python loops
/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/**************************************************************************************************************************/
/*                            |                                                    |                                        */
/*                            |                                                    |                                        */
/*          INPUT             |      PROCESS (SAS & R are similar)                 |                 OUTPUT                 */
/*                            |                                                    |                                        */
/*                            |     R                                              |                                        */
/*                            |     =                                              |                                        */
/*     START        END       |     dates[1,"GRP"]=1                               |     Group    START          END        */
/*                            |     sum<-1                                         |                                        */
/* 1 ==START===               |     for (i in seq(2,nrow(dates),1)) {              |     1      2006-06-26      2006-08-16  */
/*   2006-06-26 2006-07-24    |       lagone   dates[i-1,"END"] - dates[i,"START"] |                                        */
/*   2006-07-19 2006-08-16    |       if (lagone  < 0 ) { sum =sum + 1}            |     2      2007-06-09      2007-07-31  */
/*              ===END====    |       dates[i,"GRP"] = sum;                        |                                        */
/*                            |     }                                              |     3      2007-08-04      2007-09-04  */
/* 2 ==START===               |                                                    |                                        */
/*   2007-06-09 2007-07-07    |      want<-sqldf("                                 |     4      2007-09-05      2007-10-12  */
/*   2007-06-24 2007-07-22    |        select                                      |                                        */
/*                            |           min(start) as min_start                  |     5      2007-10-19      2007-11-16  */
/*   2007-07-03 2007-07-31    |          ,max(end)   as max_end                    |                                        */
/*               ===END====   |        from                                        |     6      2007-11-17      2007-11-16  */
/*                            |           dates                                    |                                        */
/* 3 ==START===               |        group                                       |     7      2008-06-18      2008-08-20  */
/*   2007-08-04 2007-09-01    |           by grp                                   |                                        */
/*   2007-08-07 2007-09-04    |        ");                                         |                                        */
/*              ===END====    |                                                    |                                        */
/*                            |                                                    |                                        */
/* 4 ==START===               |     SAS (SIMILAR TO LOOP IN R)                     |                                        */
/*   2007-09-05 2007-10-03    |     ===========================                    |                                        */
/*   2007-09-14 2007-10-12    |     data want(keep=grp start end);                 |                                        */
/*              ===END====    |       retain grp 1;                                |                                        */
/*                            |       set sd1.dates;                               |                                        */
/* 5 ==START===               |       lagend=lag(end);                             |                                        */
/*   2007-10-19 2007-11-16    |       if (start-lagend) ge 0 then grp=grp+1;       |                                        */
/*              ===END====    |     run;quit;                                      |                                        */
/*                            |                                                    |                                        */
/* 6 ==START===               |     select                                         |                                        */
/*   2007-11-17 2007-12-15    |       min(start) as start                          |                                        */
/*              ===END====    |      ,max(end)   as end                            |                                        */
/*                            |     from                                           |                                        */
/* 7 ==START===               |       want                                         |                                        */
/*   2008-06-18 2008-07-16    |     group                                          |                                        */
/*   2008-06-28 2008-07-26    |       by grp                                       |                                        */
/*   2008-07-11 2008-08-08    |                                                    |                                        */
/*   2008-07-23 2008-08-20    |                                                    |                                        */
/*              ===END====    |                                                    |                                        */
/*                            |                                                    |                                        */
/*                            |                                                    |                                        */
/**************************************************************************************************************************/
/*       _                               _ _       _             _       _                 _
(_)_ __ | |_ ___ _ __ _ __ ___   ___  __| (_) __ _| |_ ___    __| | __ _| |_ __ _ ___  ___| |_
| | `_ \| __/ _ \ `__| `_ ` _ \ / _ \/ _` | |/ _` | __/ _ \  / _` |/ _` | __/ _` / __|/ _ \ __|
| | | | | ||  __/ |  | | | | | |  __/ (_| | | (_| | ||  __/ | (_| | (_| | || (_| \__ \  __/ |_
|_|_| |_|\__\___|_|  |_| |_| |_|\___|\__,_|_|\__,_|\__\___|  \__,_|\__,_|\__\__,_|___/\___|\__|

*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*       START          END       GROUP    Once you have the groups                                                       */
/*                                                                                                                        */
/*     2006-06-26    2006-07-24    1         select                                                                       */
/*     2006-07-19    2006-08-16    1           min(start) as start                                                        */
/*     2007-06-09    2007-07-07    2          ,max(end)   as end                                                          */
/*     2007-06-24    2007-07-22    2         from                                                                         */
/*     2007-07-03    2007-07-31    2           want                                                                       */
/*     2007-08-04    2007-09-01    3         group                                                                        */
/*     2007-08-07    2007-09-04    3           by grp                                                                     */
/*     2007-09-05    2007-10-03    4       ;                                                                              */
/*     2007-09-14    2007-10-12    4                                                                                      */
/*     2007-10-19    2007-11-16    5                                                                                      */
/*     2007-11-17    2007-12-15    6                                                                                      */
/*     2008-06-18    2008-07-16    7                                                                                      */
/*     2008-06-28    2008-07-26    7                                                                                      */
/*     2008-07-11    2008-08-08    7                                                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/

 /*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.dates ;
 informat start end yymmdd10.;
 format start end yymmdd10.;
 input start end;
cards4;
2006-06-26 2006-07-24
2006-07-19 2006-08-16
2007-06-09 2007-07-07
2007-06-24 2007-07-22
2007-07-03 2007-07-31
2007-08-04 2007-09-01
2007-08-07 2007-09-04
2007-09-05 2007-10-03
2007-09-14 2007-10-12
2007-10-19 2007-11-16
2007-11-17 2007-12-15
2008-06-18 2008-07-16
2008-06-28 2008-07-26
2008-07-11 2008-08-08
;;;;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* Obs      START          END                                                                                            */
/*                                                                                                                        */
/*   1    2006-06-26    2006-07-24                                                                                        */
/*   2    2006-07-19    2006-08-16                                                                                        */
/*   3    2007-06-09    2007-07-07                                                                                        */
/*   4    2007-06-24    2007-07-22                                                                                        */
/*   5    2007-07-03    2007-07-31                                                                                        */
/*   6    2007-08-04    2007-09-01                                                                                        */
/*   7    2007-08-07    2007-09-04                                                                                        */
/*   8    2007-09-05    2007-10-03                                                                                        */
/*   9    2007-09-14    2007-10-12                                                                                        */
/*  10    2007-10-19    2007-11-16                                                                                        */
/*  11    2007-11-17    2007-12-15                                                                                        */
/*  12    2008-06-18    2008-07-16                                                                                        */
/*  13    2008-06-28    2008-07-26                                                                                        */
/*  14    2008-07-11    2008-08-08                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
/ |  _ __
| | | `__|
| | | |
|_| |_|

*/

/*----                                                                   ----*/
/*---- you have to install SASXport from archivez more useful than haven ----*/
/*----                                                                   ----*/

%utl_rbegin;
parmcards4;
library(sqldf)
library(haven)
library(SASxport)
dates<-read_sas("d:/sd1/dates.sas7bdat")
dates[1,"GRP"]=1
sum<-1
for (i in seq(2,nrow(dates),1)) {
  lagone = dates[i-1,"END"] - dates[i,"START"]
  if (lagone  < 0 ) { sum =sum + 1}
  dates[i,"GRP"] = sum;
  print(sum)
}
dates
want<-sqldf("
  select
    min(start) as min_start
   ,max(end)   as max_end
  from
    dates
  group
    by grp
  ");
str(want)
want$min_start <- as.Date(want$min_start, format = "%Y-%m-%d", origin="1970-01-01")
want$max_end <- as.Date(want$max_end, format = "%Y-%m-%d", origin="1970-01-01")
want;
for (i in seq_along(want)) {
          label(want[,i])<- colnames(want)[i]
       };
write.xport(want,file="d:/xpt/want.xpt")
;;;;
%utl_rend;

/*--- handles long variable names in SAS V5 transporst files using the label to rename the variables  ----*/

proc datasets lib=sd1 nolist mt=data mt=view nodetails;delete want want_py_long_names; run;quit;
proc datasets lib=sd1 nolist mt=data mt=view lib=work nodetails;delete want; run;quit;

libname xpt xport "d:/xpt/want.xpt";
proc contents data=xpt._all_;
run;quit;

data want_py_long_names;
  %utl_rens(xpt.want) ;
  set want;
  format min_start max_end date9.;
run;quit;
libname xpt clear;


/**************************************************************************************************************************/
/*                                                                                                                        */
/*      INTERMEDIATE DATAFRAME                   OUTPUT                                                                   */
/*                                                                                                                        */
/*  # A tibble: 14 x 3                                                 WANT_PY_LONG_NAMES                                 */
/*     START      END          GRP            MIN_START    MAX_END     Obs    MIN_START     MAX_END                       */
/*     <date>     <date>     <dbl>                                                                                        */
/*   1 2006-06-26 2006-07-24     1         1 2006-06-26 2006-08-16      1     26JUN2006    16AUG2006                      */
/*   2 2006-07-19 2006-08-16     1         2 2007-06-09 2007-07-31      2     09JUN2007    31JUL2007                      */
/*   3 2007-06-09 2007-07-07     2         3 2007-08-04 2007-09-04      3     04AUG2007    04SEP2007                      */
/*   4 2007-06-24 2007-07-22     2         4 2007-09-05 2007-10-12      4     05SEP2007    12OCT2007                      */
/*   5 2007-07-03 2007-07-31     2         5 2007-10-19 2007-11-16      5     19OCT2007    16NOV2007                      */
/*   6 2007-08-04 2007-09-01     3         6 2007-11-17 2007-12-15      6     17NOV2007    15DEC2007                      */
/*   7 2007-08-07 2007-09-04     3         7 2008-06-18 2008-08-08      7     18JUN2008    08AUG2008                      */
/*   8 2007-09-05 2007-10-03     4                                                                                        */
/*   9 2007-09-14 2007-10-12     4                                                                                        */
/*  10 2007-10-19 2007-11-16     5                                                                                        */
/*  11 2007-11-17 2007-12-15     6                                                                                        */
/*  12 2008-06-18 2008-07-16     7                                                                                        */
/*  13 2008-06-28 2008-07-26     7                                                                                        */
/*  14 2008-07-11 2008-08-08     7                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___
|___ \   ___  __ _ ___
  __) | / __|/ _` / __|
 / __/  \__ \ (_| \__ \
|_____| |___/\__,_|___/

*/

proc datasets lib=sd1 nolist mt=data mt=view nodetails;delete want want_py_long_names; run;quit;
proc datasets lib=sd1 nolist mt=data mt=view lib=work nodetails;delete want; run;quit;

data lag(keep=grp start end);
  retain grp 1;
  set sd1.dates;
  lagend=lag(end);
  if (start-lagend) ge 0 then grp=grp+1;
run;quit;

proc sql;
  create
    table want as
  select
    min(start) as start format=date9.
   ,max(end)   as end   format=date9.
  from
    lag
  group
    by grp
;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*                                                                                                                        */
/*  Obs      START         END                                                                                            */
/*                                                                                                                        */
/*   1     26JUN2006    16AUG2006                                                                                         */
/*   2     09JUN2007    31JUL2007                                                                                         */
/*   3     04AUG2007    04SEP2007                                                                                         */
/*   4     05SEP2007    12OCT2007                                                                                         */
/*   5     19OCT2007    16NOV2007                                                                                         */
/*   6     17NOV2007    15DEC2007                                                                                         */
/*   7     18JUN2008    08AUG2008                                                                                         */
/*                                                                                                                        */
/**************************************************************************************************************************/


REPO
----------------------------------------------------------------------------------------------------------------------------------
https://github.com/rogerjdeangelis/utl-calculating-and-summing-a-series-when-subsequent-elements-depend-on-previous-elements
https://github.com/rogerjdeangelis/utl-cubic-spline-interpolation-for-missing-values-in-a-time-series-by-group
https://github.com/rogerjdeangelis/utl-fill-in-data-between-two-dates-within-by-group-with-non-missing-values-timeseries
https://github.com/rogerjdeangelis/utl-fill-in-gaps-in-time-series-by-groups
https://github.com/rogerjdeangelis/utl-identifying-continuos-subseries-of-enrollment-from-claims-data
https://github.com/rogerjdeangelis/utl-impute-missing-values-in-a-arima-timeseries
https://github.com/rogerjdeangelis/utl_detecting_structural_breaks_in_a_time_series
https://github.com/rogerjdeangelis/utl_how_to_automate_a_series_of_logistic_regressions
https://github.com/rogerjdeangelis/utl_interpolating_values_in_a_timeseries_when_first-_last_and_middle_values_are_missing
https://github.com/rogerjdeangelis/utl_javascript_dygraph_graphics_multipanel_time_series

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
