module Web.View.Restaurants.Tinder where
import qualified Data.Set as Set

import Web.View.Prelude

data TinderView = TinderView
    { restaurants :: [Restaurant]
    , selectedCategory :: Maybe Text
    , selectedSubCategory :: Maybe Text
    , allCategories :: [Text]
    , allSubCategories :: [Text]
    }

instance View TinderView where
  html TinderView {..} =
    [hsx|
      <div class="container my-5">
        <h1 class="mb-4">
          Keepers
        </h1>
        <!-- Categories -->
        <div class="row mb-4">
          {forEach allCategories (\catname -> renderCatCol catname selectedCategory)}
        </div>
        <!-- Subcategories -->
        <div class="row mb-4">
          {forEach allSubCategories (\subcatname -> renderSubCatCol subcatname selectedSubCategory)}
        </div>
        <!-- Restaurants -->
        <div class="row">
          {forEach restaurants renderRestaurantCol}
        </div>
      </div>
    |]

renderCatCol :: Text -> Maybe Text -> Html
renderCatCol catname selectedCategory =
  [hsx|
    <div class="col-md-3 col-sm-6 mb-1">
      {renderCat catname selectedCategory}
    </div>
  |]

renderSubCatCol :: Text -> Maybe Text -> Html
renderSubCatCol subcatname selectedSubCategory =
  [hsx|
    <div class="col-md-3 col-sm-6 mb-1">
      {renderSubCat subcatname selectedSubCategory}
    </div>
  |]

renderRestaurantCol :: Restaurant -> Html
renderRestaurantCol restaurant =
  [hsx|
    <div class="col-md-4 col-sm-6 mb-4">
      {renderRestaurant restaurant}
    </div>
  |]

renderRestaurant :: Restaurant -> Html
renderRestaurant restaurant =
  let
    categoryLink = TinderAction { category = Just (get #subcatname restaurant), subCategory = Nothing }
  in
  [hsx|
    <div class="card h-100">
      <div class="card-body">
        <h5 class="card-title">{get #title restaurant}</h5>
        <h5 class="card-title">{get #address1 restaurant}</h5>
        <h5 class="badge bg-primary">
          <a href={categoryLink} class="text-white text-decoration-none">
            {get #subcatname restaurant}
          </a>
        </h5>
        <form data-disable-javascript-submission="true" method="POST" action={CreateClickThroughAction} class="mt-3">
          <input type="hidden" name="restaurantId" value={restaurant.id} />
          <button type="submit" class="btn btn-primary w-100">Go To Menu</button>
        </form>
      </div>
    </div>
  |]
renderCat :: Text -> Maybe Text -> Html
renderCat catname activeCat =
  let 
    categoryLink = TinderAction { category = Just catname, subCategory = Nothing } 
    color :: Text
    color = case activeCat of
      Just active | catname == active -> "badge bg-primary"
      _ -> "badge bg-secondary"
  in 
  [hsx|
 <h5 class={color}>
          <a href={categoryLink} class="text-white text-decoration-none">
            {catname}
          </a>
        </h5>   
  |]

renderSubCat :: Text -> Maybe Text -> Html
renderSubCat subcatname activeSubCat =
  let
    subCategoryLink = TinderAction { category = Nothing, subCategory = Just subcatname }
    color :: Text
    color = case activeSubCat of
      Just active | subcatname == active -> "badge bg-primary"
      _ -> "badge bg-secondary"

  in
  [hsx|
    <h5 class={color}>
      <a href={subCategoryLink} class="text-white text-decoration-none">
        {subcatname}
      </a>
    </h5>   
  |]