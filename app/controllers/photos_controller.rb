class PhotosController < ApplicationController

    def new
      if params[:id] == 'upload'
          File.open(upload_path, 'w') do |f|
            f.write request.raw_post
          end
          
          person = Image.find(:all, :conditions=>["person_id=?", session[:patient_id_photo]])
          
          person.each do |p|
          	p.voided=1
          	p.save
          end if !person.nil?
          
					image = Image.new()
					image.person_id=session[:patient_id_photo]
					image.image = request.raw_post
					image.save
          
          render :text => "ok"
          
       else
           session[:patient_id_photo] = params[:id]
       end
       
    end
    
    def upload
      File.open(upload_path, 'w') do |f|
        f.write request.raw_post
      end
      render :text => "ok"
    end
     
    private
     
    def upload_path # is used in upload and create
      file_name = session[:patient_id_photo].to_s + '.jpg'
      File.join(RAILS_ROOT, 'public', 'uploads', file_name)
    end

end
