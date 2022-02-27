# Bookmark Manager
Rails is a full-stack framework. It is a server-side web application with all the tools needed to build web apps. 
Using Capybara with RSpec and Sinatra. I am launching a Rubyb web project. 

## User Story #1

Using TDD I will first test the index page for my bookmark manager.

> - As a soft-life user
> - So I can access websites quickly
> - I can view a list of bookmarked websites



## User Story #2

In order to create the ability to add bookmarks onto the web page we must first create a database and table for information to be stored.
Using SQL and database manager Postgres we will use `INSERT`, `UPDATE` and `DELETE` to create, update and delete database entries to fullfill the following user story:

> - As a time-pressed user
> - So that I can save a website
> - I would like to add the site's address and title to bookmark manager

- When updating files this will mess with the test formulated in rspec therefore to overcome this. I have set up a test database that will reset upon each test.
- [x] Use the databases in the correct contexts, so that:
  - [ ] When running tests using `rspec`, bookmarks are read from the new `bookmark_manager_test` database.
  - [ ] When running the application locally, bookmarks are read from the `bookmark_manager` database.
- [ ] Write a helper method that **truncates** (empties) the `bookmarks` table in the test database before each test run.
- [ ] Run this helper method automatically right before **each** RSpec spec, so every test starts with a 'clean' test database.
- [ ] Add required test bookmarks to the `bookmark_manager_test` database in the feature and `Bookmark` tests.
- [ ] Make sure feature and unit tests are passing.
- [ ] Update database setup instructions to include the test database.


## User Story #3
> - As a user
> - So I can remove bookmarks I no longer need
> - I can delete bookmarks


> - As a user I can Update bookmarks
> - As a user I can Comment on bookmarks
- As a user I can Tag bookmarks into categories
- As a user I can Filter bookmarks by tag
- As a user I can restrict user to manage only their own bookmarks
