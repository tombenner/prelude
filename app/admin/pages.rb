ActiveAdmin.register Page do
  filter :key
  filter :title
  
  index do
    column :id
    column :key
    column :title
    default_actions
  end

  form do |f|
    f.inputs "Page" do
      f.input :title
      f.input :key
      f.input :content
    end
    f.buttons
  end

  controller do
    def update
      page = Page.find(params[:id])
      update! do |format|
        format.html { redirect_to edit_admin_page_url(page.id) }
      end
    end
  end
end
