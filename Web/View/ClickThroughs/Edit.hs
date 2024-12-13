module Web.View.ClickThroughs.Edit where
import Web.View.Prelude

data EditView = EditView { clickThrough :: ClickThrough }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit ClickThrough</h1>
        {renderForm clickThrough}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "ClickThroughs" ClickThroughsAction
                , breadcrumbText "Edit ClickThrough"
                ]

renderForm :: ClickThrough -> Html
renderForm clickThrough = formFor clickThrough [hsx|
    {(textField #restaurantId)}
    {submitButton}

|]