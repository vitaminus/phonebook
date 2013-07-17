class UploadsController < ApplicationController

  # def file_upload  
  #   respond_to do |format|
  #     format.html {
  #       require 'fileutils'
  #       tmp = params[:file_upload][:file].tempfile
  #       file = File.join("public", params[:file_upload][:file].original_filename)
  #       FileUtils.cp tmp.path, file
  #       # YOUR PARSING JOB
  #       FileUtils.rm file
  #     }
  #     format.js {}
  #   end
  # end

  def create
    respond_to do |format|
      format.html {
        name = params[:upload][:file].original_filename
        directory = "public/upload"
        path = File.join(directory, name)
        File.open(path, "wb") { |f| f.write(params[:upload][:file].read) }
        str = File.open(path)
        str.each_line do |s|
          s = s.split
          if s.count == 5
            Phone.create(name: "#{s[0]} #{s[1]} #{s[2]}", phone: "#{s[3]} #{s[4]}")
          elsif s.count == 3
            Phone.create(name: "#{s[0]}", phone: "#{s[1]} #{s[2]}")
          else
            Phone.create(name: "#{s[0]} #{s[1]}", phone: "#{s[2]} #{s[3]}")
          end
        end
        flash[:success] = "File uploaded and data added to database"
        redirect_to "/admin"
      }
      format.js {}
    end
  end

  private

    def uploads_params
      params.require(:upload).permit(:file)
    end

end
