Controller recipes

## Manual Redirector

If you want to make a page redirect to the first child page, below is a simple recipe to do so. index() is called automatically when the page is viewed - so you can do your redirection here.

~~~ {php}
class PageName_Controller extends Page_Controller {

   function index() {
      if($children = $this->Children()) {
         if($firstChild = $children->First()) {
            Director::redirect($firstChild->Link());	
         }
      }
   }

}
~~~

It's very simple. It takes the first child - ''$this->Children()->First()'' if there are children of this page and redirects to that given first child page.


## Simulate Pages with Controllers
Sometimes working with SiteTree/Page is not practical, e.g. if you want to build a custom application-interface which isn't page- or content-oriented. This basically means using custom [:Controller](/Controller)-instances rather than [:ContentController](/ContentController) to render your page-content.
Pros:
*  More native URL-Layout ("/team/create" instead of "/myteampage/create")
*  Application-logic does not rely on SiteTree-objects which could be deleted by a CMS-user
*  More logical separation (Team_Controller manages a Team, rather than MyTeamPage links to a Team)
Cons:
*  No automated template-selection/rendering
*  You lose all [:Hierarchy](/Hierarchy)-related functionality (e.g. Breadcrumbs(), IsCurrent())
*  Menus need be generated from scratch (if needed)

## Naming Conventions
Usage of underscores in templates and controllers has several implications in the way sapphire handles it. See [:manifestbuilder](/manifestbuilder) (Autoloader) and [:templates](/templates) for more information.

## Related
*  [:execution-pipeline](/execution-pipeline)
*  [:manifestbuilder](/manifestbuilder)
