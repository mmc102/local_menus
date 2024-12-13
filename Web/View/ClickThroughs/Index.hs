module Web.View.ClickThroughs.Index where
import Web.View.Prelude

data IndexView = IndexView { clickThroughs :: [ClickThrough] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewClickThroughAction} class="btn btn-primary ms-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>ClickThrough</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach clickThroughs renderClickThrough}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "ClickThroughs" ClickThroughsAction
                ]

renderClickThrough :: ClickThrough -> Html
renderClickThrough clickThrough = [hsx|
    <tr>
        <td>{clickThrough}</td>
        <td><a href={ShowClickThroughAction clickThrough.id}>Show</a></td>
        <td><a href={EditClickThroughAction clickThrough.id} class="text-muted">Edit</a></td>
        <td><a href={DeleteClickThroughAction clickThrough.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]