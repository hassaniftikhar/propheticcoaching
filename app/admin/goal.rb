ActiveAdmin.register Goal do

  permit_params :id, :body,:mentee_id
  belongs_to :mentee

end
