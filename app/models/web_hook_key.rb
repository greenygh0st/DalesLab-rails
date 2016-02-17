class WebHookKey < ActiveRecord::Base
  before_save { self.key =  }
end
