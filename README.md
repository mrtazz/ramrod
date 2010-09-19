# Ramrod - CI Command Center/Aggregator

## What's this?
Ramrod is a central command center for multiple [Continuous Integration][ci]
instances. It acts as a central management point for your code base. You can
notify Ramrod from your SCM server and it tells its agents about it. The
agents then fetch the code, build the software, run the tests and inform
Ramrod about the result.

## Motivation
My master's thesis project includes a software which has to run on Windows,
Unix/Linux and the iPhone. I definitely wanted to have an easy-to-use build
environment. However the build machines include Windows laptops, an old iMac
and a FreeBSD server. Not all of these are suitable for a whole CI installation
and I wanted to be able to easily add new machines.

## API
Ramrod exposes a simple REST-like API for build notifications. If your
Ramrod instance is protected by HTTP Basic Auth, the corresponding
credentials have to be used.

### SCM notification
Ramrod can be notified via a simple POST receive URL.

    POST http://ramrod.domain/:projectname/build

### Agent Notification
A URL for every agent can be configured. Ramrod will then do a HTTP POST to
this URL for every agent.

## Agents

### Custom Agents
Simple custom agents can easily be created for use with Ramrod.
They just have to accept HTTP POST on a URL to build the project. After the
build (and tests), the agents have to notify Ramrod with a PUT to the
following URL:

    PUT http://ramrod.domain/:project/notify

The body of the notification should contain the following data:

    token = token
    success = true/false
    name = name of the updating agent

`token` contains the corresponding authorization token and `success` defines
whether the build was successful or not. `name` contains the name of the
updating agent.


### [CIJoe][cijoe] as an agent
The simple and powerful cijoe can be easily used as an agent. You can tell him
to build via POST to the base URL. For callback notification, you have to
implement the hooks `.git/hooks/build-failed` and `.git/hooks/build-worked` to
contain a shell script which does a
`curl -X PUT -d"token=bla&success=true&name=foo" http://ramrod.domain`.


### [Integrity][integrity] as an agent
Integrity can also be used as an agent. It incorporates an HTTP notifier which
can be used as a callback. However token based authorization does not work with
integrity.

## TODO

* Notification system
* Nicer design
* Tests
* Edit agents
* Authentication

## Installation
Just clone the repository and run the executable:

    git clone http://github.com/mrtazz/ramrod.git
    bundle install
    ./bin/ramrod

### Dependencies
For dependencies see `Gemfile`.

## Contributing
If you want to contribute to ramrod:

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don’t break it in a future version unintentionally.
* Commit, do not mess with version
* Send me a pull request. Bonus points for topic branches.


## Deploy
Ramrod has a simple structure, as it doesn't build anything itself. You should
be able to easily deploy it to a hosting provider like [Heroku][heroku].

## Thanks to and inspired by

* [integrity][integrity]
* [cijoe][cijoe]



[ci]: http://en.wikipedia.org/wiki/Continuous_integration
[integrity]: http://integrityapp.com/
[cijoe]: http://github.com/defunkt/cijoe
[heroku]: http://heroku.com
