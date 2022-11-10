require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
    test 'render a list of products' do
        get products_path
        assert_response :success
        assert_select '.product', 2
    end

    test 'render a detail product page' do
        get product_path(products(:ps4))
        assert_response :success
        assert_select '.title', 'ps4 1'
        assert_select '.description', 'MyText1'
        assert_select '.price', '150$'

    end

    test 'render new product form' do
        get new_product_path

        assert_response :success
        assert_select 'form'
    end

    test 'allow to create a new product' do 
        post products_path, params: {
            product: {
                title: 'Nintendo',
            description: 'faltan 3',
            price: 20
            }
        }
        assert_redirected_to products_path
        assert_equal flash[:notice], 'tu producto se ha creado'

    end


    test 'does not allow to create a new product' do 
        post products_path, params: {
            product: {
            description: 'faltan 3',
            price: 20
            }
        }
        assert_response :unprocessable_entity
    end


    test 'render an edit product form' do
        get edit_product_path(products(:ps4))

        assert_response :success
        assert_select 'form'
    end

    test 'allow to update a product' do 
        patch product_path(products(:ps4)), params: {
            product: {
            price: 30
            }
        }
        assert_redirected_to products_path
        assert_equal flash[:notice], 'tu producto fue actualizado'
    end

    test 'does not allow to update a product' do 
        patch product_path(products(:ps4)), params: {
            product: {
            price: nil
            }
        }
        assert_response :unprocessable_entity
    end


    test 'can delete a product' do 
        assert_difference('Product.count', -1) do
            delete product_path(products(:ps4))
        end
        assert_redirected_to products_path
        assert_equal flash[:notice], 'Tu producto se ha eliminado correctamente'
    end
end