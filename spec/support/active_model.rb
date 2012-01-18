require 'active_model'

# spec/support/active_model_lint.rb
# adapted from rspec-rails:
# http://github.com/rspec/rspec-rails/blob/master/spec/rspec/rails/mocks/mock_model_spec.rb

shared_examples_for ActiveModel do

  include ActiveModel::Lint::Tests

  # to_s is to support ruby-1.9
  ActiveModel::Lint::Tests.public_instance_methods.map{|m| m.to_s}.grep(/^test/).each do |m|
    example m.gsub('_',' ') do
      send m
    end
  end

  def model
    subject
  end

  def assert(expected, message = nil)
    expected.should be_true, message
  end

  def assert_kind_of(expected, actual, message = nil)
    actual.should be_kind_of(expected), message
  end

end
