# Rails server

## Setup

Dependencies
* Ruby `2.6.2`
* `bundler` gem
* PostgreSQL [installed + configured](https://www.postgresql.org/docs/10/tutorial-start.html)

```bash
bundle install
sudo -u postgres createuser -s rails-server
bundle exec rails db:setup
bundle exec rails db:migrate
bundle exec rails s
```

## Tests

```bash
bundle exec rspec
```
