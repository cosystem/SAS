********************************************************************;
* macro to generate a list with modified string;
* out=var: output is same as input list;
* out=both: output contains both input list and the modified list;
* out=mod: output is the modified list;
********************************************************************;
%macro mod(list=, out=both, suffix=D, prefix=) /minoperator mindelimiter=',';
    %let i = 1;
    %do %while (%scan(&list., &i.) ne );
        %if &out. in (both,var) %then %do;
            %scan(&list., &i.) 
        %end;
        %if &out. in (both,mod) %then %do;
            &prefix.%scan(&list., &i.)&suffix.
        %end;
        %let i = %eval(&i+1);
    %end;
%mend;
