require "family/tree/version"
require "family/tree/person"
require "family/tree/cohort"
require "family/tree/builder"
require "family/tree/relations"
require "family/tree/executor"
require "family/tree/command"
require "family/tree/cli"
module Family
  module Tree
    FILE_NOT_SUPPORTED_ERROR = "Only txt files are supported currently.".freeze
    ACCEPTED_FORMATS = [".txt"]

    class Error < StandardError; end
    class FileFormatNotSupportedError < StandardError
        def initialize
          super(FILE_NOT_SUPPORTED_ERROR)
        end
    end
  end
end
