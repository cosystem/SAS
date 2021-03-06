* *********************************************;
* convert character vars to numeric;
* *********************************************;
%macro char2num(dt=, vars=);
	data &dt.;
		set &dt.;
		%do i=1 %to %sysfunc(countw(&vars.));
			%let var = %scan(&vars., &i.);
			call symput("label_&var.", vlabel(&var.));
		%end;
	run;

	data &dt.;
		set &dt. end = eof;; 
		%do i=1 %to %sysfunc(countw(&vars.));
			%let var = %scan(&vars., &i.);
			if &var. = "N/A" then &var._tmp=.;
			else &var._tmp=input(&var., 8.);
			label &var._tmp="&&label_&var";
			drop &var.;
			rename &var._tmp=&var.;
		%end;
	run;
%mend char2num;