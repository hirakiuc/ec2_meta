# Ec2Meta

[![Build Status](https://travis-ci.org/leonis/ec2_meta.svg?branch=master)](https://travis-ci.org/leonis/ec2_meta)
[![Coverage Status](https://coveralls.io/repos/leonis/ec2_meta/badge.svg)](https://coveralls.io/r/leonis/ec2_meta)
[![Code Climate](https://codeclimate.com/github/leonis/ec2_meta/badges/gpa.svg)](https://codeclimate.com/github/leonis/ec2_meta)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/ec2_meta`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ec2_meta'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ec2_meta

## Usage

### Get Client

```
client = Ec2Meta.client(
  logger: Logger.new($stdout),
  fail_on_not_found: true
)
```

#### options

name | default | description
---- | ------- | ------------
logger | Ec2Meta::NullLogger.new | Pass your logger if you want
fail_on_not_found | false | If set true, raise error on metadata not found.

### Get Meta

Currently supports all of `Instance metadata` on [Instance Metadata and User Data - Instance Metadata Categories](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html#instancedata-data-categories) at this time.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/ec2_meta/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
