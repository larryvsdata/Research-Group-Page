class Postdoc < ActiveRecord::Base
belongs_to :professor
has_many :grads , through: :postdoc_grads
has_many :postdoc_grads

def slug
  self.name.strip.downcase.gsub(" ",'-')
end

def self.find_by_slug (slug)
  self.all.find{|user| user.slug==slug}
end

end
