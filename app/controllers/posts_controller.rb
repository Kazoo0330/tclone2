class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  before_action :must_login, only: [:new, :edit, :show]
  # ログインしてないのはみんなTOPに飛べ
  def index
    # @posts = Post.all.order(created_at: :desc)
	  @posts = Post.page(params[:page]).per(5)
	  # @posts = Post.paginate(page: params[:page])
   @search = Post.ransack(params[:q])

   if params[:q].present?
     @search = Post.ransack(params[:q])
     @results = @search.result
    end
  # elsif params[:q].nill?

  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'はいできました' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'かきかえた' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'けしたよ' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content)
    end

	def must_login
	  unless !current_user.nil?
	    redirect_to posts_path, notice: "ログインしないでいけると思ってんの？"
	  end
	end
end
