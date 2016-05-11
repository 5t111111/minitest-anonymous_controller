require 'minitest/anonymous_controller/version'

module Minitest
  module AnonymousController
    def insert_dummy_action
      # Define dummy action for testing in ApplicationController class context
      self.class_eval do
        def dummy_action
          render :nothing
        end
      end

      # Disable clrearing routes on Rails.application.routes.draw
      ::Rails.application.routes.disable_clear_and_finalize = true

      # Set a route for dummy action
      ::Rails.application.routes.draw do
        get 'dummy_action' => 'application#dummy_action'
      end
    end
  end
end

ActionController::Base.extend Minitest::AnonymousController
