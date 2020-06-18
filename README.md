# Flood risk engine

[![Build Status](https://travis-ci.com/DEFRA/flood-risk-engine.svg?branch=main)](https://travis-ci.com/DEFRA/flood-risk-engine)
[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=DEFRA_flood-risk-engine&metric=sqale_rating)](https://sonarcloud.io/dashboard?id=DEFRA_flood-risk-engine)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=DEFRA_flood-risk-engine&metric=coverage)](https://sonarcloud.io/dashboard?id=DEFRA_flood-risk-engine)
[![security](https://hakiri.io/github/DEFRA/flood-risk-engine/main.svg)](https://hakiri.io/github/DEFRA/flood-risk-engine/main)

A Ruby on Rails [engine](http://guides.rubyonrails.org/engines.html) delivering the complete public-facing functionality of the [Flood risk activity exemptions service](https://register-flood-risk-exemption.service.gov.uk).

It is mounted in a thin [Flood Risk Front Office](https://github.com/EnvironmentAgency/flood-risk-front-office) Rails application host in order to be deployed. It can also be mounted within an administration application.

## Getting started

The engine is un-styled when run stand-alone. To see the fully-styled service, follow the instructions in the [Front office readme](https://github.com/EnvironmentAgency/flood-risk-front-office).

## Prerequisites

Please make sure the following are installed:

- [Ruby 2.3.1](https://www.ruby-lang.org) installed for example via [RVM](https://rvm.io) or [Rbenv](https://github.com/sstephenson/rbenv/blob/master/README.md)
- [Bundler](http://bundler.io/)
- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Postgresql](http://www.postgresql.org/download)
- [Phantomjs](https://github.com/teampoltergeist/poltergeist#installing-phantomjs)

## Installation

Clone the repository and install its gem dependencies:

```bash
git clone https://github.com/EnvironmentAgency/flood-risk-engine.git
cd flood-risk-engine
bundle
```

### .env

The project uses the [dotenv](https://github.com/bkeepers/dotenv) gem to load environment variables when the app starts. **Dotenv** expects to find a `.env` file in the project root. As this is an engine, the `.env` file must be in the root of the dummy app at `spec/dummy`.

Rename `spec/dummy/.env.example` to `spec/dummy/.env`, and update the values where necessary (some have defaults).

### Database

To create, schema:load and seed the database

```bash
bundle exec rake db:setup
```

## Running the app

Because this is an engine, you need to start the app in `./spec/dummy`:

```bash
bundle exec ./spec/dummy/bin/rails s
```

Open [http://localhost:3000](http:localhost:3000) in a browser.

## Email

### Intercepting mail

You can use [Mailcatcher](https://mailcatcher.me/) to intercept emails sent out during development.

In `./spec/dummy/.env` ensure you have `EMAIL_HOST=localhost` and `EMAIL_PORT=1025`

Install **Mailcatcher** (if necessary) and run it

```bash
gem install mailcatcher
mailcatcher
```
Navigate to [http://localhost:1080](http://localhost:1080) to see intercepted email.

### Previewing emails

You can also view an [ActionMailer::Preview](http://api.rubyonrails.org/v4.1.0/classes/ActionMailer/Base.html#class-ActionMailer::Base-label-Previewing+emails) of an email by starting the dummy app and navigating to [http://localhost:3000/rails/mailers](http://localhost:3000/rails/mailers).

If you want to test against an enrollment other than the last created one, you will need to alter the preview class in `spec/dummy/lib/mailer_previews`.

## Tests

The [RSpec](http://rspec.info/) test suite focuses on unit and controller tests rather than integration and acceptance tests (see [Flood risk acceptance tests](https://github.com/EnvironmentAgency/flood-risk-acceptance-tests)) for those.

To run [Rubocop](https://github.com/bbatsov/rubocop) followed by the test suite

```bash
bundle exec rake
```

To run just the tests

```bash
bundle exec rake test
```

## Error reporting

The engine includes the airbrake gem, and will try to post production errors to an [Errbit](https://github.com/errbit/errbit) server which must be configured via the ENV variables

```ruby
AIRBRAKE_HOST = "https://airbrake_or_errbit_server"
AIRBRAKE_PROJECT_KEY ="<api key>"
```

## Example usage

This engine is a self-contained service but is designed to be mounted in a host application which will provide contextual styling.

For example in a host rails application
```ruby
# In the Gemfile
gem "flood_risk_engine",
    git: "https://github.com/EnvironmentAgency/flood-risk-engine",
    tag: "v1.0.0"
```

```ruby
# In routes.rb
mount FloodRiskEngine::Engine => "/"
```

## Engine design

The service comprises a number of sequential forms, or steps, the customer
must complete and submit if they wish to apply for a flood risk activity exemption.

A *state machine* defines and enforces the order of the steps (or states).
See the [separate state machines readme](app/state_machines/flood_risk_engine/STATE_MACHINE_README.md).

### Folder structure

The `app` folder departs from a vanilla Rails app in the following regards

- *app*
  - *forms* has [form objects](https://github.com/apotonick/reform) to encapsulate step-specific validation and data persistence
  - *jobs* has [ActiveJob jobs](http://guides.rubyonrails.org/active_job_basics.html) that are background jobs currently implemented using threads and the [Suckerpunch](https://github.com/brandonhilkert/sucker_punch) gem
  - *presenters* has [presenter](http://nithinbekal.com/posts/rails-presenters/) classes used to aggregate and format data from several models for display on certain forms and pages
  - *services* [Service objects](http://brewhouse.io/blog/2014/04/30/gourmet-service-objects.html) encapsulate an activity
  - *state_machines* See our [state machines readme](app/state_machines/flood_risk_engine/STATE_MACHINE_README.md)
  - *views*
    - *pages* the [High_voltage](https://github.com/thoughtbot/high_voltage) gem serves these as static pages

## Contributing to this project

If you have an idea you'd like to contribute please log an issue.

All contributions should be submitted via a pull request.

## License

THIS INFORMATION IS LICENSED UNDER THE CONDITIONS OF THE OPEN GOVERNMENT LICENCE found at:

http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3

The following attribution statement MUST be cited in your products and applications when using this information.

> Contains public sector information licensed under the Open Government license v3

### About the license

The Open Government Licence (OGL) was developed by the Controller of Her Majesty's Stationery Office (HMSO) to enable information providers in the public sector to license the use and re-use of their information under a common open licence.

It is designed to encourage use and re-use of information freely and flexibly, with only a few conditions.
