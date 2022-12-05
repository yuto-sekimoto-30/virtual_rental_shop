ActiveAdmin.register User do
  menu label: "一般" + User.model_name.human
  permit_params :name, :email, :password, :password_confirmation
  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
  
end
