********************************;
*								;
* extract zip file				;
*								;
********************************;

* example to use the macro:;
* %extract(infile=&zipfile., outpath=&outdir., subfolder=SAS, filetype=csv);
* %extract(infile=&zipfile., outpath=&outdir., subfolder=SAS);
* %extract(infile=&zipfile., outpath=&outdir., filetype=xml);

%macro extract(infile=, outpath=, subfolder=, filetype=);
	%local __Macro_Err;
	%let __Macro_Err=0;
	%if (%length(&infile.) = 0) %then %do;
		%put ERROR: Parameter for input file is empty;
		%let __Macro_Err = 1;
	%end;
	%if (%length(&outpath.) = 0) %then %do;
		%put ERROR: Parameter for output directory is empty;
		%let __Macro_Err = 1;
	%end;
	%if (%length(&subfolder.)) %then %do;
		%let path = &subfolder\;
	%end;
	%else %do;
		%let path =;
	%end;
	%if (%length(&filetype.)) %then %do;
		%let files = *.&filetype;
	%end;
	%else %do;
		%let files =;
	%end;
	%let filters = &path.&files.;
	
	%if &__Macro_Err. %then %do;
    data _null_;
       abort 3;
    run;
	%end;
	systask command "C:\""Program Files""\7-Zip\7z.exe x ""&infile"" -aoa -o""&outpath"" &filters";
%mend extract;
