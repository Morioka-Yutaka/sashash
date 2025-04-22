/*** HELP START ***//*

* MACRO NAME: keycheck
*
* PURPOSE:
*   Checks the existence of specified key(s) in a master dataset using
*   a hash object. Optionally subsets master data using conditions and
*   returns results as categorical (YN) or numerical indicators.
*
* PARAMETERS:
*   master     : (Required) Name of the master dataset to check against.
*   key        : (Required) Space-separated list of key variables to check.
*   wh         : (Optional) SQL WHERE clause condition to subset the master
*                dataset before loading into hash table. Default is none.
*   fl         : (Required) Name of the output variable indicating existence.
*   cat        : (Optional) Controls output format of existence indicator:
*                   - 'YN' (default): Returns 'Y' if key exists, 'N' otherwise.
*                   - 'NUM': Returns 1 if key exists, 0 otherwise.
*   dropviewflg: (Optional) Y/N flag. If 'Y', drops temporary SQL view created
*                when the 'wh' parameter is used. Default is 'Y'.
*
* USAGE:
*   %keycheck(master=sashelp.class,
*             key=Name,
*             wh=Age >= 15,
*             fl=exist_flag,
*             cat=YN,
*             dropviewflg=Y);
*
* NOTES:
*   - This macro creates a hash object on the first record processed.
*   - Efficient for repeated existence checks within data steps.
*   - The macro automatically cleans up temporary views unless explicitly
*     disabled by setting dropviewflg=N.

*//*** HELP END ***/

%macro keycheck(master=, wh=, key=,fl=,cat=YN,dropviewflg=Y);
%let name  = &sysindex;
%let qkey  = %sysfunc( tranwrd( %str("&key") , %str( ) , %str(",") ) );
if 0 then set &master(keep= &key);
if _N_=1 then do;

   %if %length(&wh) ne 0 %then %do;
    rc&name.=dosubl("proc sql noprint;
                        create view h&name.(label=%unquote(%bquote('master=&master'))) as
                        select * from &master
                         where &wh;
                    quit;");
    %end;

   %if %length(&wh) ne 0 %then %do;
    declare hash h&name.(dataset:"h&name.(keep= &key)" ,  multidata:'Y');
    %end;
    %else %do;
    declare hash h&name.(dataset:"&master(keep= &key)", multidata:'Y');
    %end;
  h&name..definekey(&qkey);
  h&name..definedone();

  %if %length(&wh) ne 0 and %upcase(&dropviewflg) eq Y %then %do;
    call execute("proc sql noprint;
                        drop view h&name. ;
                    quit;");
%end;

end;
&fl = ifc(h&name..check()=0,"Y","N");

%if &cat=Y %then %do; if &fl="N" then &fl=""; %end;

%if &cat=NUM %then %do; 
  if &fl ="Y" then &fl.n=1;
  if &fl ="N" then &fl.n=0;
%end;

%mend keycheck;
