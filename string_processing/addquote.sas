**************************************************************************;
* macro to add quotation marks around sting in a list;
**************************************************************************;

%macro addquote(list=, comma=N);
	%local i item wrappered_list commasign;
	%if &comma. = Y %then %let commasign = ,;
	%else %let commasign=;
	%let i=1;
	%do %while (%length(%scan(&list., &i., ' ')) ne 0);
		%let item = %scan(&list., &i., ' ');
		%if &i. ne 1 %then %let sep =&commasign.; %else %let sep =;
		%let wrappered_list = &wrappered_list.&sep. "&item.";
		%let i = %eval(&i. + 1);
	%end;
	&wrappered_list.
%mend addquote;
