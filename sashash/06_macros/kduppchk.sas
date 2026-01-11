/*** HELP START ***//*

Program   : kduppchk.sas
Macro     : %kduppchk
Purpose   : General-purpose duplicate key checker using SAS hash objects.
Description:
- This macro checks for duplicate key combinations in a DATA step using hash objects.
- On the first call (_N_ = 1), it initializes a hash object with the specified keys.
- If a duplicate key combination is found (i.e., already exists in the hash),
it outputs a WARNING and sets the flag variable `dupchk = 1`.
- If all key variables are non-missing and not yet in the hash, the key is added.
Parameters:
key  : One or more key variables used to detect duplicates (space-delimited).
Output:
- Writes a WARNING message to the log when duplicates are found.
- Sets a flag variable `dupchk = 1` for duplicated records.
Usage Example:
data check;
set input_data;
%kduppchk(subjid visit);
run;
Notes:
- Can be used inline within a DATA step.
- Records with missing key values are skipped from hash addition.
Author    : Yutaka Morioka
licence : MIT

*//*** HELP END ***/

%macro kduppchk(key);
%local name qkey;
if _N_=1 then do;
%let name = &sysindex;
%let qkey = %sysfunc( tranwrd( %str("&key") , %str( ) , %str(",") ) );
declare hash h&name();
h&name..definekey(&qkey);
h&name..definedone();
end;
if h&name..check() = 0
then do;
put "WARNING:Dupp" +2 (&key.) (=);
dupchk=1;
end;
else if cmiss(of &key) = 0 then do;
h&name..add();
end;
%mend ;
