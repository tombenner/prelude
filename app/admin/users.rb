ActiveAdmin.register User do
  actions :all, :except => [:new] 
  
  filter :username
  filter :email
  filter :last_sign_in_at
  filter :created_at
  
  index do
    column :id
    column :username
    column :last_sign_in_at
    column :created_at
    default_actions
  end
  form do |f|
    f.inputs "Password" do
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
  
  controller do
    def update
      unset_blank_password
      update! do |format| 
        @user = User.find(params[:id])
        format.html { redirect_to edit_admin_user_path(@user) } 
      end
    end
    
    def unset_blank_password
      if !params[:user].blank? && params[:user][:password].blank?
        params[:user].delete(:password).delete(:password_confirmation)
      end
    end
  end
end
