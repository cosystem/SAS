************************************************************************;
*
* convert a list of string to a list of quoted string seperated by comma;
* %list2quotestr(a b c d e) => "a", "b", "c", "d", "e"
* Author: Guanya Peng
*
************************************************************************;

%macro list2quotestr(inlist);
	%local newitemlist; /* required to avoid recursive defination for newitemlist */
	%let i=1;
	%let i=1;
	%do %while (%scan(&inlist, &i) ne );
		%let item&i = %scan(&inlist, &i);
		%let i = %eval(&i + 1);
	%end;
	%let dim = %eval(&i - 1);
	%do i = 1 % to &dim;
		%let newitemlist = &newitemlist. "&&item&i";
	%end;
	%sysfunc(tranwrd(&newitemlist, %str( ),%str(, )))
%mend list2quotestr;
