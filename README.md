# Stots

Stots is a dashboard that combines activity on different services into one nice dashboard.

Current status: Brain fart, experimental stuff and so on.

## Features

### Show overviews of activity on different services per project

We use a lot of different services for developing software. Like Github for our source code, Pivotal
Tracker for our project management, Airbrake for error tracking and so on. These services are
perfect at what they do and we love them to bits.

But it can be a bit confusing some times. We have so many websites to keep track of, it's no wonder
that we sometimes lose sight of some messages. Stots helps you centralize everything in one place.
You'll still need to visit those services to do actual work, but you'll know you have to, by looking
at Stots.

### Visualize activity in insightful ways

Do you have the feeling that you're rushing at the end of iterations to get things done? Did you
increase the amount of errors since you switched some library? These patterns are hard to see when
all you see is long lists.

Stots will try to visualize multiple aspects of building software and combine them in instersting
ways. Now you can see how one thing influences the other.

### Plugin architecture to add new services

New services are coming and going regularly. Stots uses the power of Rails engines to add new
features and new services in a snap.


## Todo

Practically all of the above.


## Usage

It's a Rails app, so it shouldn't be too difficult if you've installed one before.

```
bundle install
rails server
```

Go to settings and add your API keys.

When you entered your API keys, you can do:

```
ruby script/pivotal_tracker.rb
ruby script/airbrake_projects.rb
GET_MORE=true ruby script/airbrake_errors.rb
```

After that, go and add projects in the web interface.
