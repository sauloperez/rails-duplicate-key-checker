module RailsDuplicateKeyChecker
  class Backend
    def initialize(database, user)
      @database = database
      @user = user
    end

    def run
      Kernel.system("pt-duplicate-key-checker D=#{database} -u #{user}")
    end

    # TODO: Using $? we might get the exit status of any process previously
    # executed
    def success?
      $?.exitstatus.zero?
    end

    private

    attr_reader :database, :user
  end
end
