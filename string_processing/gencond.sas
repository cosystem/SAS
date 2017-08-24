********************************************************************;
* macro to generate a list of logic condition which can be used in 
* proc sql closure from a list of strings;
********************************************************************;
%macro gencond(collist=, colprefix=, valuelist=, valprefix=, symbol=, logic=, str=);
	%local newitemlist; /* required to avoid recursive defination for newitemlist */
	%let i=1;
	%let j=1;
	%let colnumber = %sysfunc(countw(&collist.));
	%let valuenumber = %sysfunc(countw(&valuelist.));

	%if %length(&valprefix.) > 0 and &str. = T %then %do;
		%put ERROR: String values should not have prefix!;
		%return;
	%end;
	%else %if %length(&valprefix.) > 0 %then %do;
		%let valprefix = &valprefix..;
	%end;

	%if %length(&colprefix.) > 0 %then %do;
		%let colprefix = &colprefix..;
	%end;

	%do %while (%scan(&valuelist., &i.) ne );
		%let value&i = %scan(&valuelist., &i.);
		%if &str. = T %then %let value&i = "&&value&i";
		%let i = %eval(&i. + 1);
	%end;
	%let dim = %eval(&i. - 1);

	%if &colnumber. = 1 %then %do;
		%do i=1 %to &valuenumber.;
			%if &i.=&valuenumber. %then %let logicword = ;
			%else %let logicword = &logic.;
			%let newitemlist = &newitemlist. &colprefix.&collist. &symbol. &valprefix.&&value&i &logicword.;
		%end;
	%end;
	%else %if &colnumber. =  &valuenumber. %then %do;
		%do %while (%scan(&collist., &j.) ne );
			%let column&j = %scan(&collist., &j.);
			%let j = %eval(&j. + 1);
		%end;

		%do i=1 %to &valuenumber.;
			%if &i.=&valuenumber. %then %let logicword = ;
			%else %let logicword = &logic.;
			%let newitemlist = &newitemlist. &colprefix.&&column&i &symbol. &valprefix.&&value&i &logicword.;
		%end;
	%end;
	%else %do;
		%put ERROR: The number of columns (&colnumber.) and values (&valuenumber.) are not compatible; 
		%return;
	%end;
	&newitemlist.
%mend gencond;
