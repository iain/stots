class Setting < ActiveRecord::Base

  validates_presence_of :group

  validates_presence_of :key
  validates_uniqueness_of :key, :scope => :group, :case_sensitive => false

  def self.group(group)
    where(:group => group)
  end

  def self.key(key)
    where(:key => key)
  end

  def self.value
    pluck(:value).first
  end

  def self.value_of(group, key)
    group(group).key(key).value
  end

  def self.to_hash
    Hash[scoped.map(&:to_pairs)]
  end

  def to_pairs
    [ key, value ]
  end

  def reader_name
    "#{group}_#{key}"
  end

  def writer_name
    "#{reader_name}="
  end

end
