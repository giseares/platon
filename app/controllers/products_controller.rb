class ProductsController < ApplicationController
  
  def show
    @shop = current_user.shop
    @product = Product.find(params[:id])
    authorize @product
  end

  def new
    @shop = current_user.shop
    @product = Product.new
    authorize @shop
  end

  def create
    @shop = current_user.shop
    @product = Product.new(product_params)
    @product.shop = @shop
    authorize @shop
    if @product.save
      flash[:success] = "Bien ahi perro"
      redirect_to @shop
    else
      flash[:error] = "Mal ahi"
      render 'new'
    end
  end


  def edit
    @shop = current_user.shop
    @product = Product.find(params[:id])
    authorize @shop
  end

  def update
    @shop = current_user.shop
    @product = Product.find(params[:id])
    authorize @shop
    if @product.update_attributes(product_params)
      flash[:success] = "Actualizado con exito"
      redirect_to dashboard_path(@shop)
    else
      flash[:error] = "Error al Editar, pruebe nuevamente"
      render 'edit'
    end
  end
  
  def destroy
    @shop = current_user.shop
    @product = Product.find(params[:id])
    authorize @shop
    @product.destroy
    redirect_to dashboard_path(@shop)
  end

private

  def product_params
    params.require(:product).permit(:name, :description, :unit_price, :photo, :previous_price, :category)
  end

end
