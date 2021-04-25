# Paired Back-End

## Table of Contents

- [Deployed App](#deployed-app)
- [Local Deployment](#local-deployment)
- [Dev Team](#dev-team)
- [Description](#description)
- [Rock & Pebble Feature](#rock--pebble-feature)
- [Agile Development](#agile-development)
- [Technologies & Architectures](#technologies--architecture)
- [React & Redux Tutorial](#react--redux-tutorial)
- [Testing & Performance](#testing--performance)
- [PostgreSQL Schema](#postgresql-schema)
- [GraphQL Endpoints](#graphql-endpoints)
- [Resource Credits](#resource-credits)

## Deployed App

Vist the deployed Paired app at [https://www.paired.tech](https://www.paired.tech).

## Local Deployment

See this [Deployment Guide](local_setup_guide.md) for detailed instructions on how to deploy the app in a local environment.

## Dev Team

Paired 2.0's dev team:
 - Carleigh Crockett ([@Capleugh](https://github.com/Capleugh), [LinkedIn](https://www.linkedin.com/in/carleighcrockett/))
 - Daniel Frampton ([@DanielEFrampton](https://github.com/DanielEFrampton), [LinkedIn](https://www.linkedin.com/in/danielframpton/))
 - Matt Simon ([@msimon42](https://github.com/msimon42), [LinkedIn](https://www.linkedin.com/in/matt-simon-83aa5380/))
 - Rebecca Robran ([@rer7891](https://github.com/rer7891), [LinkedIn](https://www.linkedin.com/in/rebecca-robran/))

Rock & Pebble feature's dev team:
 - Rebecca Robran, BE/FE ([@rer7891](https://github.com/rer7891), [LinkedIn](https://www.linkedin.com/in/rebecca-robran/))
 - Rachel Lew, BE ([@rlew421](https://github.com/rlew421), [LinkedIn](https://www.linkedin.com/in/rlew/))
 - Matt Simon, BE ([@msimon42](https://github.com/msimon42), [LinkedIn](https://www.linkedin.com/in/matt-simon-83aa5380/))
 - Linda Le, BE ([@linda-le1](https://github.com/linda-le1), [LinkedIn](https://www.linkedin.com/in/linda-lewang/))
 - Daniel Frampton, BE/FE ([@DanielEFrampton](https://github.com/DanielEFrampton), [LinkedIn](https://www.linkedin.com/in/danielframpton/))
 - Caleb Haizlett, FE ([@CHaiz15](https://github.com/CHaiz15), [LinkedIn](https://www.linkedin.com/in/caleb-haizlett/))

## Description

This repo contains the Paired 2.0 Back-end, a GraphQL API built with Ruby on Rails and PostgreSQL. It provides data, logic, and other services to a React/Redux Front-end ([paired-fe](https://github.com/hillstew/paired-fe)), and communicates with a Flask micro-service which handles SMS text notifications ([paired-sms](https://github.com/msimon42/paired-sms)).

Together, these micro-services facilitate paired programming and peer mentoring between [Turing](http://turing.io) students throughout their seven-month immersive program. Students later in the program can create available booking slots, and students earlier in the program can browse those and book paired sessions.

Paired 2.0 was built by a team of students in Turing's Back-End Engineering program. It adds SMS and email notifications of bookings and a user statistics dashboard to the [original Paired app](http://paired.tech) ([front-end repo](https://github.com/hillstew/paired-fe), [back-end repo](https://github.com/dForDeveloper/paired-api)) which was built by Front-end students in April of 2019. They graciously allowed contributions to the app and were helpful throughout this process.

## Rock & Pebble Feature

The Rock & Pebble feature adds the ability for Paired users to offer to be peer mentors, search for and request peer mentors, and manage their mentors/mentees. Building on the previous 2.0 work, it sends descriptive email notifications throughout the process.  By adding this feature we hope to support the grassroots tradition at Turing of upper-module students ("rocks") being partnered with lower-module students ("pebbles") to support their journey. 

The Rock & Pebble feature was developed over the course of 2020 by a group of 1909 back-end and front-end graduates, some from the Paired 2.0 dev team and some new contributors. The development took place on forks of the BE and FE repos, which are now archived but can be found [here](https://github.com/PairedStaging/paired-be) and [here](https://github.com/PairedStaging/paired-fe) respectively for future reference.

## Agile Development

Paired 2.0 was developed over the course of 9 days using accelerated agile practices. After [an initial proposal was written](https://gist.github.com/DanielEFrampton/bb6c6ec2cfa0d466642adf0811d85e16) by the project lead, the team collaboratively participated in an "inception" process. After writing [problem and solution statements](https://gist.github.com/DanielEFrampton/fdc8653e042b7f3d7a6feca8767609eb), the team "brain-dumped" all their feature proposals then went through a feature prioritization process in order to determine which would be part of the "minimum viable product" (MVP).

Soon thereafter the team had [a "DTR" meeting](https://gist.github.com/DanielEFrampton/78bc2e980c51af7a98ff3aa422ca8902) to establish goals, communication plans, project management conventions, and more. It was agreed upon that the team would use a Kanban system for project management using [Github Projects](https://github.com/DanielEFrampton/paired-be/projects/1), and have daily stand-up meetings and weekly retrospective meetings. The team met with a project manager every three days for check-ins and communicated with her regularly via Slack.

## Technologies & Architecture

![Technology and Architecture Chart](https://user-images.githubusercontent.com/40702808/75644294-10828a00-5bff-11ea-801c-33c0e7b75691.png)

- Hosting: Firebase (FE) and Heroku (BE, SMS)
- Database: PostgreSQL
- Front-end: React & Redux
- Back-end: Ruby on Rails
- SMS Micro-service: Flask & Python
- Testing: Jest (FE), RSpec (BE), and PyTest (SMS)
- GraphQL: Apollo Client (FE) and GraphQL-Ruby (BE)
- OAuth: Github via Firebase
- SMS Notifications: Twilio
- Email Notifications: Sendgrid
- Background Workers: Sidekiq and Redis
- Performance Tracking: Skylight

## React & Redux Tutorial

As a team of back-end engineers, stepping into a JavaScript-heavy tech stack was an incredible and bewildering learning experience. To help share that learning with our fellow students in the back-end program, we wrote this tutorial: [Explain It Like I'm a Back-ender: React and Redux](react_redux_guide.md).

## Testing & Performance

![Skylight performance dashboard](https://user-images.githubusercontent.com/40702808/75517976-d8f5c100-59f7-11ea-8304-c67cba74546d.png)

At date of project completion, the Paired 2.0 back-end service has 98% test coverage and all tests passing. Server performance and load times are monitored using Skylight, and at time of writing responses average 37 ms.

## PostgreSQL Schema

| Users | Data Type | Keys |
| ----------- | ----------- | ----------- |
| Id | ID | Primary Key |
| name | String |  |
| program | String | |
| pronouns | String | |
| mod | Integer | |
| slack | String | |
| email | String | |
| phone_number | String | |
| firebase_id | String | OAuth Token |

| Pairings | Data Type | Keys |
| ----------- | ----------- | ----------- |
| Id | ID | Primary Key |
| pairer_id | Integer | User Foreign Key|
| pairee_id | Integer | User Foreign Key|
| date | String | |
| time | String | |
| notes | String | |

| Skills | Data Type | Keys |
| ----------- | ----------- | ----------- |
| Id | ID | Primary Key |
| name | String | |
| user_id | Integer | User Foreign Key

## GraphQL Endpoints

Our GraphQL endpoints fall into three categories: queries, mutations, and filter queries. For detailed examples of all the endpoints and example responses, see our [GraphQL Endpoints Guide](graphql_endpoints.md) or click the specific query or mutation below to go its section.

To make live queries to the GraphQL endpoint and see live schema information, setup the back-end using the [local deployment instructions](local_setup_guide.md) and access GraphiQL at `http://localhost:3001/graphiql`.

- Queries
  - [getUser](graphql_endpoints.md#get-user)
  - [getUserByFirebaseID](graphql_endpoints.md#get-user-by-firebase-id)
  - [getUserPairings](graphql_endpoints.md#get-user-pairings)
  - [getUser](graphql_endpoints.md#get-user)
  - [getPairings](graphql_endpoints.md#get-pairings)
  - [getPairing](graphql_endpoints.md#get-pairing)
  - [getUserStats](graphql_endpoints.md#get-user-stats)
- Mutations
  - [createUser](graphql_endpoints.md#create-user)
  - [updateUser](graphql_endpoints.md#update-user)
  - [deleteUser](graphql_endpoints.md#delete-user)
  - [createPairings](graphql_endpoints.md#create-pairings)
  - [updatePairings](graphql_endpoints.md#update-pairings)
  - [deletePairing](graphql_endpoints.md#delete-pairing)
  - [deletePairings](graphql_endpoints.md#delete-pairings)
- Filter Queries
  - [getPairing](graphql_endpoints.md#get-pairing)
- Rock & Pebble Queries & Mutations
  - Queries
    - [getUserRockAndPebbles](graphql_endpoints.md#get-user-rocks-and-pebbles)
  - Mutations
    - [rockOptInOut](graphql_endpoints.md#rock-opt-in-out)
    - [createRockPebbleRelationship](graphql_endpoints.md#create-rock-pebble-relationship)
    - [activateRockPebbleRelationship](graphql_endpoints.md#activate-rock-pebble-relationship)
    - [declineRockPebbleRelationship](graphql_endpoints.md#decline-rock-pebble-relationship)
    - [discontinueRockPebbleRelationship](graphql_endpoints.md#discontinue-rock-pebble-relationship)
  - Filter Queries
    - [findAvailableRocks](graphql_endpoints.md#find-available-rocks)

## Resource Credits

- [Architecture chart created with Lucidchart.com](http://www.lucidchart.com)
- [Technology logos from Worldvectorlogo.com](http://worldvectorlogo.com/)
