*************************************************;
* count the number of row or columns in a dataset;
*************************************************;
%macro count(dt=, what=);
	%if &what. = row %then %let tocount = NOBS;
	%else %if &what. = col %then %let tocount = NVARS;
	%else %do;
		%put EORROR: Invalid parameter what=&what.;
		%return;
	%end;
	
	%let dsid = %sysfunc(open(&dt, IN));
	%if &dsid %then %do;
		%let number=%sysfunc(attrn(&dsid, &tocount.));
		%let rc = %sysfunc(close(&dsid));
	%end;
	%else
		%put Open for data set &dt failed - %sysfunc(sysmsg());
	&number.
%mend count;
