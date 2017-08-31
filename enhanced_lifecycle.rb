# encoding: UTF-8
module Minitest
  ##
  # Minitest Soft Assertions.  
  # soft_assert will add error message to array, and will not throw execption
  # assert all will check the error message array, if there is any errors, will throw execption, just lik the assert
  class Runnable
     attr_accessor :soft_assertion_messages

     def self.before_suite
         
     end
     
     def self.after_suite
     end

     def self.run reporter, options = {}
      filter = options[:filter] || "/./"
      filter = Regexp.new $1 if filter =~ %r%/(.*)/%

      filtered_methods = self.runnable_methods.find_all { |m|
        filter === m || filter === "#{self}##{m}"
      }

      exclude = options[:exclude]
      exclude = Regexp.new $1 if exclude =~ %r%/(.*)/%

      filtered_methods.delete_if { |m|
        exclude === m || exclude === "#{self}##{m}"
      }

      return if filtered_methods.empty?

      with_info_handler reporter do
        before_suite
        filtered_methods.each do |method_name|
          run_one_method self, method_name, reporter
        end
        after_suite
      end
    end
  end
  
end
