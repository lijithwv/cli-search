# Zendesk Search CLI Application

## Introduction
This is a simple command line Ruby application to search data from json files and return the results in a human readable format.
Provided data => tickets.json, users.json and organization.json. 
All json files are included in the repo in '/data/json' folder.

## Setup Instructions
- Clone the repo
- Run `bundle install` from the root directory to install dependencies

## Getting Started
- Run `ruby bin/search_app.rb` to start the program
- You will be presented with a self-explanatory main menu
- From the main menu, type `help` to list all of the available commands

## Functionalities
- You can search the data by organisation, user or ticket using any of the fields available in each entity
- You can see a list of searchable fields for each of the above data entities
- Search results will be printed on the command line as an array
- Where the data exists, values from any related entities will be included in the results 
  - Searching by organization will return its tickets and users
  - Searching by ticket will return its organization, user who submitted the ticket and the user who is assigned to the ticket
  - Searching by user will return its organization and tickets in which the user is either a submitter or an assignee
- Search results are displayed based on full value matching with a field
  - Date field is also full value matching. ie, you need to enter full timestamp to return results (eg: 2016-04-14T08:32:31 -10:00)
  - Fields that are of array datatype is matched based on full value matching on any of the array items (eg: Tags, Domain Names etc)

## Testing
- Run `rspec` from the root directory to run all test cases
- Test results will be displayed as per RSpec standard output

