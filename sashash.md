﻿# Documentation for the `sashash` package.
  
----------------------------------------------------------------
 
 *sashash--Provides various macros related to Key-Value processing using SAS HASH objects.* 
  
----------------------------------------------------------------
 
### Version information:
  
- Package: sashash
- Version: 0.0.2
- Generated: 2025-07-23T23:28:37
- Author(s): Yutaka Morioka(sasyupi@gmail.com)
- Maintainer(s): Yutaka Morioka(sasyupi@gmail.com)
- License: MIT
- File SHA256: `F*17544039E9833FEDCDCCF68748A50B5E7BE14079244621E24B2444BAA5477374` for this version
- Content SHA256: `C*AC4308D2C6E96EBC1020FBCB1FDD69F7823DF6A250FE12EBF02EF6F762410948` for this version
  
---
 
# The `sashash` package, version: `0.0.2`;
  
---
 
Description: The sashash package provides powerful and efficient hash-based lookup and validation tools specifically designed for SAS programming. Leveraging the robust capabilities of SAS hash objects, this package enables rapid and dynamic key-based data retrieval and existence checking directly within a single data step. This significantly reduces the need for separate sort and merge steps, streamlining workflows and enhancing performance.
Concept: The core strength of the sashash package is its ability to simplify and accelerate data processing tasks by eliminating repetitive data sort and merge operations. Users can perform multiple data joins and validations dynamically within a single SAS data step, using keys generated on-the-fly during processing, thereby dramatically improving both flexibility and speed.

  
---
 
  
---
 
Required SAS Components: 
  - Base SAS Software
  
---
 
 
--------------------------------------------------------------------
 
*SAS package generated by SAS Package Framework, version `20241207`*
 
--------------------------------------------------------------------
 
# The `sashash` package content
The `sashash` package consists of the following content:
 
1. [`%kduppchk()` macro ](#kduppchk-macros-1 )
2. [`%keycheck()` macro ](#keycheck-macros-2 )
3. [`%kvlookup()` macro ](#kvlookup-macros-3 )
  
 
4. [License note](#license)
  
---
 
## `%kduppchk()` macro <a name="kduppchk-macros-1"></a> ######

Program   : kduppchk.sas
Macro     : %kduppchk
Purpose   : General-purpose duplicate key checker using SAS hash objects.
Description:
  - This macro checks for duplicate key combinations in a DATA step using hash objects.
  - On the first call (_N_ = 1), it initializes a hash object with the specified keys.
  - If a duplicate key combination is found (i.e., already exists in the hash), 
    it outputs a WARNING and sets the flag variable `dupchk = 1`.
  - If all key variables are non-missing and not yet in the hash, the key is added.

Parameters:
  key  : One or more key variables used to detect duplicates (space-delimited).

Output:
  - Writes a WARNING message to the log when duplicates are found.
  - Sets a flag variable `dupchk = 1` for duplicated records.

Usage Example:
  data check;
    set input_data;
    %kduppchk(subjid visit);
  run;

Notes:
  - Can be used inline within a DATA step.
  - Records with missing key values are skipped from hash addition.

Author    : Yutaka Morioka
licence : MIT

  
---
 
## `%keycheck()` macro <a name="keycheck-macros-2"></a> ######

* MACRO NAME: keycheck

*

* PURPOSE:

*   Checks the existence of specified key(s) in a master dataset using

*   a hash object. Optionally subsets master data using conditions and

*   returns results as categorical (YN) or numerical indicators.

*

* PARAMETERS:

*   master     : (Required) Name of the master dataset to check against.

*   key        : (Required) Space-separated list of key variables to check.

*   wh         : (Optional) SQL WHERE clause condition to subset the master

*                dataset before loading into hash table. Default is none.

*   fl         : (Required) Name of the output variable indicating existence.

*   cat        : (Optional) Controls output format of existence indicator:

*                   - 'YN' (default): Returns 'Y' if key exists, 'N' otherwise.

*                   - 'NUM': Returns 1 if key exists, 0 otherwise.

*   dropviewflg: (Optional) Y/N flag. If 'Y', drops temporary SQL view created

*                when the 'wh' parameter is used. Default is 'Y'.

*

* USAGE:

*   %keycheck(master=sashelp.class,

*             key=Name,

*             wh=Age >= 15,

*             fl=exist_flag,

*             cat=YN,

*             dropviewflg=Y);

*

* NOTES:

*   - This macro creates a hash object on the first record processed.

*   - Efficient for repeated existence checks within data steps.

*   - The macro automatically cleans up temporary views unless explicitly

*     disabled by setting dropviewflg=N.

  
---
 
## `%kvlookup()` macro <a name="kvlookup-macros-3"></a> ######

* MACRO NAME: kvlookup

*

* PURPOSE:

*   Performs a hash table lookup to efficiently retrieve variables from a

*   master dataset based on specified keys. Optionally subsets master data

*   using a condition and manages temporary views.

*

* PARAMETERS:

*   master     : (Required) Name of the master dataset to lookup from.

*   key        : (Required) Space-separated list of key variables for the lookup.

*   var        : (Required) Space-separated list of variables to retrieve from

*                the master dataset. Default is none.

*   wh         : (Optional) SQL WHERE clause condition to subset the master

*                dataset before loading into hash table. Default is none.

*   warn       : (Optional) Y/N flag. If 'Y', issues a warning in the log

*                when the lookup key is not found. Default is 'N'.

*   dropviewflg: (Optional) Y/N flag. If 'Y', drops temporary SQL view created

*                when the 'wh' parameter is used. Default is 'Y'.

*

* USAGE:

*   %kvlookup(master=sashelp.class,

*             key=Name,

*             var=Age Sex,

*             wh=Age > 12,

*             warn=Y,

*             dropviewflg=Y);

*

* NOTES:

*   - This macro creates a hash object dynamically on the first execution,

*     improving performance for repeated lookups.

*   - Ensure keys specified uniquely identify records in the master dataset.

*   - The macro automatically cleans up temporary views unless explicitly

*     disabled by setting dropviewflg=N.

  
---
 
  
---
 
# License <a name="license"></a> ######
 
Copyright (c) [2025] [Yutaka Morioka]
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
  
---
 
