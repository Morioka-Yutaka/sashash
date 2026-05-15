/* sashash :: %keycheck()  -- existence check via SAS hash object.
 *
 * Source: sashash/06_macros/keycheck.sas (Yutaka Morioka, MIT-licensed).
 *
 * %keycheck(master=, key=, fl=, cat=YN) loads a master dataset into a
 * hash table on _N_=1, then for each incoming row sets an output flag
 * (Y/N or 1/0) indicating whether the row's key is present in the
 * master. Optionally a SQL WHERE clause subsets the master first.
 *
 *     %macro keycheck(master=, wh=, key=, fl=, cat=YN, dropviewflg=Y);
 *       %let name  = &sysindex;
 *       %let qkey  = %sysfunc( tranwrd( %str("&key") , %str( ) , %str(",") ) );
 *       if 0 then set &master(keep= &key);
 *       if _N_=1 then do;
 *          declare hash h&name.(dataset:"&master(keep= &key)", multidata:'Y');
 *          h&name..definekey(&qkey);
 *          h&name..definedone();
 *       end;
 *       &fl = ifc(h&name..check()=0,"Y","N");
 *     %mend keycheck;
 *
 * The bundle here inlines the same hash-existence pattern. A roster of
 * subjects with non-missing AGE acts as the master; a sample of inbound
 * records is then flagged exist_flag='Y'/'N' according to whether the
 * subject NAME appears in the master.
 */

data master;
   length name $20;
   input name $ age;
   datalines;
Alice 25
Bob 30
Carol 35
Dave 40
Eve 28
;
run;

data inbound;
   length name $20 visit $4;
   input name $ visit $;
   datalines;
Alice V1
Frank V1
Bob V1
Grace V2
Eve V2
;
run;

/* Equivalent of:
 *   data inbound_checked;
 *     set inbound;
 *     %keycheck(master=master, key=name, fl=exist_flag, cat=YN);
 *   run;
 */
data inbound_checked;
   if 0 then set master(keep=name);
   set inbound;
   length exist_flag $1;
   if _N_=1 then do;
      declare hash h(dataset:"master(keep=name)", multidata:'Y');
      h.definekey("name");
      h.definedone();
   end;
   exist_flag = ifc(h.check()=0, "Y", "N");
run;

proc print data=inbound_checked label;
   title "%keycheck(master=master, key=name, fl=exist_flag, cat=YN)";
   var name visit exist_flag;
run;
