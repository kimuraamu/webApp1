class UsersController < ApplicationController
  before_action :authenticate_user,{only:[:index,:show,:edit,:update]}
  before_action :forbid_login_user, {only: [:newuser,:create,:login_form,:login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  #before_action :set_user
  def show
    @user = User.find_by(id: params[:id])
  end

  def newuser
    @user = User.new
  
  end

  def create
    @user = User.new(name: params[:name],email: params[:email],password: params[:password],
    image_name: "黒猫.png")
    respond_to do |format|
      if @user.save
        UserMailer.send_mail(@user).deliver_now
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
        #flash[:notice] = "ユーザー登録が完了しました"
        #redirect_to("/users/#{@user.id}")
      else
        format.html { render :newuser }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        #render("users/newuser")
      end
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("/home/koizumi/kimura/chat/public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form

  end
  def login
      @user = User.find_by(email: params[:email], password: params[:password])
      if @user
          session[:user_id] = @user.id
          flash[:notice] = "ログインしました"
          redirect_to("/")
      else
          @error_message = "メールアドレスまたはパスワードが間違っています"
          @email = params[:email]
          @password = params[:password]
          render("users/login_form")
      end
  end
  def logout
      session[:user_id] = nil
      flash[:notice] = "ログアウトしました"
      redirect_to("/login")
  end
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/index")
    end
  end
  
end
