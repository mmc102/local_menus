module Web.View.ClickThroughs.New where
import Web.View.Prelude

data NewView = NewView { clickThrough :: ClickThrough }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New ClickThrough</h1>
        {renderForm clickThrough}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "ClickThroughs" ClickThroughsAction
                , breadcrumbText "New ClickThrough"
                ]

renderForm :: ClickThrough -> Html
renderForm clickThrough = formFor clickThrough [hsx|
    {(textField #restaurantId)}
    {submitButton}

|]