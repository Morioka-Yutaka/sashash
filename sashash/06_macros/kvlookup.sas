/*** HELP START ***//*

* MACRO NAME: kvlookup
*
* PURPOSE:
*   Performs a hash table lookup to efficiently retrieve variables from a
*   master dataset based on specified keys. Optionally subsets master data
*   using a condition and manages temporary views.
*
* PARAMETERS:
*   master     : (Required) Name of the master dataset to lookup from.
*   key        : (Required) Space-separated list of key variables for the lookup.
*   var        : (Required) Space-separated list of variables to retrieve from
*                the master dataset. Default is none.
*   wh         : (Optional) SQL WHERE clause condition to subset the master
*                dataset before loading into hash table. Default is none.
*   warn       : (Optional) Y/N flag. If 'Y', issues a warning in the log
*                when the lookup key is not found. Default is 'N'.
*   dropviewflg: (Optional) Y/N flag. If 'Y', drops temporary SQL view created
*                when the 'wh' parameter is used. Default is 'Y'.
*
* USAGE:
*   %kvlookup(master=sashelp.class,
*             key=Name,
*             var=Age Sex,
*             wh=Age > 12,
*             warn=Y,
*             dropviewflg=Y);
*
* NOTES:
*   - This macro creates a hash object dynamically on the first execution,
*     improving performance for repeated lookups.
*   - Ensure keys specified uniquely identify records in the master dataset.
*   - The macro automatically cleans up temporary views unless explicitly
*     disabled by setting dropviewflg=N.

*//*** HELP END ***/

%macro kvlookup(master=,key=,var=,wh=,warn=N,dropviewflg=Y);
%local name qkey qvar keynum key var wh;
%let key=%sysfunc(compbl(&key));
%if %length(&var) ne 0 %then %do;
%let var=%sysfunc(compbl(&var));
%end;
if 0 then set &master(keep= &key &var);
%let name  = &sysindex;
retain _N_&name 1;
if _N_&name = 1 then do;
%if %length(&wh) ne 0 %then %do;
rc&name.=dosubl("proc sql noprint;
create view h&name.(label=%unquote(%bquote('master=&master'))) as select * from &master where &wh;
quit;");
%end;
%let qkey  = %sysfunc( tranwrd( %str("&key") , %str( ) , %str(",") ) );
%let keynum = %sysfunc( count( &key, %str ( ) ));
%if %length(&wh) ne 0 %then %do;
declare hash h&name.(dataset:"h&name.(keep= &key &var)" ,  duplicate:'E');
%end;
%else %do;
declare hash h&name.(dataset:"&master.(keep= &key &var)" ,  duplicate:'E');
%end;
h&name..definekey(&qkey);
%if %length(&var) ne 0 %then %do;
h&name..definedata(all:'Y');
%end;
h&name..definedone();
_N_&name = 0 ;
%put &=dropviewflg;
%if %length(&wh) ne 0 and %upcase(&dropviewflg) eq Y %then %do;
call execute("proc sql noprint;
drop view h&name. ;
quit;");
drop  rc&name.;
%end;
end;
drop _N_&name ;
if h&name..find() ne  0 then do;
%if %length(&var) ne 0 %then %do;
call missing(of &var );
%end;
%if %upcase( &warn )= Y %then %do;
if cmiss(of &key) ne &keynum +1 then putlog "WARNING:not exist master" +2 (&key.) (=);
%end;
end;
%mend kvlookup;
