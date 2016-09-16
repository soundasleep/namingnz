namingnz [![Build Status](https://travis-ci.org/soundasleep/namingnz.svg?branch=master)](https://travis-ci.org/soundasleep/namingnz)
========

Tools to help Naming NZ volunteers manage their applicants.

# TODO MVP

1. Setup on Heroku
1. /dashboard
1. /applicants
1. /helpers
1. /groups
1. /cheques
1. Email reminders to helpers

# TODO nice to have

1. Tests with cucumber?
1. Profile images
1. /users
1. Users can be disabled (`disabled_at`)
1. Screenshots in readme

# Install

Login to your [Google Developers Console](https://console.developers.google.com/project), create a new Project, and:

1. APIs: enable Contacts API and Google+ API
1. Consent screen: make sure you have an email and product name specified
1. Credentials: create a new Client ID of type web applicaton, setting your Redirect URI to http://localhost:3000/auth/google_login/callback

Edit `.env` with your new keys, and `database.yml` with your database configuration. Run `rake db:migrate` to setup the database.

# Testing

`bundle exec rspec`

`rake cucumber`
