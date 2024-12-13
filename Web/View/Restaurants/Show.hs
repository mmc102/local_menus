module Web.View.Restaurants.Show where

import Web.View.Prelude

data ShowView = ShowView {restaurant :: Restaurant}

instance View ShowView where
  html ShowView {..} =
    [hsx|
        {breadcrumb}
        <h1>Show Restaurant</h1>
        <h1>{restaurant.title}</h1>

    |]
    where
      breadcrumb =
        renderBreadcrumb
          [ breadcrumbLink "Restaurants" RestaurantsAction,
            breadcrumbText "Show Restaurant"
          ]