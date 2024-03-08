# OSU Variety Testing App: A Mobile App for OSU Wheat and Barley Variety Testing
The OSU Variety Testing App is a mobile application for viewing Oregon State University wheat and barley
variety trials. It is available for both Android and iOS and was developed using Flutter by Anna Level
and Andrew Wallace, under the guidance of Dr. Ryan Graebner.

## Updating data source files
This application reads its data from remote .CSV files. Once the data has been loaded once, it is persisted
into the user's local device storage. The app detects changes in the last updated date of the index file,
but will default to using what is stored in local storage to reduce latency and allow offline use.

### index.csv
OSU Variety Testing App pulls from the given index.csv file (whose URL can be specified in the `configuration.json` file). This file must be formatted as follows:
```
03/01/2024  // Last updated - can be any text value. Changes in this will be detected.
2023        // Year that data is from. Changes in this will be detected.
http://.... // Links to individual .CSV files whose formats are specified below
http://....
http://....
http://....
http://....
http://....
http://....
```

In other words, the first line must be the last updated date, and the second line must be the year that the
data was collected. All other lines should be urls to remote .CSV files with data for different environments,
classes, and/or data sets.

### Data .CSVs
Each .CSV linked in index.csv should follow a particular format.
```
HRW Irrigated,,,,,,,,,,
0,1,4,1,2,2,1,2,2,1,2
Entry,Variety,Released,Traits,Quality,Class,Yield,Test,Protein,Height,Heading Date
64,LCS Rocket,1,,A,HRW,133.5,60,10.1,34, 6-5
63,LCS Jet,1,,A,HRW,132.4,61.2,10.3,34, 6-5
65,LCS Blackbird (LWH18-0122),1,,,HRW,131.5,60.9,10.9,33.1, 6-3
66,LCS Missile (LWH19-0192),1,,,HRW,127.5,61.6,10.3,36, 6-5
56,Scorpio,1,,MD,HRW,126,60.9,10.6,34.4, 6-7
...
```
The first line should be the display title of the data set. This may include class, precipitation, etc.
The second line should contain column visibilities for each column in the data set. These are coded as follows:
0. Never visible; user can never view it
1. Not visible by default; user can toggle the column on
2. Visible by default; user can toggle the column off
3. Always visible; user cannot remove it
4. Released; for the column used to filter the toggle for "Released". The value must be either the integer 0 (unreleased) or 1 (released). This is invisible as a normal column, but the value is used when filtering by "Released"

The third line should contain names for each column in the data set.

The fourth lines and beyond should be the values for each of these columns.

Please ensure these files are formatted as precisely as possible. Problems with the files will not generate errors in
the application, but the malformed data will simply be discarded. This may result in missing data sets in particular.

## Customizing the application
OSU Variety Testing App has been designed with modularity in mind. If another group or institution would like to
use this work as a basis for sharing their own variety testing data, we want to make this easy without extensive
modification.

The central part of the app, the data, can be replaced as simply as replacing the value `config/indexUrl` in `config.json`.
Other customizable parts are fairly self explanatory. There are options for color in different parts of the app,
title text, and data source text and URL.

More extensive modifications will require modifications of source .dart files.

Deploying the app to the Play Store or App Store will require some final building and tweaking of configuration.
A member of your team with experience in this area will be able to replace the application icon and modify other identifiers during this process.

## Contact
For questions, comments, or suggestions, please email Dr. Ryan Graebner at: ryan.graebner@oregonstate.edu