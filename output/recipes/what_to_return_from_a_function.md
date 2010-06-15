# URL access to functions

Here is an overview of what you can return from a function that you call like this:

http://www.mysite.com/mypage/myfunction/

*  value: shows value only -> no template is rendered
*  return Array() -> normal template is rendered
*  return $this->renderWith("mytemplate"); -> renders data with different template


