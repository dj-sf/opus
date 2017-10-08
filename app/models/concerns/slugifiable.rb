module Slugify

  def slug
    self.name.gsub(/[,:']/, '').gsub(' ', '-').downcase
  end

end
