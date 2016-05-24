# Goose Server - Because Maverick needs a wingman

The Goose server provides a list of open Pull Requests along with basic information about each pull request.

## Pre-requisites

You will need to generate a Personal Access Token in order to run the service.
**Please store the token hash in a safe place**, since you will need this information when setting up your ENV variables (see Installation).

[Click here](https://github.com/settings/tokens) go there now!

## Installation

`git clone git@github.com:Alliants/goose-server.git`

`bundle`

Copy the `.env.example` to `.env` and supply the appropriate ENV variables


## To Run locally

`bundle exec rails s`

visit

[http://localhost:3000/api/pull-requests](http://localhost:3000/api/pull-requests)

## To begin

Seed the data with a live call `bundle exec rake db:seed`
