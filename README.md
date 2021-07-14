## Getting Started
First you need to setup flutter installation. According to OS installation is different. Latest version is recommended:
https://flutter.dev/docs/get-started/install

after that you need to install android studio for android compilations and xcode for ios compilations
you can download xcode from appstore 
 then you need to install flutter to you editor 
 https://flutter.dev/docs/get-started/editor?tab=vscode
# e_consulting



How to Use
Step 1:

Download or clone this repo by using the link below:

https://bitbucket.org/ec2-newnorm/ec2-app.git
Step 2:

Go to project root and execute the following command in console to get the required dependencies:

flutter pub get 
Step 3:

This project uses inject library that works with code generation, execute the following command to generate files:

flutter packages pub run build_runner build --delete-conflicting-outputs
or watch command in order to keep the source code synced automatically:

flutter packages pub run build_runner watch
Hide Generated Files
In-order to hide generated files, navigate to Android Studio -> Preferences -> Editor -> File Types and paste the below lines under ignore files and folders section:

*.inject.summary;*.inject.dart;*.g.dart;
In Visual Studio Code, navigate to Preferences -> Settings and search for Files:Exclude. Add the following patterns:

**/*.inject.summary
**/*.inject.dart
**/*.g.dart

use 'flutter run' command to run you project 
use 'flutter build apk' to build apk file for android 

 for ios release build follow these steps 
 https://flutter.dev/docs/deployment/ios

Folder Structure
Here is the core folder structure which flutter provides.

flutter-app/
|- android
|- build
|- ios
|- lib
|- test
Here is the folder structure we have been using in this project

lib/
|- common/
|- components/
|- i18n/
|- styling/
|- user/
|- routes/
|- config.dart
|- main.dart

Now, lets dive into the lib folder which has the main code for the application.

1- constants - All the application level constants are defined in this directory with-in their respective files. This directory contains the constants for `theme`, `dimentions`, `api endpoints`, `preferences` and `strings`.
2- common - Contains common action,controllers and screens of entire app
3- components - Contains common widgets of app
4- i18n — using for internationalization with getx
5- styling — contains styles for app
6- user — because we are making role base application that folder contains user about actions, controllers, and screens 
7- routes — This file contains all the routes for your application.
8- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
Constants
This directory contains all the application level constants. A separate file is created for each type as shown in example below:

