require "rspec"

PROJECT_ROOT = File.expand_path('../..', __FILE__)

$LOAD_PATH <<
  File.join(PROJECT_ROOT, 'lib', '*.rb') <<
  File.join(PROJECT_ROOT, 'spec')

require 'support/factory'
require 'support/custom_matchers'
