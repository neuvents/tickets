class NotFoundError < Error
  attr_reader :errors

  def code
    404
  end
end
