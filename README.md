# Ramrod - CI Command Center/Aggregator

## What's this?
Ramrod is a central command center for multiple [Continuous Integration][ci]
instances. It acts as a central management point for your code base. You can
notify Ramrod from your SCM server and it tells its agents about it. The
agents then fetch the code, build the software, run the tests and inform
Ramrod about the result. Depending on the result, Ramrod then notifies
the developers via various notifiers (e.g. email, irc, campfire, notifo).

## Motivation
My master's thesis project includes a software which has to run on Windows,
Linux and the iPhone. I definitely wanted to have an easy-to-use build
environemnt. However the build machines include Windows laptops, an old iMac
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

The body of the notification should contain JSON in the following format:

    { :token => token, :success => true/false }

:token contains the corresponding authorization token (if set) and :success defines
whether the build was successful or not.


### [CIJoe][cijoe] as an agent
The simple and powerful cijoe can be easily used as an agent. You can tell him
to build via POST to the base URL. For callback notification, you have to
implement the hooks `.git/hooks/build-failed` and `.git/hooks/build-worked` to
contain a shell script which does a `curl -X POST http://Ramrod.domain` with
the corresponding JSON payload.


### [Integrity][integrity] as an agent
Integrity can also be used as an agent. It incorporates an HTTP notifier which
can be used as a callback. However token based authorization does not work with
integrity.

## Notifications
Ramrod can notify about build results via E-Mail, [Campfire][campfire], IRC,
HTTP and [notifo][notifo]. You just have to mark the corresponding notifier in
the project administration panel.


## Installation
Just clone the repository and run the executable:

    git clone http://github.com/mrtazz/ramrod.git
    ./bin/ramrod

### Dependencies
Ramrod depends on the following gems and libraries:

* sinatra
* mustache
* JSON
* dm-core
* sinatra-ditties
* shout-Bot
* broach
* notifo

## Deploy
Ramrod has a simple structure, as it doesn't build anything itself. You can
easily deploy it to [Heroku][heroku].

## Thanks to and inspired by

* [integrity][integrity]
* [cijoe][cijoe]



[ci]: http://en.wikipedia.org/wiki/Continuous_integration
[integrity]: http://integrityapp.com/
[cijoe]: http://github.com/defunkt/cijoe
[notifo]: http://notifo.com
[campfire]: http://campfirenow.com/
