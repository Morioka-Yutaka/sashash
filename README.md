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

# version history
0.0.1(22April2025): Initial version

# What is SAS Packages?
sashash is built on top of **SAS Packages framework(SPF)** created by Bartosz Jablonski.<br>
For more on SAS Packages framework, see [SASPAC](https://github.com/yabwon/SAS_PACKAGES).<br>
You can also find more SAS Packages(SASPAC) in [GitHub](https://github.com/SASPAC)<br>


# How to use SASPACer? (quick start)
Create directory for your packages and assign a fileref to it.
~~~sas      
filename packages "\path\to\your\packages";
~~~
Enable the SAS Packages Framework (if you have not done it yet):

~~~sas      
%include packages(SPFinit.sas)
~~~
(If you don't have SAS Packages Framework installed follow the instruction.)

When you have SAS Packages Framework enabled, run the following to install and load the package:


~~~sas      
/* Install and load SASPACer */
%installPackage(SASPACer, sourcePath=https://github.com/Nakaya-Ryo/SASPACer/raw/main/)   /* Install SASPACer to your place */
%loadPackage(SASPACer)
/* Enjoy SASPACer😄 */
%ex2pac(
  excel_file=C:\Temp\simple_example.xlsx,
  package_location=C:\Temp\SAS_PACKAGES\packages,
  complete_generation=Y
)
~~~
You can learn from the following training materials by Bartosz Jablonski for source files and folders structure of SAS packages.<br>
[My first SAS Package -a How To](https://github.com/yabwon/SAS_PACKAGES/blob/main/SPF/Documentation/SAS(r)%20packages%20-%20the%20way%20to%20share%20(a%20how%20to)-%20Paper%204725-2020%20-%20extended.pdf).<br>
[SAS Packages - The Way To Share (a How To)](https://github.com/yabwon/SAS_PACKAGES/blob/main/SPF/Documentation/SAS(r)%20packages%20-%20the%20way%20to%20share%20(a%20how%20to)-%20Paper%204725-2020%20-%20extended.pdf)

