**************************************************************************;
* macro to convert all character values in dataset to upper case or lower case;
**************************************************************************;
%macro ConvertChar(dt=, tocase=);
	%if &tocase. = up %then %let newcase = upcase;
	%else %if &tocase. = low %then %let newcase = lowcase;
	%else %do;
		%put ERROR: Invalid parameter tocase = &tocase.;
		%return;
	%end;
	data &dt.;
		set &dt.;
		array all_char[*] _character_;
		do i=1 to dim(all_char);
		    all_char[i]=&newcase.(all_char[i]);
	    end;
	    drop i;
	run;
%mend ConvertChar;
