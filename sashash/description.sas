Type : Package
Package : sashash
Title : sashash--Provides various macros related to Key-Value processing using SAS HASH objects.
Version : 0.0.1
Author : Yutaka Morioka(sasyupi@gmail.com)
Maintainer : Yutaka Morioka(sasyupi@gmail.com)
License : MIT
Encoding : UTF8
Required : "Base SAS Software"
ReqPackages : None

DESCRIPTION START:
Description: The sashash package provides powerful and efficient hash-based lookup and validation tools specifically designed for SAS programming. Leveraging the robust capabilities of SAS hash objects, this package enables rapid and dynamic key-based data retrieval and existence checking directly within a single data step. This significantly reduces the need for separate sort and merge steps, streamlining workflows and enhancing performance.

Concept: The core strength of the sashash package is its ability to simplify and accelerate data processing tasks by eliminating repetitive data sort and merge operations. Users can perform multiple data joins and validations dynamically within a single SAS data step, using keys generated on-the-fly during processing, thereby dramatically improving both flexibility and speed.

Included Macros:

kvlookup Macro:

Purpose: Enables efficient and dynamic retrieval of variables from a specified master dataset based on provided keys, directly within a single data step without separate sorting or merging.

Usage Example:

%kvlookup(master=sashelp.class,
          key=Name,
          var=Age Sex,
          wh=Age > 12,
          warn=Y,
          dropviewflg=Y);

keycheck Macro:

Purpose: Dynamically validates the existence of keys within a master dataset directly within a single data step. Ideal for rapid data integrity checks and immediate flagging of key existence or non-existence.

Usage Example:

%keycheck(master=sashelp.class,
          key=Name,
          wh=Age >= 15,
          fl=exist_flag,
          cat=YN,
          dropviewflg=Y);

Ideal for:

Data analysts and SAS programmers dealing with large datasets requiring multiple lookups or validations.

Scenarios where performance and flexibility are critical, eliminating the overhead associated with separate sort and merge operations.

Complex data processing tasks where keys must be dynamically generated and validated within the data step.

The sashash package dramatically simplifies complex data manipulations, enabling faster, more efficient, and flexible data processing within SAS.
DESCRIPTION END:
