class ApplicationSerializer < Serializr
  def render_one(object, serializer: nil)
    return if object.nil?

    serializer ||= serializer_class_cache[object.class]
    serializer.new(object)
  end

  def render_many(objects, serializer: nil)
    return [] if objects.blank?

    serializer ||= serializer_class_cache[objects.first.class][]
    serializer.new(objects)
  end
end
