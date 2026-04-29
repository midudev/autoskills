# N+1 fix: use pluck or joins with select to avoid loading full objects when not needed
product_names = Product.joins(:category).where(active: true).pluck('products.name')
