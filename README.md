# FloodRiskEngine

[![Build Status](https://travis-ci.org/EnvironmentAgency/flood-risk-engine.svg?branch=develop)](https://travis-ci.org/EnvironmentAgency/flood-risk-engine)
[![Code Climate](https://codeclimate.com/github/EnvironmentAgency/flood-risk-engine/badges/gpa.svg)](https://codeclimate.com/github/EnvironmentAgency/flood-risk-engine)
[![Test Coverage](https://codeclimate.com/github/EnvironmentAgency/flood-risk-engine/badges/coverage.svg)](https://codeclimate.com/github/EnvironmentAgency/flood-risk-engine/coverage)

## Development

Before making changes for the first time, please run the before_commit rake task to install `overcommit` and the associated tasks

```bash
rake app:before_commit:run
```

And use before_commit to keep the overcommit configuration up to date.

### Database connection

As this is an engine, there is a test application set up at spec/dummy. Before
using dummy, you will need to create `spec/dummy/.env` containing the Postgres
database username and password you wish to use. See `spec/dummy/.env.example`

## Error reporting

The engine includes the airbrake gem, and will try to post production errors to an errbit server
which must be configured via the ENV variables

```ruby
AIRBRAKE_HOST = "https://airbrake_or_errbit_server"
AIRBRAKE_PROJECT_KEY ="<api key>"
```

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
