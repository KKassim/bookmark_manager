# Bookmark Manager
Rails is a full-stack framework. It is a server-side web application with all the tools needed to build web apps. 
Using Capybara with RSpec and Sinatra. I am launching a Rubyb web project. 
For this project as always my flow will be:
As always, our flow is:

- Requirement
- User Story
- Feature Test
- Unit Tests
- Implementation
- Refactoring

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

To set up a test database, let's run `psql` and create a database, and use the SQL query saved in `db/migrations/01_create_bookmarks_table.sql` to create a bookmarks table.

```
$> psql
admin=# CREATE DATABASE "bookmark_manager_test";
admin=# CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60));
```

Now, if we list databases (in `psql` or by looking in TablePlus), we'll see two databases for our application: `bookmark_manager`, and the new `bookmark_manager_test` database.


- [x] Use the databases in the correct contexts, so that:
  - [x] When running tests using `rspec`, bookmarks are read from the new `bookmark_manager_test` database.
  - [x] When running the application locally, bookmarks are read from the `bookmark_manager` database.
- [x] Write a helper method that **truncates** (empties) the `bookmarks` table in the test database before each test run.
- [x] Run this helper method automatically right before **each** RSpec spec, so every test starts with a 'clean' test database.
- [x] Add required test bookmarks to the `bookmark_manager_test` database in the feature and `Bookmark` tests.
- [x] Make sure feature and unit tests are passing.
- [x] Update database setup instructions to include the test database.


## User Story #3

> - As a user
> - So I can remove bookmarks I no longer need
> - I can delete bookmarks

## User Story #4

> - As a user
> - So I can change a bookmark in Bookmark Manager
> - I want to update a bookmark


Here's the user flow for updating a bookmark:

1. Visit the 'update bookmark' form for a particular bookmark.
2. Fill in the form with new data ??? say, a new title ??? and submit it.
3. See the homepage, with the updated bookmark title (and the old one is gone).

At this stage I have now built a Sinatra application that can read and write from and to a database. It's structured in an MVC style, and has test and development environments.

## User Story #5

> - As a user with an opinion on everything
> - So that I can express my views
> - I want to be able to comment on bookmarks

In a one-to-many relationship, there are two models:

- one 'parent' model, `Bookmark`, _has many_ `Comment`s.
- the 'child' model, `Comment`, _belongs to_ a single `Bookmark`.

```
  ONE       ????????????   MANY
 Bookmark   ????????????  Comments
```

The only way to store this in a table relationship is to add an extra column to the 'child' model.

For instance, in the table below, the first two comments refer to a Bookmark with an ID of 1. The last comment refers to a Bookmark with an ID of 2:

```
| id | text                       | bookmark_id |
|----|----------------------------|-------------|
| 1  | Great Bookmark!            | 1           |
| 2  | I don't like this Bookmark | 1           |
| 3  | What a cool resource       | 2           |
```

Comments with ID 1 and 2 are comments on the same Bookmark. If they were displayed, they'd look like this:

- Bookmark 1
  - Great Bookmark!
  - I don't like this Bookmark.
- Bookmark 2
  - What a cool resource
  
## User Story #5
> - As a user organised user
> - So that I filter through my bookmarks
> - I want to be able to search through my bookmarks tags


- As a user I can Filter bookmarks by tag
- As a user I can restrict user to manage only their own bookmarks
