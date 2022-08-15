# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

* Step To Tests
1. rake db:seed
2. start server
3. Access http://localhost:3000/api-docs/index.html
4. create Registration with email
```
curl -X 'POST' \
  'http://localhost:3000/api/v1/auth' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "email": "string+6@gmail.com",
  "password": "string",
  "password_confirmation": "string"
}'
```
Access token return from server to crete recipes, rating
```
access-token: kGNW83_wkF3yPIQgSUOhSQ 
uid: string+6@gmail.com
client: ZckqU6NNrWa8uLtd_yatmQ
```

