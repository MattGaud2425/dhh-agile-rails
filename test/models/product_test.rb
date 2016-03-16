require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products
  test "product attributes must not be empty" do 
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:price].any?
  	assert product.errors[:image_url].any?
  end

  def new_product(image_url)
  	Product.new(title: "My Book title",
  		description: "yyy",
  		price: 1,
  		image_url: image_url)
  end
  test "image url" do 
  	ok = %w{fred.gif fred.jpg fred.png FRED.JPG Fred.Jpg }
  	bad = %w{fred.doc}
  	ok.each do |name|
  		assert new_product(name).valid?, "#{name} should be valid"
  	end
  	bad.each do |name| 
  		assert new_product(name).invalid?, "#{name} should be invalid"
  	end
  end

  test "product is not valid without a unique title" do 
  	product = Product.new(title: products(:ruby).title,
		description: "yyy", price: 1, image_url: "fred.gif")
  	assert product.invalid?
		assert_equal ["has already been taken"], product.errors[:title] 
	end

end













