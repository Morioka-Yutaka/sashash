/*** HELP START ***//*

[Sample data]  This is a bigger dataset.

*//*** HELP END ***/

data mylib1.biggerDataset;
do i = 1 to 1000;
	do key1 = 1, 2, 3, 5,10;
    	do key2 = "A", "B", "D";
    	output;
    end;
	end;
end;
run;
