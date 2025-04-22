/*** HELP START ***//*

[Sample data] This is a small dataset.

*//*** HELP END ***/

data mylib1.smallDataset;
	do key1 = 1, 3, 10;
    	do key2 = "A", "C", "D";
		    var1 = monotonic();
        var2 = cats(key1,key2);
    	output;
    end;
	end;
run;
