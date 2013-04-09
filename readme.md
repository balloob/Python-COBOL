# COBOL Copybook parser in Python
This is a COBOL Copybook parser in Python featuring the following options:
 - Parse the Copybook into a usable format to use in Python
 - Clean up the Copybook by processing REDEFINES statements and remove unused definitions
 - Denormalize the Copybook
 - Write the cleaned Copybook in COBOL
 - Strip prefixes of field names and ensure that the Copybook only contains unique names
 - Can be used from the command-line or included in own Python projects

Because I couldn't find a COBOL Copybook parser that fitted all my needs I wrote my own. It doesn't support all functions found in the Copybook, just the ones that I met on my path: REDEFINES, INDEXED BY, OCCURS. 

On a day to day basis I use it so that Informatica PowerCenter creates only 1 table of my COBOL data instead multiple.

The code uses the pic parser code from [pyCOBOL](http://www.travelingfrontiers.com/projects/doku.php?id=pycobol).

This code is licensed under GPLv3.

## Example output
Below is an example Copybook file before and after being processed.

Before:

	00000 * Example COBOL Copybook file                                     AAAAAAAA
	00000  01  PAULUS-EXAMPLE-GROUP.                                        AAAAAAAA
	00000       05  PAULUS-ANOTHER-GROUP OCCURS 0003 TIMES.                 AAAAAAAA
	00000           10  PAULUS-FIELD-1 PIC X(3).                            AAAAAAAA
	00000           10  PAULUS-FIELD-2 REDEFINES PAULUS-FIELD-1 PIC 9(3).   AAAAAAAA
	00000           10  PAULUS-FIELD-3 OCCURS 0002 TIMES                    AAAAAAAA
	00000                           PIC S9(3)V99.                           AAAAAAAA
	00000       05  PAULUS-THIS-IS-ANOTHER-GROUP.                           AAAAAAAA
	00000           10  PAULUS-YES PIC X(5).                                AAAAAAAA

After:

	         01  EXAMPLE-GROUP.                                                     
	           05  FIELD-2-1 PIC 9(3).                                              
	           05  FIELD-3-1-1 PIC S9(3)V99.                                        
	           05  FIELD-3-1-2 PIC S9(3)V99.                                        
	           05  FIELD-2-2 PIC 9(3).                                              
	           05  FIELD-3-2-1 PIC S9(3)V99.                                        
	           05  FIELD-3-2-2 PIC S9(3)V99.                                        
	           05  FIELD-2-3 PIC 9(3).                                              
	           05  FIELD-3-3-1 PIC S9(3)V99.                                        
	           05  FIELD-3-3-2 PIC S9(3)V99.                                        
	           05  THIS-IS-ANOTHER-GROUP.                                           
	             10  YES PIC X(5).                                                 


## How to use
You can use it in two ways: inside your own python code or as a stand-alone command-line utility.

### Command-line
Do a git clone from the repository and inside your brand new python-cobol folder run:

	python cobol.py example.cbl

This will process the redefines, denormalize the file, strip the prefixes and ensure all names are unique. 

The utility allows for some command-line switches to disable some processing steps.

	$ python cobol.py --help
	usage: cobol.py [-h] [--skip-all-processing] [--skip-unique-names]
	                      [--skip-denormalize] [--skip-strip-prefix]
	                      filename

	Parse COBOL Copybooks

	positional arguments:
	  filename              The filename of the copybook.

	optional arguments:
	  -h, --help            show this help message and exit
	  --skip-all-processing
	                        Skips unique names, denormalization and .
	  --skip-unique-names   Skips making all names unique.
	  --skip-denormalize    Skips denormalizing the COBOL.
	  --skip-strip-prefix   Skips stripping the prefix from the names.	

### From within your Python code
The parser can also be called from your Python code. All you need is a list of lines in COBOL Copybook format. See example.py how one would do it:

```python
import cobol

with open("example.cbl",'r') as f:
    for row in cobol.process_cobol(f.readlines()):
    	print row['name']
```

It is also possible to call one of the more specialized functions within cobol.py:

*    **clean_cobol(lines)**
    
     Cleans the COBOL by converting the cobol informaton to single lines


*    **parse_cobol(lines)**

     Parses a list of COBOL field definitions into a list of dictionaries containing the parsed information.


*    **denormalize_cobol(lines)**

     Denormalizes parsed COBOL lines


*    **clean_names(lines, ensure_unique_names=False, strip_prefix=False, make_database_safe=False)**
     
     Cleans names of the fields in a list of parsed COBOL lines. Options to strip prefixes, enforce unique names and make the names database safe by converting dashes (-) to underscores (_)


*    **print_cobol(lines)**
     
     Prints parsed COBOL lines in the Copybook format
