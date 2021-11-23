# README

To generate test data

* docker-compose up --build
* docker-compose run salon_app bundle exec rake db:migrate
* docker-compose run salon_app bundle exec rake db:seed
* docker-compose run salon_app bundle exec rake clean_slots:for_today
* docker-compose run salon_app bundle exec rake generate_slots:for_today
* docker-compose up