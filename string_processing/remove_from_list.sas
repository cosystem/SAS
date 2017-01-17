****************************************;
* macro to remove word from list		;
****************************************;

%macro remove(in=, dlmin=, toremove=) / minoperator;
	%if %length(&dlmin.) = 0 %then %let dlmin = ' ';
	%local i item outlist;
	%let i=1;
	%do %while (%scan(&in., &i., %str(&dlmin.)) ne );
   		%let item = %scan(&in., &i., %str(&dlmin.));
		%if not(&item. in &toremove.) %then 
       		%let outlist = &outlist. &item.;
		%let i = %eval(&i + 1);
	%end;
	&outlist.
%mend remove;
