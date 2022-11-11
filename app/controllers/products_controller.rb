class ProductsController < ApplicationController 
    def index
        @products = Product.all.with_attached_photo
    end

    def show
        product
    end

    def new
        @product = Product.new
    end

    def create 
        @product = Product.new(products_params)
        if @product.save
            redirect_to products_path, notice: 'tu producto se ha creado'
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        product
    end

    def update
        if product.update(products_params)
            redirect_to products_path, notice: 'tu producto fue actualizado'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        product.destroy
        redirect_to products_path, notice: 'Tu producto se ha eliminado correctamente', statrus: :see_other
    end

    private
    def products_params
        params.require(:product).permit(:title, :description, :price, :photo)
    end

    def product
        @product = Product.find(params[:id])
    end
end
