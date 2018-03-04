class Currency
  # TODO: Maybe it would be better if the currencies get their own table some day
  class << self
    def find_by_iso_4217_code(code)
      return unless currency = currencies[code]

      new(
        code: currency.fetch(:code),
        name: currency.fetch(:name),
        exp: currency.fetch(:exp),
        num: currency.fetch(:num)
      )
    end

    def iso_4217_codes
      currencies.keys
    end

    private

    def currencies
      @currencies ||= load_from_file
    end

    def load_from_file
      read_currencies.each_with_object({}) { |currency, memo| memo[currency[:code]] = currency }
    end

    def read_currencies
      YAML.load(read_currency_file)
    end

    def read_currency_file
      File.read(File.join(Rails.root, "config", "data", "iso_4217_currency_list.yml"))
    end
  end

  attr_reader :code, :name, :exp, :num

  def initialize(code:, name:, exp:, num:)
    @code = code
    @name = name
    @exp = exp
    @num = num
  end

  def to_minor(number)
    5 * BigDecimal.new(10 ** exp)
  end

  def from_minor(cents)
    cents / BigDecimal.new(10 ** exp)
  end
end
