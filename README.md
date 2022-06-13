# employee_directory

Employee directory application

## Getting Started

This project is a starting point for a Flutter application.

Flutter Version 2.2.3

## WorkFLow


When App Starts it checks the data already stored

if stored  take that data and display without calling web service

else store the data using hive and also download profile image and save its path location in db

and then data loaded from data base without calling web service

and on Tap the employee its show the details of employee

Also provide a field to search user its filter as per the input

## Used Technology

StateManagement Used  : Provider
Api Calling           : Dio package
Downloading profile   : Dio package
Databas               : Hive
Architectural Pattern : MVVM
