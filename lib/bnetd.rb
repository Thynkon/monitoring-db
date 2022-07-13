# frozen_string_literal: true

require_relative "bnetd/version"

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup # ready!

module Bnetd
  class Error < StandardError; end
end
