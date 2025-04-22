# sashash
The sashash package provides powerful and efficient hash-based lookup and validation tools specifically designed for SAS programming. Leveraging the robust capabilities of SAS hash objects, this package enables rapid and dynamic key-based data retrieval and existence checking directly within a single data step. This significantly reduces the need for separate sort and merge steps, streamlining workflows and enhancing performance.


<img width="180" alt="Image" src="https://github.com/user-attachments/assets/51466461-8f76-49e1-80f0-8ebb791c3d46" />


#%kvlookup()
Purpose: 
Enables efficient and dynamic retrieval of variables from a specified master dataset based on provided keys, directly within a single data step without separate sorting or merging.
Usage Example:
%kvlookup(master=sashelp.class,
          key=Name,
          var=Age Sex,
          wh=Age > 12,
          warn=Y,
          dropviewflg=Y);
