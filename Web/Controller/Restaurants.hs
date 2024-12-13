module Web.Controller.Restaurants where

import qualified Data.Set as Set

import Web.Controller.Prelude
import Web.View.Restaurants.Edit
import Web.View.Restaurants.Index
import Web.View.Restaurants.New
import Web.View.Restaurants.Show
import Web.View.Restaurants.Tinder

instance Controller RestaurantsController where

  action TinderAction { category, subCategory } = do
    allRestaurants <- query @Restaurant |> fetch

    let baseQuery = query @Restaurant
    let filteredQuery =
            case (category, subCategory) of
                (Just cat, Just subCat) -> baseQuery |> queryOr (filterWhere (#catname, cat)) (filterWhere (#subcatname, subCat))
                (Just cat, Nothing)     -> baseQuery |> filterWhere (#catname, cat)
                (Nothing, Just subCat)  -> baseQuery |> filterWhere (#subcatname, subCat)
                (Nothing, Nothing)      -> baseQuery

    let orderedQuery = filteredQuery |> orderByDesc (#qualityScore)
    restaurants <- filteredQuery |> fetch

    let allCategories = Set.toList $ Set.fromList $ map (get #catname) allRestaurants
    let allSubCategories = Set.toList $ Set.fromList $ map (get #subcatname) allRestaurants
    let selectedSubCategory = subCategory
    let selectedCategory = category
    render TinderView { .. } 


  action RestaurantsAction = do
    restaurants <- query @Restaurant |> fetch
    render IndexView {..}
  action NewRestaurantAction = do
    let restaurant = newRecord
    render NewView {..}
  action ShowRestaurantAction {restaurantId} = do
    restaurant <- fetch restaurantId
    render ShowView {..}
  action EditRestaurantAction {restaurantId} = do
    restaurant <- fetch restaurantId
    render EditView {..}
  action UpdateRestaurantAction {restaurantId} = do
    restaurant <- fetch restaurantId
    restaurant
      |> buildRestaurant
      |> ifValid \case
        Left restaurant -> render EditView {..}
        Right restaurant -> do
          restaurant <- restaurant |> updateRecord
          setSuccessMessage "Restaurant updated"
          redirectTo EditRestaurantAction {..}
  action CreateRestaurantAction = do
    let restaurant = newRecord @Restaurant
    restaurant
      |> buildRestaurant
      |> ifValid \case
        Left restaurant -> render NewView {..}
        Right restaurant -> do
          restaurant <- restaurant |> createRecord
          setSuccessMessage "Restaurant created"
          redirectTo RestaurantsAction
  action DeleteRestaurantAction {restaurantId} = do
    restaurant <- fetch restaurantId
    deleteRecord restaurant
    setSuccessMessage "Restaurant deleted"
    redirectTo RestaurantsAction

buildRestaurant restaurant =
  restaurant
    |> fill @'["title"]

