class BlogsController < ApplicationController
  before_action :set_q, only: [:index, :search]

  def index
    @categories = Category.all
   
    cate = params[:cate]

    if !cate.nil? 
      @blogs = Blog.where(:category_id => cate)
    else 
      @blogs = Blog.all.order(created_at: :desc)
    end
    @blogs = @blogs.page(params[:page]).per(6)
    @rank_blogs = Blog.order(impressions_count: 'DESC')
  end

  def show
    @blog =Blog.find(params[:id])
    @comments = @blog.comments.order("datetime_jp DESC")
    @comments = @blog.comments.page(params[:page]).per(50)
    impressionist(@blog, nil, unique: [:ip_address])
  end

  def new
    @blog = Blog.new
  end
  
  def create
    @blog = Blog.create(blog_params)

    if @blog.save
      redirect_to @blog
    else
      render :new
    end
  end

  def edit
    @blog =Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])

    if @blog.update(blog_params)
      redirect_to @blog
    else
      render :edit
    end
  end

  def destroy
    @blog = Blog.find(params[:id])

    @blog.destroy
    redirect_to :action => :index
  end

  def search
    @results = @q.result
  end

  private 
  
  def set_q 
    @q = Blog.ransack(params[:q])
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :category_id)
  end
end
