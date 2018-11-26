class PostdocGrad < ActiveRecord::Base
  belongs_to :grad
  belongs_to :postdoc

end
