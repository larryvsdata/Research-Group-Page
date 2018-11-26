class Professor < ActiveRecord::Base
has_many :postdocs
has_many :grads , through: :postdocs
has_secure_password


def slug
  self.name.strip.downcase.gsub(" ",'-')
end

def self.find_by_slug (slug)
  self.all.find{|user| user.slug==slug}
end

end
