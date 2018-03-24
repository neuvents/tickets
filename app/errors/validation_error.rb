class ValidationError < Error
  attr_reader :errors

  def initialize(errors)
    @errors = errors
  end

  def code
    422
  end
end
