**********************************************
*
* extract .csv file and convert to .sas files
*
**********************************************;

%macro get_sas_files(infile=, outpath=, subfolder=SAS, filetype=);
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

	filename out pipe "dir ""&outpath.\&subfolder.\*.sas"" /B | findstr .sas$";

	data _temp;
		length file $200. ;
		infile out length=linelen; ;
		input file $Varying500. linelen;
	run;

	data _null_;
		set _temp;
		call symput("sasfile", file);
	run;
	%sysexec cd &outpath.\&subfolder.;
	%include "&outpath.\&subfolder.\&sasfile";
	systask command "move /y &outpath.\&subfolder.\*.sas .."; /* overwrite automatically */
	%sysexec cd &outpath.;
	
	systask command "del &sasfile.";
	systask command "rd /s /q &outpath.\&subfolder.";
%mend get_sas_files;
