# CloudbleedChecker

A utility to check your browser history for any sites hosted by Cloudflare,
this will give you an easy way to determine where you need to change your
password. It currently only checks Chrome, Firefox and Safari on macOS since
that's what I used to develop it, adding support for linux et. al. should only
require knowing which paths to look in for the history databases.

## Installation

    `$ gem install cloudbleed_checker`

## Usage

`cloudbleed check`

The output from that command will include a bit of diagnostic info and a list
of sites you've visited since the security vulnerabilities were introduced
and are fronted by Cloudflare.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tpickett66/cloudbleed_checker.

