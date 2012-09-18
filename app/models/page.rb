class Page < ActiveRecord::Base
  validates_presence_of :key

  auto_strip_attributes :key, :title, :content
end
