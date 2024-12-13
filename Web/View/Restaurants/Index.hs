module Web.View.Restaurants.Index where

import Web.View.Prelude

data IndexView = IndexView {restaurants :: [Restaurant]}

instance View IndexView where
  html IndexView {..} =
    [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewRestaurantAction} class="btn btn-primary ms-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Restaurant</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>

                <tbody>{forEach restaurants renderRestaurant}</tbody>
            </table>
            
        </div>
    |]
    where
      breadcrumb =
        renderBreadcrumb
          [ breadcrumbLink "Restaurants" RestaurantsAction
          ]

renderRestaurant :: Restaurant -> Html
renderRestaurant restaurant =
  [hsx|
    <tr>
        <td>{restaurant.title}</td>
        <td><a href={ShowRestaurantAction restaurant.id}>Show</a></td>
        <td><a href={EditRestaurantAction restaurant.id} class="text-muted">Edit</a></td>
        <td><a href={DeleteRestaurantAction restaurant.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]