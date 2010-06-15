Sometimes you want to change the title of a page depending on, for example, whether the user is logged in. Add the following to your Page class to achieve this:

~~~ {php}
	static $db = array(
		"TitleLoggedIn" => "Varchar(255)",
		"MenuTitleLoggedIn" => "Varchar(255)",
		"ContentLoggedIn" => "HTMLText"
	);

	public function getTitle() {if($this->showLoggedInFields()) {$field = "TitleLoggedIn";}else {$field = "Title";} return $this->getField($field);}
	public function getMenuTitle() {if($this->showLoggedInFields()) {$field = "MenuTitleLoggedIn";}else {$field = "MenuTitle";}return $this->getField($field);}
	public function getContent() {if($this->showLoggedInFields()) {$field = "ContentLoggedIn";}else {$field = "Content";}return $this->getField($field);}

	private function showLoggedInFields() {
		if(!$this->isCMS() && Member::currentUser()  ) {
			return true;
		}
	}

	private function isCMS () {
		$actions = Director::urlParams();
		if(Director::is_ajax() || "CMSMain" == $actions["Controller"]) {
			return true;
		}
	}
	public function getCMSFields($cms) {
		$fields = parent::getCMSFields($cms);
		$fields->addFieldToTab('Root.Content.LoggedIn', new TextField('TitleLoggedIn', 'Title when user is Logged In'));
		$fields->addFieldToTab('Root.Content.LoggedIn', new TextField('MenuTitleLoggedIn', 'Navigation Label when user is Logged In'));
		$fields->addFieldToTab('Root.Content.LoggedIn', new HTMLEditorField('ContentLoggedIn', 'Content when user is Logged In'));
		return $fields;
	}

~~~

Now, if the user is logged in, she or he can view alternative content.  Dont forget, of course, to enter this into the CMS.
