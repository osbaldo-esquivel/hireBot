# Basic Hiring Simulator

This simple ruby script will simulate the hiring process by reading an input file with commands and applicants. An output file will be created with the results of the simulated hiring process. The commands are as follows:

```
DEFINE:
Define the stages in the hiring process. The available stages are ManualReview 
PhoneInterview BackgroundCheck DocumentSigning. The stages can be in any order, 
and an applicant must be in the last stage in order to be hired.
Output: DEFINE [STAGE_NAMES]
```

```
CREATE:  
Create an applicant with the specified email address. Check if the applicant 
is already in the system before creating a new one.
Output: if the applicant with the same email exists, Duplicate applicant. 
Otherwise, CREATE [EMAIL].
```

```
ADVANCE:
Advance the applicant to the specified stage. If STAGE_NAME parameter is 
omitted, advance the applicant to the next stage.
Output: if the applicant is already in [STAGE_NAME] or the last stage, Already 
in [STAGE_NAME]. Otherwise, ADVANCE [STAGE_NAME].
```

```
DECIDE:
Decide if the applicant should be hired (1) or rejected (0). An applicant can 
be rejected (0) from any stage, but has to be in the last stage in order to be hired (1).
Output: if successfully hired, Hired [EMAIL]. If successfully rejected, Rejected 
[EMAIL]. Otherwise, Failed to decide for [EMAIL].
```

```
STATS:  
Print the number of applicants for all stages, including the hired and rejected.  
Output: [STAGE_1] 0 [STAGE_2] 1 [STAGE_3] 1 Hired 2 Rejected 0
```

###Example

input_file.txt

```
DEFINE PhoneInterview BackgroundCheck DocumentSigning  
STATS  
CREATE test@gmail.com  
ADVANCE test@gmail.com  
DECIDE test@gmail.com 0  
STATS
```

output_file.txt

```
DEFINE PhoneInterview BackgroundCheck DocumentSigning  
Phone Interview 0 BackgroundCheck 0 DocumentSigning 0 Hired 0 Rejected 0  
CREATE test@gmail.com  
ADVANCE test@gmail.com  
Phone Interview 0 BackgroundCheck 0 DocumentSigning 0 Hired 0 Rejected 1
```

# Instructions

To run this script, place the input file in the same directory as this script and then run the following command:

`ruby task.rb <file_name>`

The output file will be called output.txt and it will be created in the same directory as the script.
