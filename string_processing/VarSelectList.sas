**********************************************************;
* macro to generate variable selection lines for proc sql; 
* based on iteration number and column number of table;
*
**********************************************************;
%macro VarSelectList(iternum, colnum, indexsymbol);
	%local newvar;
	%let addnum = %eval((&iternum. - 1) * &colnum.);
	%do i=1 %to &colnum.;
		%let j = %eval(&i. + &colnum. + &addnum.);
		%if %length(&newvar.) = 0 %then %let delimiter = ;
		%else %let delimiter = ,;
		%let newvar = &newvar.&delimiter. &indexsymbol..VAR&i. as VAR&j.;
	%end;
	&newvar.
%mend VarSelectList;
