# Classipi [![Build Status](https://travis-ci.org/Coolnesss/classipi.svg?branch=master)](https://travis-ci.org/Coolnesss/classipi) [![Code Climate](https://codeclimate.com/github/Coolnesss/classipi/badges/gpa.svg)](https://codeclimate.com/github/Coolnesss/classipi)

A (currently text) classification API built with Rails.

Allows each user to retain a machine learning classification model on the server associated with their API key. Training data can be added and new data can be classified via queries.

Hosted at [https://classipi.heroku.com](https://classipi.heroku.com)

### Usage

Some examples:

Registration
```ruby
[1] pry(main)> require 'restclient'
=> true
[2] pry(main)> url = "https://classipi.herokuapp.com"
=> "https://classipi.herokuapp.com"
[3] pry(main)> RestClient.post url+"/register", {email: "your@email.com"}
=> <RestClient::Response 200 "{\"api_key\":...">
[4] pry(main)> _.body
=> "{\"api_key\":\"WqV8fS82UahND3B9V7y14gtt\",\"note\":\"Your registration is complete. Be sure to save the API key, you won't get it back later.\"}"

```
Training
```ruby
[11] pry(main)> api_key = "WqV8fS82UahND3B9V7y14gtt"
=> "WqV8fS82UahND3B9V7y14gtt"
[12] pry(main)> RestClient.post url+"/train", {data: data, label: label}, {Authorization: "Token token=#{api_key}"}
=> <RestClient::Response 200 "{\"success\":...">
[13] pry(main)> _.body
=> "{\"success\":\"Training enqued\"}"

```

Classification

```ruby
[14] pry(main)> data = "highly interesting"
=> "highly interesting"
[15] pry(main)> RestClient.post url+"/classify", {data: data}, {Authorization: "Token token=#{api_key}"}
=> <RestClient::Response 200 "{\"label\":\"I...">
[16] pry(main)> _.body
=> "{\"label\":\"Interesting\"}"

```
