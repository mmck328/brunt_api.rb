# BruntAPI

This is an unofficial Ruby binding for Brunt API. Ported from [JS binding by MattJeanes](https://github.com/MattJeanes/brunt-api).

Currently this gem support operations only for Brunt Blind Engine.

## Installation

```ruby
gem 'brunt_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brunt_api

## Usage
### Preparation
```ruby
client = BruntAPI::Client.new
client.login('brunt_account_id', 'password')
```
### Get things infomation
```ruby
client.get_things
```
### Get thing state
```ruby
client.get_state('thing_uri')
```
`'thing_uri'` can be obtained by `BruntAPI::Client#get_things`.

### Set blind position via Blind Engine
```ruby
client.set_position('thing_uri', position)
```
`position` must be `Numeric` in range 0-100.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mmck328/brunt_api.rb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
