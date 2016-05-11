# Minitest::AnonymousController

A primitive anonymous controller in Minitest.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minitest-anonymous_controller'
```

## Usage

The typical use-cases for anonymous controllers are to test filters defined in a base controller.

__ApplicationController__

```ruby
class ApplicationController < ActionController::Base

  ...

  private

  def not_authenticated # <= Think if you want to test this filter
    redirect_to login_url, alert: 'Please login first'
  end

  ...

end
```

__ApplicatinControllerTest__

```ruby
require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  extend Minitest::AnonymousController

  ApplicationController.insert_dummy_action

  test 'should redirect someone without logging in to login page' do
    ApplicationController.stub_any_instance(:current_user, nil) do
      get dummy_action_url # <= Now you can test the filter via the dummy action
      assert_equal 'Please login first', flash[:alert]
      assert_redirected_to login_url
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/5t111111/minitest-anonymous_controller.

## Thanks

http://stackoverflow.com/a/26604833
