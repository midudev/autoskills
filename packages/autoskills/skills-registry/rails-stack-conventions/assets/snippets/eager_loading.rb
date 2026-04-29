# Eager loading example to avoid N+1
orders = Order.includes(:line_items).where(status: 'paid')
orders.each { |o| o.line_items.each { |li| puts li.id } }
