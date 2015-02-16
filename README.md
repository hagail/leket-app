# Leket

[![Build Status](https://travis-ci.org/hagail/leket-app.svg?branch=master)](https://travis-ci.org/hagail/leket-app)

## Table of contents
- [Getting started](#getting_started)
  - [Source code](#source_code)
  - [Heroku](#heroku)
  - [Postgres](#postgres)

<a id="getting_started"></a>
## Getting started

<a id="source_code"></a>
### Source code
Get the Leket source code:

  git clone git@github.com:hagail/leket-app.git

<a id="heroku"></a>
### Heroku
Run the following command:

  heroku git:remote -a leket-app

<a id="postgres"></a>
### Postgres
In our development and testing environments we use Postgres databases. In order to run your tests or application locally you need to install a Postgres server in your laptop. To install it:

  brew install postgres

If this is your first time running the project, make sure a postgres server is running:

  pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start