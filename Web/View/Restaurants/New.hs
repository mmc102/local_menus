module Web.View.Restaurants.New where

import Web.View.Prelude

data NewView = NewView {restaurant :: Restaurant}

instance View NewView where
  html NewView {..} =
    [hsx|
        {breadcrumb}
        <h1>New Restaurant</h1>
        {renderForm restaurant}
    |]
    where
      breadcrumb =
        renderBreadcrumb
          [ breadcrumbLink "Restaurants" RestaurantsAction,
            breadcrumbText "New Restaurant"
          ]

renderForm :: Restaurant -> Html
renderForm restaurant =
  formFor
    restaurant
    [hsx|
    {(textField #title)}
    {(textField #weburl)}
    {submitButton}
|]