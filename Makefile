include .env
export

install:
	bundle install

start:
	bundle exec rails server -b 0.0.0.0 -p $(PORT) -e $(RAILS_ENV)

migrate:
	rails db:migrate

downgrade-db:
	rails db:rollback

db-load-schema:
	rails db:schema:load

seed: migrate
	rails db:seed

db-setup:
	rails db:setup

init-guard:
	bundle exec guard init

run-guard:
	bundle exec guard
