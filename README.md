# SmsAero2

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sms_aero2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sms_aero2

## Usage

```ruby
client = SmsAero2::Client.new(login: 'some_email@example.com', token: 'some_token', logger: SomeLogger)

client.send_sms(to: 79998887766, from: 'SomeCompany', text:'Hello World!', channel: :international)
client.hlr_status(id: '1234')
client.hlr(phone: '79998887766')

```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
