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

    PERSON_NOT_FOUND_ERROR = "PERSON_NOT_FOUND".freeze
    CHILD_ADDITION_FAILED_ERROR = "CHILD_ADDITION_FAILED".freeze

    CHILD_ADDED_SUCCESS_MESSAGE = "CHILD_ADDED".freeze

    class Error < StandardError; end

    class FileFormatNotSupportedError < StandardError
      def initialize
        super(FILE_NOT_SUPPORTED_ERROR)
      end
    end

    class PersonNotFoundError < StandardError
      def initialize
        super(PERSON_NOT_FOUND_ERROR)
      end
    end

    class ChildAdditionFailedError < StandardError
      def initialize
        super(CHILD_ADDITION_FAILED_ERROR)
      end
    end
  end
end
