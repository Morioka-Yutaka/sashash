# sashash
The sashash package provides powerful and efficient hash-based lookup and validation tools specifically designed for SAS programming. Leveraging the robust capabilities of SAS hash objects, this package enables rapid and dynamic key-based data retrieval and existence checking directly within a single data step. This significantly reduces the need for separate sort and merge steps, streamlining workflows and enhancing performance.

![sashsash](./hashsas_small.png)  


# %kvlookup()
Enables efficient and dynamic retrieval of variables from a specified master dataset based on provided keys, directly within a single data step without separate sorting or merging.<br>
Usage Example:<br>

~~~sas  
%kvlookup(master=sashelp.class,
          key=Name,         
          var=Age Sex,
          wh=　%nrbquote(Age > 12),
          warn=Y,
          dropviewflg=Y);
~~~

# %keycheck()
Dynamically validates the existence of keys within a master dataset directly within a single data step. Ideal for rapid data integrity checks and immediate flagging of key existence or non-existence.<br>
Usage Example:<br>

~~~sas  
%keycheck(master=sashelp.class,
          key=Name,
          wh= %nrbquote(Age >= 15),
          fl=exist_flag,
          cat=YN,
          dropviewflg=Y);
~~~

# %kduppchk()
General-purpose duplicate key checker using SAS hash objects.  
Parameters:
~~~text  
  key  : One or more key variables used to detect duplicates (space-delimited).
~~~

~~~sas 
data a;
set sashelp.class;
%kduppchk(AGE SEX);
%kduppchk(NAME);
run;
~~~

# version history
0.0.2(23July2025): first stable version
0.0.1(22April2025): Initial version

## What is SAS Packages?  
The package is built on top of **SAS Packages framework(SPF)** developed by Bartosz Jablonski.
For more information about SAS Packages framework, see [SAS_PACKAGES](https://github.com/yabwon/SAS_PACKAGES).  
You can also find more SAS Packages(SASPACs) in [SASPAC](https://github.com/SASPAC).

## How to use SAS Packages? (quick start)
### 1. Set-up SPF(SAS Packages Framework)
Firstly, create directory for your packages and assign a fileref to it.
~~~sas      
filename packages "\path\to\your\packages";
~~~
Secondly, enable the SAS Packages Framework.  
(If you don't have SAS Packages Framework installed, follow the instruction in [SPF documentation](https://github.com/yabwon/SAS_PACKAGES/tree/main/SPF/Documentation) to install SAS Packages Framework.)  
~~~sas      
%include packages(SPFinit.sas)
~~~  
### 2. Install SAS package  
Install SAS package you want to use using %installPackage() in SPFinit.sas.
~~~sas      
%installPackage(packagename, sourcePath=\github\path\for\packagename)
~~~
(e.g. %installPackage(ABC, sourcePath=https://github.com/XXXXX/ABC/raw/main/))  
### 3. Load SAS package  
Load SAS package you want to use using %loadPackage() in SPFinit.sas.
~~~sas      
%loadPackage(packagename)
~~~
### Enjoy😁
