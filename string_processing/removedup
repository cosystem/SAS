*****************************************************************;
* macro to remove duplicate strings from a list of strings		   ;
*****************************************************************;

%macro removedup(listin, dlmin) / minoperator mindelimiter=',';
	%local i item outlist outdlmin processed mydlmin;

	%if %length(&dlmin.) = 0 %then %let mydlmin = " ";
	%else %let mydlmin = &dlmin.;

	%let i=1;
	%let processed = "";
	%do %while (%scan(&listin., &i., %str(&mydlmin.)) ne );
   		%let item = %scan(&listin., &i., %str(&mydlmin.));

		%if &i. = 1 or %length(&dlmin.) = 0 %then %let outdlmin =;
		%else %let outdlmin = &mydlmin.;

		%if not("&item." in &processed.) %then
       		%let outlist = &outlist. &outdlmin. "&item.";

		%let processed = &processed., &item.;
		%let i = %eval(&i + 1);
	%end;
	&outlist.
%mend removedup;
