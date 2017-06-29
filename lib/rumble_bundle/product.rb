# Product instances will hold metadata for individual products, such as name, platform(s), or license

class RumbleBundle::Product

  attr_accessor :name, :subtitle, :bundle, :tier, :platforms, :drm, :steam_key

  @@all = []

  def self.all
    @@all
  end

  def self.clear_all
    self.all.clear
  end

  def initialize(data_hash)
    data_hash.each{|key, val| self.send("#{key}=", val)}
    self.class.all << self
  end

end