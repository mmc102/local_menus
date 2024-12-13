module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
-- Controller Imports
import Web.Controller.ClickThroughs
import Web.Controller.Restaurants
import Web.Controller.Static
import Web.View.Layout (defaultLayout)

instance FrontController WebApplication where
  controllers =
    [ startPage WelcomeAction,
      -- Generator Marker
      parseRoute @ClickThroughsController,
      parseRoute @RestaurantsController
    ]

instance InitControllerContext WebApplication where
  initContext = do
    setLayout defaultLayout
    initAutoRefresh
