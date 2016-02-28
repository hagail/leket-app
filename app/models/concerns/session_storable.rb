module SessionStorable
  extend ActiveSupport::Concern

  class_methods do
    def from_session(session)
      Marshal::load(Base64.decode64(session[name.underscore]))
    end

    def use(session)
      obj = from_session(session)
      response = yield obj
      obj.save_in_session(session)
      response
    end
  end

  def save_in_session(session)
    session[self.class.name.underscore] = Base64.encode64(Marshal.dump(self))
  end
end
