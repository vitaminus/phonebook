class PhonesController < ApplicationController
  
  before_action :phone_find,    only: [:show, :edit, :update, :destroy]
  before_action :all_phones,    only: [:admin, :create, :update, :destroy]
  before_action :authenticated, only: [:admin]
  
  def index
    @phones = Phone.search(params[:search]).page(params[:page]).per_page(10)
  end

  def show
  end

  def new
    @phone = Phone.new
  end

  def create
    @phone = Phone.new(phone_params)
    if @phone.save
      respond_to do |format|
        format.html {
          flash[:success] = "Phone succesful added"
          redirect_to new_phone_path
        }
        format.js {}
      end
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @phone.update_attributes(phone_params)
      respond_to do |format|
        format.html {
          flash[:success] = "Update succesful"
          redirect_to root_path
        }
        format.js {}
      end
    else
      render 'edit'
    end
  end

  def destroy
    @phone.destroy
    respond_to do |format|
      format.html {
        redirect_to admin_path
      }
      format.js {}
    end
  end

  def admin
    if authenticated
      respond_to do |format|
        format.html {}
        format.js {}
      end
    else
      redirect_to root_path
    end
  end

  private

    def phone_params
      params.require(:phone).permit(:name, :phone)
    end

    def phone_find
      @phone = Phone.find(params[:id])
    end

    def all_phones
      @phones = Phone.page(params[:page]).per_page(50)
    end

    def authenticated
      authenticate_or_request_with_http_basic('Administration') do |username, password|
        #password - birds
        md5_of_password = Digest::MD5.hexdigest(password)
        username == 'admin' && md5_of_password == '75c73f175a85cee384f32a5608eb67d1'
      end
    end
end
