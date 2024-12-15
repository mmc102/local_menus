module Web.View.Restaurants.Tinder where
import qualified Data.Set as Set

import Web.View.Prelude

data TinderView = TinderView
    { restaurants :: [Restaurant]
    , selectedCategory :: Maybe Text
    , selectedSubCategory :: Maybe Text
    , allCategories :: [Text]
    , allSubCategories :: [Text]
    , search :: Maybe Text
    }

instance View TinderView where
  html TinderView {..} =
    [hsx|
      <div class="container my-5">
        <h1 class="mb-4">
          Restaurants
        </h1>
          {renderForm search}
        <!-- Subcategories -->
        <div class="row mb-4">
            {renderTags selectedSubCategory}
            {renderTags search}
            </div>

        <div class="row mb-4">
          {forEach allSubCategories (\subcatname -> renderSubCatCol subcatname selectedSubCategory)}
        </div>
        <!-- Restaurants -->

        <div class="row">
          {if null restaurants 
            then renderNoResults 
            else forEach restaurants renderRestaurantCol}
        </div>
      </div>
    |]

renderTags :: Maybe Text -> Html
renderTags tags = 
  case tags of
    Just t  -> renderActiveTags (Just t)
    Nothing -> renderNothing


renderNothing ::  Html
renderNothing = 
  [hsx|<div></div>|]

renderActiveTags :: Maybe Text -> Html
renderActiveTags tag =
  let
    categoryLink = TinderAction { category = Nothing, subCategory = Nothing, search = Nothing } 
  in
  [hsx|
    <form method="POST" data-turbo="true" action={categoryLink} class="d-inline-block">
      <div class="badge bg-primary text-white d-inline-flex align-items-center">
        <span class="me-2">{tag}</span>
        <button type="submit" class="btn btn-sm text-white border-0 p-0 ms-1" style="font-size: 0.8rem; line-height: 1; padding: 0 4px;">
          X
        </button>
      </div>
    </form>
  |]




renderSubCatCol :: Text -> Maybe Text -> Html
renderSubCatCol subcatname selectedSubCategory =
  [hsx|
    <div class="col-6 col-sm-3 mb-1">
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
    categoryLink = TinderAction { subCategory = Just (get #subcatname restaurant), category = Nothing, search=Nothing}
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
    categoryLink = TinderAction { category = Just catname, subCategory = Nothing , search= Nothing} 
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
    subCategoryLink = TinderAction { category = Nothing, subCategory = Just subcatname , search=Nothing}
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

renderForm :: Maybe Text-> Html
renderForm search= 
  let 
    categoryLink = TinderAction { category = Nothing, subCategory = Nothing, search = Nothing } 
  in
  [hsx|
    <form method="GET" action={categoryLink} class="my-3">
      <div class="input-group">
        <input type="text" name="search" value={search}class="form-control" placeholder="Search..." />
        <button type="submit" class="btn btn-primary">Search</button>
      </div>
    </form>
  |]

-- Render a message when no results are found
renderNoResults :: Html
renderNoResults =
  [hsx|
    <div class="text-center mt-5">
      <h5>No Results :(</h5>
    </div>
  |]