/* sashash :: %kvlookup()  -- hash-based variable retrieval.
 *
 * Source: sashash/06_macros/kvlookup.sas (Yutaka Morioka, MIT-licensed).
 *
 * %kvlookup(master=, key=, var=, warn=N) loads a master dataset into a
 * hash table on _N_=1 with definekey() bound to the listed key columns
 * and definedata() bound to the variables to retrieve. Missing keys
 * leave the looked-up variables missing (and emit a WARNING if warn=Y).
 *
 *     %macro kvlookup(master=, key=, var=, wh=, warn=N, dropviewflg=Y);
 *       if 0 then set &master(keep= &key &var);
 *       %let name  = &sysindex;
 *       retain _N_&name 1;
 *       if _N_&name = 1 then do;
 *         declare hash h&name.(dataset:"&master.(keep= &key &var)" , duplicate:'E');
 *         h&name..definekey(&qkey);
 *         h&name..definedata(all:'Y');
 *         h&name..definedone();
 *         _N_&name = 0;
 *       end;
 *       if h&name..find() ne 0 then do;
 *         call missing(of &var );
 *         %if %upcase(&warn) = Y %then
 *           if cmiss(of &key) ne &keynum +1 then putlog "WARNING:not exist master" +2 (&key.) (=);
 *       end;
 *     %mend kvlookup;
 *
 * The bundle here inlines the same hash-find pattern. A reference table
 * of subject metadata (age, height_cm) is loaded into a hash keyed by
 * name; a stream of visit records is decorated with the matching
 * lookup fields. The unknown name "Frank" yields missing age/height
 * and triggers the macro's call missing(of &var) branch.
 */

data demographics;
   length name $20;
   input name $ age height_cm;
   datalines;
Alice 25 165
Bob 30 178
Carol 35 160
Dave 40 182
Eve 28 168
;
run;

data visits;
   length name $20 visit $4;
   input name $ visit $;
   datalines;
Alice V1
Bob V1
Carol V2
Frank V1
Eve V2
;
run;

/* Equivalent of:
 *   data visits_enriched;
 *     set visits;
 *     %kvlookup(master=demographics, key=name, var=age height_cm, warn=Y);
 *   run;
 */
data visits_enriched;
   if 0 then set demographics(keep=name age height_cm);
   set visits;
   if _N_=1 then do;
      declare hash h(dataset:"demographics(keep=name age height_cm)", duplicate:'E');
      h.definekey("name");
      h.definedata("age", "height_cm");
      h.definedone();
   end;
   if h.find() ne 0 then do;
      call missing(age, height_cm);
      if cmiss(name) = 0 then put "WARNING:not exist master" +2 name=;
   end;
run;

proc print data=visits_enriched label;
   title "%kvlookup(master=demographics, key=name, var=age height_cm, warn=Y)";
   var name visit age height_cm;
run;
