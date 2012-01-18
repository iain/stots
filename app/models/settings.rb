class Settings

  include ActiveModel::Conversion
  include ActiveModel::Validations

  def self.fields
    Setting.all.map { |setting| "#{setting.group}_#{setting.key}" }
  end

  def self.new(*)
    attr_accessor *Setting.all.map(&:reader_name)
    super
  end

  def persisted?
    true
  end

  def id
    1
  end

  def initialize
    settings.each do |setting|
      send(setting.writer_name, setting.value)
    end
  end

  def save(attributes)
    Setting.update attributes.keys, attributes.values
  end

  def each
    settings.group_by(&:group).each do |group, settings|
      yield FormValues.new(group, settings)
    end
  end

  private

  def settings
    @settings ||= Setting.all
  end

  FormValues = Struct.new(:name, :settings) do

    def each
      settings.each do |setting|
        yield "#{name}_#{setting.key}", "settings[#{setting.id}][value]"
      end
    end

  end

end
