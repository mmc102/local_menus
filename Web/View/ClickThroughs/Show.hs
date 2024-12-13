module Web.View.ClickThroughs.Show where
import Web.View.Prelude

data ShowView = ShowView { clickThrough :: ClickThrough }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show ClickThrough</h1>
        <p>{clickThrough}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "ClickThroughs" ClickThroughsAction
                            , breadcrumbText "Show ClickThrough"
                            ]