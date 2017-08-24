*************************************************;
* convert list fragments to a new formatted list
* which can be used in other programming closures;
*************************************************;

%macro convertlist(inlist=, delimiter=, prefix=, quoted=F);
	%local newitemlist; /* required to avoid recursive defination for newitemlist */

	%if %length(&delimiter) = 0 %then %let delimiter = " ";
	%else %let delimiter = "&delimiter";

	%let i=1;
	%do %while (%length(%scan(&inlist., &i., &delimiter)) ne 0);
		%let item&i = %scan(&inlist., &i., &delimiter);
		%let i = %eval(&i. + 1);
	%end;
	%let dim = %eval(&i - 1);

	%if &quoted. = T %then %do;
		%let newitemlist = "&item1";

		%do i = 2 %to &dim.;
			%let newitemlist = &newitemlist., "&&item&i";
		%end;
	%end;
	%else %if &quoted. = F and %length(&prefix)=0 %then %do;
		%let newitemlist = &item1;

		%do i = 2 %to &dim.;
			%let newitemlist = &newitemlist., &&item&i;
		%end;
	%end;
	%else %if &quoted. = F and %length(&prefix) ne 0 %then %do;
		%let newitemlist = &prefix..&item1;

		%do i = 2 %to &dim.;
			%let newitemlist = &newitemlist., &prefix..&&item&i;
		%end;
	%end;
	%else %do;
		%put ERROR: quoted flag can be only F or T!!!;
	%end; 
	&newitemlist.
%mend convertlist;
