module Web.Controller.ClickThroughs where

import Web.Controller.Prelude
import Web.View.ClickThroughs.Edit
import Web.View.ClickThroughs.Index
import Web.View.ClickThroughs.New
import Web.View.ClickThroughs.Show

instance Controller ClickThroughsController where
  action ClickThroughsAction = do
    clickThroughs <- query @ClickThrough |> fetch
    render IndexView {..}
  action NewClickThroughAction = do
    let clickThrough = newRecord
    render NewView {..}

  action CreateClickThroughFromRestaurantAction { restaurantId } = do
    restaurant <- fetch restaurantId
    setSuccessMessage "ClickThrough created from Restaurant"
    redirectToUrl (restaurant.weburl)

    let clickThrough = newRecord @ClickThrough
            |> set #restaurantId restaurantId

    clickThrough <- createRecord clickThrough
    setSuccessMessage "ClickThrough created from Restaurant"
    redirectTo ClickThroughsAction

  action ShowClickThroughAction {clickThroughId} = do
    clickThrough <- fetch clickThroughId
    render ShowView {..}
  action EditClickThroughAction {clickThroughId} = do
    clickThrough <- fetch clickThroughId
    render EditView {..}
  action UpdateClickThroughAction {clickThroughId} = do
    clickThrough <- fetch clickThroughId
    clickThrough
      |> buildClickThrough
      |> ifValid \case
        Left clickThrough -> render EditView {..}
        Right clickThrough -> do
          clickThrough <- clickThrough |> updateRecord
          setSuccessMessage "ClickThrough updated"
          redirectTo EditClickThroughAction {..}

  action CreateClickThroughAction = do
    let clickThrough = newRecord @ClickThrough
    clickThrough
      |> buildClickThrough
      |> ifValid \case
        Left clickThrough -> render NewView {..}
        Right clickThrough -> do
          clickThrough <- clickThrough |> createRecord
          restaurant <- fetch clickThrough.restaurantId
          redirectToUrl restaurant.weburl

  action DeleteClickThroughAction {clickThroughId} = do
    clickThrough <- fetch clickThroughId
    deleteRecord clickThrough
    setSuccessMessage "ClickThrough deleted"
    redirectTo ClickThroughsAction

buildClickThrough clickThrough =
  clickThrough
    |> fill @'["restaurantId"]
