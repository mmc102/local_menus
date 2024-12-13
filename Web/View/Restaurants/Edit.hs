module Web.View.Restaurants.Edit where

import Web.View.Prelude

data EditView = EditView {restaurant :: Restaurant}

instance View EditView where
  html EditView {..} =
    [hsx|
        {breadcrumb}
        <h1>Edit Restaurant</h1>
        {renderForm restaurant}
    |]
    where
      breadcrumb =
        renderBreadcrumb
          [ breadcrumbLink "Restaurants" RestaurantsAction,
            breadcrumbText "Edit Restaurant"
          ]

renderForm :: Restaurant -> Html
renderForm restaurant =
  formFor
    restaurant
    [hsx|
    {(textField #title)}
    {submitButton}

|]