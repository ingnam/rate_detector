# Rate Detector

Volume rate detector app

## Dependencies

Ruby Version

```ruby
ruby-2.5.5
```
## Runing the app
Clone the app from github
```ruby
git clone git@github.com:ingnam/rate_detector.git
```

Install dependencies
```ruby
bundle install
```
Change to the app directory:
```ruby
cd rate_detector
```
And finally run the app:

```ruby
ruby rate_detector.rb <csv_file> <rate_of_change>
```

Example
```ruby
ruby rate_detector.rb volumes.csv 100
```
## Runing the tests

```ruby
rspec spec
```
