/*** HELP START ***//*

kvlookup test

*//*** HELP END ***/


data test1;
 set mylib1.biggerDataset;
 %kvlookup(master = mylib1.smallDataset, key = key1 key2, var = var1 var2);
run;

data test2;
 set mylib1.biggerDataset;
 %kvlookup(master = mylib1.smallDataset, wh = %nrbquote(key1 < 5),  key = key1 key2, var = var: );
run;
