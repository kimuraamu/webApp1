class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user,{only: [:edit,:update,:destroy]}
  def index
    #@posts = Post.all
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @id = params[:id]             #URL後部の値
    @post = Post.find_by(id: @id)
    @user = @post.user
    @table = "NewBoard"+@id      #@idに対応するテーブルの文字列を生成

    begin
      @tweets =@table.constantize.all.order(created_at: :desc)  #テーブルを降順で格納
    rescue
      @tweets =Nottable.all
      @table = "not"
    end
  end

  def newpos
    @post = Post.new
  end

  def create
    @post = Post.new(content: params[:title],user_id: @current_user.id)
    if @post.save

      #絶対パス使用してます
      command = "sh /home/koizumi/kimura/chat/MakeTable.sh "+@post.id.to_s
      if system(command) #コマンドを実行
        flash[:notice] = "投稿"
      end
      redirect_to("/index")
    else
      flash[:notice] = '失敗'
      redirect_to("/index")
    end
  end

  def create_tweet  #新規書き込み
    @id = params[:id]
    table = "NewBoard"+@id
    @tweet = table.constantize.new(content: params[:tweet],user_id: @current_user.id)
    @tweet.save

    if @tweet.has_attribute?(:imagename)
      if params[:image]
        @tweet.imagename = table+"_#{@tweet.id}.jpg"
        image = params[:image]
        File.binwrite("/home/koizumi/kimura/chat/public/uploads/#{@tweet.imagename}",image.read)
      end
    end
    @tweet.save


    redirect_to("/posts/#{@id}")
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:detail]
    if
      @post.save
      flash[:notice] = "編集しました"
      redirect_to("/index")
    else
      render("posts/edit")
    end
  end

  def newshow
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @tweet = table.constantize.find_by(content: params[:tweet],user_id: @current_user.id)
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/index")
  end

  def destroy_tweet
    @id = params[:id]
    @tid = params[:tid]
    table = "NewBoard"+@id
    @tweet = table.constantize.find_by(id: @tid)
    @tweet.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/#{@id}")
  end


  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/index")
    end
  end

  def top

  end
end
