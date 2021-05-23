# Rails Engine

## About this Project

This project simulates the back-end for an E-Commerce site and is currently for demonstration purposes; only available locally.

**Note:** This is an ongoing project at the moment and this README will be updated.

## Author
- **Diana Buffone**

  [GitHub](https://github.com/Diana20920) |
  [LinkedIn](https://www.linkedin.com/in/dianabuffone/)

## Table of Contents

  - [Getting Started](#getting-started)
  - [Running the tests](#running-the-tests)
  - [DB Schema](#db-schema)
  - [Endpoints](#endpoints)
  - [Built With](#built-with)
  - [Versioning](#versioning)

## Getting Started

To run the web application on your local machine, you can fork and clone down the repo and follow the installation instructions below.

### Installing

- Install the gem packages  
`bundle install`

- More to be added here

### Prerequisites

To run this application you will need Ruby 2.5.3 and Rails 5.2.5

## Running the tests
RSpec testing suite is utilized for testing this application.
- Run the RSpec suite to ensure everything is passing as expected  

  `bundle exec rspec`

## DB Schema
The following is a depiction of our Database Schema

## API Endpoints

### Section One
- `GET /api/v1/items`
- `GET /api/v1/items/:id`
- `GET /api/v1/items/:id/merchant`
- `POST /api/v1/items`
- `PATCH /api/v1/items/:id`
- `DELETE /api/v1/items/:id`
- `GET /api/v1/merchants`
- `GET /api/v1/merchants/:id`
- `GET /api/v1/merchants/:id/items`

### Section Two
Non-RESTful Search Endpoints. These endpoints will make use of query parameters.
- `GET /api/vi/items/find_all`, find all items which match a search term
- `GET /api/vi/merchants/find`, find a single merchant which matches a search term

### Section Three
Non-RESTful Business Intelligence Endpoints
- `GET /api/v1/revenue/merchants?quantity=2`, return a number of merchants ranked by total revenue.
- `GET /api/v1/merchants/most_items?quantity=2`, return a variable number of merchants ranked by total number of items sold.
- `GET /api/v1/revenue/merchants/1`, return the total revenue for a single merchant
- `GET /api/v1/revenue/items?quantity=1`, return a quantity of items ranked by descending revenue

## Built With
- Ruby
- Rails
- RSpec
Revise this as more will likely be added

## Gems Used

## Versioning
- Ruby 2.5.3
- Rails 5.2.5
