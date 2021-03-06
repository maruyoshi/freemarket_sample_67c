class ProductsController < ApplicationController

  require 'payjp'

  before_action :move_to_index, except: [:index, :select_registrations, :show]
  before_action :set_product, only: [:edit, :update]


  def index
    @images =Image.all
    @products = Product.product
    @products_ladies = Product.ladies
    @products_mens = Product.mens
    @products_test = Product.tests
  end

  def select_registrations
  end

  def new
    @parents = Category.all.order("id ASC").limit(13)
    @product = Product.new
    @product.images.new
  end

   # Ajax通信で送られてきたデータをparamsで受け取り､childrenで子を取得
  def category_children
    @category_children = Category.find(params[:productcategory]).children 
  end

  def category_grandchildren
    @category_grandchildren = Category.find(params[:productcategory]).children
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @product_images = @product.images.limit(3)
    @category_child = @product.category.parent
    @category_parent = @category_child.parent
    @comment = Comment.new
    @comments = @product.comments.includes(:user)
  end

  def edit
    @parents = Category.all.order("id ASC").limit(13)

    # 現在のカテゴリ選択値
    @select_grandchild = Category.find(@product.category_id)
    @select_child = @select_grandchild.parent
    @select_parent = @select_child.parent
    # カテゴリ配列
    @category = Category.where(ancestry: nil)
    @child_category = @select_parent.children
    @grand_child_category = @select_child.children
  end

  def update
    if @product.update(product_params)
      redirect_to product_path, data: {"turbolinks" => false}
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to mypage_index_path
    else
      redirect_to product_path, data: {"turbolinks" => false}
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :status_id,  :delivery_charge_id, :ship_from_id, :delivery_days_id, :price,  :category_id,:brand_id,  images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def move_to_index
    redirect_to root_path, notice: "ログイン　または　ユーザー登録をお願いします"  unless user_signed_in?
  end
  
  def set_categories
    @parent_categories = Category.roots
    @default_child_categories = @parent_categories.first.children
    @default_child_child_childcategories = @default_child_categories.first.children
  end

  def set_product
    @product = Product.find(params[:id])
  end
  
end