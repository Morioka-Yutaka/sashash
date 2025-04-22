/*** HELP START ***//*

keycheck test

*//*** HELP END ***/


data test3;
 set mylib1.smallDataset;
 %keycheck(master = mylib1.biggerDataset, key = key2 , fl =key2FL);
run;
