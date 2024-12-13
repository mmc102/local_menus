module Web.Types where

import Generated.Types
import IHP.ModelSupport
import IHP.Prelude

data WebApplication = WebApplication deriving (Eq, Show)

data StaticController = WelcomeAction deriving (Eq, Show, Data)

data RestaurantsController
  = RestaurantsAction
  | NewRestaurantAction
  | ShowRestaurantAction {restaurantId :: !(Id Restaurant)}
  | CreateRestaurantAction
  | EditRestaurantAction {restaurantId :: !(Id Restaurant)}
  | UpdateRestaurantAction {restaurantId :: !(Id Restaurant)}
  | DeleteRestaurantAction {restaurantId :: !(Id Restaurant)}
  | TinderAction { category :: Maybe Text,  subCategory :: Maybe Text, search :: Maybe Text }
  deriving (Eq, Show, Data)

data ClickThroughsController
  = ClickThroughsAction
  | NewClickThroughAction
  | ShowClickThroughAction {clickThroughId :: !(Id ClickThrough)}
  | CreateClickThroughFromRestaurantAction {restaurantId :: !(Id Restaurant)}
  | CreateClickThroughAction
  | EditClickThroughAction {clickThroughId :: !(Id ClickThrough)}
  | UpdateClickThroughAction {clickThroughId :: !(Id ClickThrough)}
  | DeleteClickThroughAction {clickThroughId :: !(Id ClickThrough)}
  deriving (Eq, Show, Data)
