/* sashash :: %kduppchk()  -- duplicate-key detector via SAS hash object.
 *
 * Source: sashash/06_macros/kduppchk.sas (Yutaka Morioka, MIT-licensed).
 *
 * %kduppchk(key) registers a hash object on _N_=1 with the listed keys,
 * then on each subsequent row checks whether the current key combination
 * is already in the hash. A WARNING is emitted and dupchk=1 is set on
 * hits; non-missing fresh keys are added.
 *
 *     %macro kduppchk(key);
 *       %local name qkey;
 *       if _N_=1 then do;
 *         %let name = &sysindex;
 *         %let qkey = %sysfunc( tranwrd( %str("&key") , %str( ) , %str(",") ) );
 *         declare hash h&name();
 *         h&name..definekey(&qkey);
 *         h&name..definedone();
 *       end;
 *       if h&name..check() = 0
 *       then do;
 *         put "WARNING:Dupp" +2 (&key.) (=);
 *         dupchk=1;
 *       end;
 *       else if cmiss(of &key) = 0 then do;
 *         h&name..add();
 *       end;
 *     %mend ;
 *
 * The bundle here inlines the same logic so the duplicate-detection
 * behaviour can be inspected without needing the SAS Packages
 * Framework loader. The composite key (subjid, visit) below would
 * normally be passed as `%kduppchk(subjid visit);` from a caller's
 * data step.
 */

data input_data;
   length subjid $4 visit $4;
   input subjid $ visit $;
   datalines;
S001 V1
S001 V2
S002 V1
S001 V1
S002 V2
S003 V1
S003 V1
S004 V1
;
run;

/* Equivalent of: data check; set input_data; %kduppchk(subjid visit); run; */
data check;
   set input_data;
   if _N_=1 then do;
      declare hash h();
      h.definekey("subjid", "visit");
      h.definedone();
   end;
   if h.check() = 0 then do;
      put "WARNING:Dupp" +2 subjid= visit=;
      dupchk = 1;
   end;
   else if cmiss(of subjid visit) = 0 then do;
      h.add();
   end;
run;

proc print data=check label;
   title "%kduppchk(subjid visit) -- duplicate flag per row";
   var subjid visit dupchk;
run;
