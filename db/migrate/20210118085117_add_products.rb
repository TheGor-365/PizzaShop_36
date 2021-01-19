class AddProducts < ActiveRecord::Migration[6.1]
  def change
    Product.create ({
      title:          'Bavarian',
      description:    'This is German pizza',
      price:          350,
      size:           30,
      is_spicy:       true,
      is_veg:         false,
      is_best_offer:  false,
      path_to_image:  './images/bavarian.jpg'
    })

    Product.create ({
      title:          'Mexican',
      description:    'This is Mexican pizza',
      price:          400,
      size:           30,
      is_spicy:       true,
      is_veg:         false,
      is_best_offer:  true,
      path_to_image:  './images/mexican.jpg'
    })

    Product.create ({
      title:          'Meat',
      description:    'This is anti-veg pizza',
      price:          450,
      size:           30,
      is_spicy:       false,
      is_veg:         false,
      is_best_offer:  false,
      path_to_image:  './images/meat.jpg'
    })
  end
end
