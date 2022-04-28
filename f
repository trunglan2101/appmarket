
[1mFrom:[0m /home/t3lan2101/Desktop/appmarket/app/views/products/index.html.erb:43 #<Class:0x000055b16231a588>#_app_views_products_index_html_erb__4325120326107905333_23980:

    [1;34m38[0m:                     <%= f.hidden_field :cart_id, value: Cart.new(user_id: current_user.id) %>
    [1;34m39[0m:                     <%= f.hidden_field :quantity %>
    [1;34m40[0m:                     <%= f.hidden_field :total, value: 0%>
    [1;34m41[0m:                     <%= f.submit "Add cart" %>
    [1;34m42[0m:                     <%= 
 => [1;34m43[0m:                     binding.pry
    [1;34m44[0m:                      %>
    [1;34m45[0m:                   <% end %>
    [1;34m46[0m:                 </div>
    [1;34m47[0m:               </div>
    [1;34m48[0m:             </div>

