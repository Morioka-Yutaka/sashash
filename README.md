# sashash
The sashash package provides powerful and efficient hash-based lookup and validation tools specifically designed for SAS programming. Leveraging the robust capabilities of SAS hash objects, this package enables rapid and dynamic key-based data retrieval and existence checking directly within a single data step. This significantly reduces the need for separate sort and merge steps, streamlining workflows and enhancing performance.

<img width="300" height="300" alt="Image" src="https://github.com/user-attachments/assets/31ac7fe2-af78-4b9c-998f-196db9d6f6ac" />


# %kvlookup()
Enables efficient and dynamic retrieval of variables from a specified master dataset based on provided keys, directly within a single data step without separate sorting or merging.<br>

PARAMETERS:  
~~~text
master     : (Required) Name of the master dataset to lookup from.
key        : (Required) Space-separated list of key variables for the lookup.
var        : (Required) Space-separated list of variables to retrieve from the master dataset. Default is none.
wh         : (Optional) SQL WHERE clause condition to subset the master dataset before loading into hash table. Default is none.
warn       : (Optional) Y/N flag. If 'Y', issues a warning in the log when the lookup key is not found. Default is 'N'.
dropviewflg: (Optional) Y/N flag. If 'Y', drops temporary SQL view created when the 'wh' parameter is used. Default is 'Y'.
~~~
Usage Example:<br>
~~~sas
data a;
set b;  
%kvlookup(master=sashelp.class,
          key=Name,         
          var=Age Sex,
          wh=　%nrbquote(Age > 12),
          warn=Y,
          dropviewflg=Y);
run;
~~~

# %keycheck()
Dynamically validates the existence of keys within a master dataset directly within a single data step. Ideal for rapid data integrity checks and immediate flagging of key existence or non-existence.<br>

PARAMETERS:  
~~~text
master     : (Required) Name of the master dataset to check against.
key        : (Required) Space-separated list of key variables to check.
wh         : (Optional) SQL WHERE clause condition to subset the master dataset before loading into hash table. Default is none.
fl         : (Required) Name of the output variable indicating existence.
cat        : (Optional) Controls output format of existence indicator:
            - 'YN' (default): Returns 'Y' if key exists, 'N' otherwise.
            - 'NUM': Returns 1 if key exists, 0 otherwise.
dropviewflg: (Optional) Y/N flag. If 'Y', drops temporary SQL view created when the 'wh' parameter is used. Default is 'Y'.
~~~

Usage Example:<br>
~~~sas
data a;
set b;
%keycheck(master=sashelp.class,
          key=Name,
          wh= %nrbquote(Age >= 15),
          fl=exist_flag,
          cat=YN,
          dropviewflg=Y);
run;
~~~

# %kduppchk()
General-purpose duplicate key checker using SAS hash objects. 

Parameters:
~~~text  
  key  : One or more key variables used to detect duplicates (space-delimited).
~~~
Usage Example:<br>

~~~sas 
data a;
set sashelp.class;
%kduppchk(AGE SEX);
%kduppchk(NAME);
run;
~~~
<img width="264" height="129" alt="Image" src="https://github.com/user-attachments/assets/c9db88e8-558c-4857-95e8-1b8963e608e0" />

# version history
0.0.2(23July2025): first stable version  
0.0.1(22April2025): Initial version

## What is SAS Packages?

The package is built on top of **SAS Packages Framework(SPF)** developed by Bartosz Jablonski.

For more information about the framework, see [SAS Packages Framework](https://github.com/yabwon/SAS_PACKAGES).

You can also find more SAS Packages (SASPacs) in the [SAS Packages Archive(SASPAC)](https://github.com/SASPAC).

## How to use SAS Packages? (quick start)

### 1. Set-up SAS Packages Framework

First, create a directory for your packages and assign a `packages` fileref to it.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
filename packages "\path\to\your\packages";
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Secondly, enable the SAS Packages Framework.
(If you don't have SAS Packages Framework installed, follow the instruction in 
[SPF documentation](https://github.com/yabwon/SAS_PACKAGES/tree/main/SPF/Documentation) 
to install SAS Packages Framework.)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%include packages(SPFinit.sas)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### 2. Install SAS package

Install SAS package you want to use with the SPF's `%installPackage()` macro.

- For packages located in **SAS Packages Archive(SASPAC)** run:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  %installPackage(packageName)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- For packages located in **PharmaForest** run:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  %installPackage(packageName, mirror=PharmaForest)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- For packages located at some network location run:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  %installPackage(packageName, sourcePath=https://some/internet/location/for/packages)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  (e.g. `%installPackage(ABC, sourcePath=https://github.com/SomeRepo/ABC/raw/main/)`)


### 3. Load SAS package

Load SAS package you want to use with the SPF's `%loadPackage()` macro.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%loadPackage(packageName)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### Enjoy!
