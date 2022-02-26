# Onye Wellness Frontend app
This is the repository for the Onye Wellness frontend application.

## Basic information

|               |         |
|:--------------|--------:|
| Language      |    Dart |
| Framework     | Flutter |


## Backend

This application uses the Onye Core API for data access and manipulation. That repository can be found here: https://github.com/Onye-PRS/core-api


## Structure 

The code is structured around the pages that are available from the home page when the user has logged in to the application.
Every page accessible from there can be found in its own folder inside the `lib` folder.

Ex:

    lib
    |
    --- pages
        |
        --- appointment
            |
            --- form
            --- page
            --- repository
            --- state

Inside each folder you can find the sub pages, forms, state handling classes etc.

## State handling
State handling is done using the Bloc-pattern. Each page (see structure above) has its own state which can be found in the sub folder called `state`.

## Backend connection
Backend connection is done in repository classes found in a sub folder for each page called `repository`.
Here you can find all the functions that are used to make http requests to the backend application.
