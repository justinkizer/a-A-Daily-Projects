require 'date'

class Cat < ActiveRecord::Base
  validates :name, presence: true, uniqueness: {scope: :birth_date}
  validates :birth_date, :name, :description, presence: true
  validates :color, presence: true, inclusion: { in: %w(Black White Gray Orange Blue Yellow Brown),
    message: "%{value} is not a valid cat color" }
  validates :sex, presence: true, inclusion: { in: %w(M m F f),
    message: "%{value} is not a valid cat sex" }
  validate :birth_date_is_in_the_past

  def age
    age = DateTime.now - self[:birth_date]
    age = age.to_f / 365
    age.to_i
  end

  def birth_date_is_in_the_past
    unless self[:birth_date] < DateTime.now
      errors[:birth_date] << "cannot be in the future (no space cats)"
    end
  end

  def color_code
    COLORS[self.color.to_sym]
  end

  def self.colors
    COLORS.keys
  end

  COLORS = {
    Black: "#000000", Gray: "#808080", White: "#FFFFFF",
    Yellow: "#FFFF00", Red: "#FF0000", Blue: "#0000FF",
    Purple: "#800080", Olive: "#808000", Orange: "#FF0000"
  }

end
