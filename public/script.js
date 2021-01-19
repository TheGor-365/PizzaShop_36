function test() {
  let x = window.localStorage.getItem('bbb')
  x++
  window.localStorage.setItem('bbb', x)
  alert(x)
}

function add_to_cart(id) {
  let key = 'product_' + id
  let x = window.localStorage.getItem(key)
  x++
  window.localStorage.setItem(key, x)

  update_orders_input()
  update_orders_button()
}

function update_orders_input() {
  let orders = cart_get_orders()
  $('#orders_input').val(orders)
}

function update_orders_button() {
  let text = 'Cart   [' + cart_get_number_of_items() + ']'
  $('#orders_button').val(text)
}

function cart_get_number_of_items() {
  let cnt = 0

  for(let i = 0; i < window.localStorage.length; i++) {
    let key = window.localStorage.key(i)
    let value = window.localStorage.getItem(key)

    if (key.indexOf('product_') === 0) {
      cnt += value * 1
    }
  }
  return cnt
}

function cart_get_orders() {
  let orders = ''

  for(let i = 0; i < window.localStorage.length; i++) {
    let key = window.localStorage.key(i)
    let value = window.localStorage.getItem(key)

    if(key.indexOf('product_') === 0) {
      orders = orders + key + '=' + value + ','
    }
  }
  return orders
}
