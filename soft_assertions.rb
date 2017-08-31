# encoding: UTF-8
module Minitest
  ##
  # Minitest Soft Assertions.  
  # soft_assert will add error message to array, and will not throw execption
  # assert all will check the error message array, if there is any errors, will throw execption, just lik the assert
  class Runnable
     attr_accessor :soft_assertion_messages
  end
  
  module Assertions 
    
    def soft_assert test, msg = nil
      self.soft_assertion_messages=[] if self.soft_assertion_messages.nil?
      self.assertions += 1
      unless test then
        msg ||= "Expected #{mu_pp test} to be truthy."
        self.soft_assertion_messages << msg 
        msg = msg.call if Proc === msg  
      end
    end

    def soft_assert_all
      self.soft_assertion_messages=[] if self.soft_assertion_messages.nil?
      unless slef.soft_assertion_messages.empty?
          raise Minitest::Assertion, self.soft_assertion_messages.join(";\n")
      end
      true
    end

  end
end
