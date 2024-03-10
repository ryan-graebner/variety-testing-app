# Variety Testing App: A Mobile App for Wheat and Barley Variety Testing
The OSU Variety Testing App is a mobile application for viewing Oregon State University wheat and barley
variety trials. It is available for both Android and iOS and was developed using Flutter by Anna Level
and Andrew Wallace, under the guidance of Dr. Ryan Graebner.

## Structure of input files
All data files are posted online. The index file provides the app with basic information as well as the 
location of files containing variety testing data. The dataset files contain the actual variety testing data.

### Index
This CSV file should be labeled "index.csv" and consists of three parts. The first part (in cell A1) 
is the date of the most recent update. This is displayed to the user, and changing this value triggers 
the app to update data. The second part (in cell A2) is the most recent crop year reflected in the data. 
This is displayed to the user, but has no other functionality for the app. The third part (in cells A3-Ax, 
where x is the number of datasets included plus 2) is a list of urls for csv files, each containing a 
dataset to be displayed. The order of these urls will determine the order that the corresponding datasets 
are listed in the app's drop-down menu.

### Dataset
These CSV files include a dataset name (in cell A1) followed by a table that contains information on the varieties tested.

The first row of the table indicates how the app should handle data in the following column, where "0"
indicates that the column should be ignored, "1" indicates the column contains data that is not visible 
by default but can be shown if the user selects the corresponding box, "2" indicates the column contains 
data that is visible by default but can be hidden if the user unselects the corresponding box, "3" indicates 
the column is always shown, and "4" indicates the column shows each variety's release status.

The second row of the table indicates the name for each column. These names will match the column names 
displayed in the app.

Following the second row of the table is the data for each variety. If data is not available for a 
specific variety/trait combination, that cell can be left empty. For the release status column, "0" indicates 
a variety has not been released, while "1" indicates the variety has been released. Variety release 
data is not directly shown in the app, but the user has the option to hide varieties that have not been released.

The app will display varieties and traits in the order they are listed in the dataset files. The app 
generally does not "know" the difference between the columns containing variety names, the columns containing 
variety information, and the columns containing variety testing data; the app is simply displaying data 
from the table based on the numbers in the table's first row and the user's selections. The one exception 
to this is the column containing each variety's release status: each dataset file should always include 
one column indicating each variety's release status.

## Customizing the application
OSU Variety Testing App has been designed with modularity in mind. If another group or institution would like to
use this work as a basis for sharing their own variety testing data, we want to make this easy without extensive
modification.

The central part of the app, the data, can be replaced as simply as replacing the value `config/indexUrl` in `config.json`.
Other customizable parts are fairly self explanatory. There are options for color in different parts of the app,
title text, and data source text and URL.

More extensive modifications will require modifications of source .dart files.

Deploying the app to the Play Store or App Store will require some final building and tweaking of 
configuration. A member of your team with experience in this area will be able to replace the application 
icon and modify other identifiers during this process.

## Contact
For questions, comments, or suggestions, please email Dr. Ryan Graebner at: ryan.graebner@oregonstate.edu