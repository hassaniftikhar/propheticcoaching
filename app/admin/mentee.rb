ActiveAdmin.register Mentee do

  permit_params :first_name, :last_name, :email, :donor_id, :home_phone,
                :availability, :prophecy, :bc

  #
  #collection_action :import_csv, :method => :post do
  #  # Do some CSV importing work here...
  #  puts "import_csv post #{params.inspect}"
  #
  #end


  collection_action :import_csv, :method => [:get, :post] do
    puts "import_csv get #{params.inspect}"
    if request.method == "GET"
      @mentee = Mentee.new
      render :partial => "import_csv"
    else
      p "===== #{params[:mentee][:csv].tempfile.to_path.to_s}"
      file = params[:mentee][:csv].tempfile.to_path.to_s
      Mentee.import_csv file

      redirect_to admin_mentees_url, flash: { message: "successfully imported csv" }
    end
  end



  index do
    column :first_name
    column :last_name
    column :email
    column :donor_id
    column :home_phone
    column :availability
    column :prophecy do |mentee|
      "#{mentee.prophecy[0..50]} ..." if mentee.prophecy.present?
    end
    column :bc
    default_actions
  end

  form do |f|
    f.inputs "details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :donor_id
      f.input :home_phone
      f.input :availability
      f.input :prophecy
      f.input :bc
    end
    f.actions
  end

end
