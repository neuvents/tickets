module Testing
  module JSONAssertions
    def assert_as_json(object, expected)
      assert_equal _normalize_jsonable(expected.as_json), _normalize_jsonable(object.as_json)
    end

    def assert_json(json, expected)
      assert_as_json JSON.parse(json), expected
    end

    private

    def _normalize_jsonable(json)
      case json
      when Hash
        json.deep_stringify_keys
      when Array
        json.map { |element| _normalize_jsonable(element) }
      else
        json
      end
    end
  end
end
