For those of you who are looking for some easy speed gains - try adding this to your init function in your
page_controller: 

	:::php
	
			$currentTheme = SSViewer::current_theme();
			if($currentTheme != self::$project && $currentTheme) {
			 self::$themeFolderAndSubfolder = 'themes/'.$currentTheme;
			}
			else {
			 self::$themeFolderAndSubfolder = self::$project;
			}
			$jsArray =
				array(
					"sapphire/thirdparty/jquery/jquery.js",
					'mysite/javascript/j.js'
				);
			$cssArray =
				array(
					self::$themeFolderAndSubfolder.'/css/reset.css',
					self::$themeFolderAndSubfolder.'/css/layout.css',
					self::$themeFolderAndSubfolder.'/css/typography.css',
					self::$themeFolderAndSubfolder.'/css/form.css',
					self::$themeFolderAndSubfolder.'/css/menu.css',
					self::$themeFolderAndSubfolder.'/css/print.css'
				);
			foreach($jsArray as $js) {
				Requirements::javascript($js);
			}
			foreach($cssArray as $css) {
				Requirements::css($css);
			}
			Requirements::combine_files(self::$themeFolderAndSubfolder."/css/mainCSS.css",$cssArray);
			Requirements::combine_files("mysite/javascript/MainJS.js", $jsArray);
			Requirements::combine_files("mysite/javascript/SapphirePrototype.js",
				array(
					"sapphire/javascript/Validator.js",
					"sapphire/thirdparty/prototype/prototype.js",
					"sapphire/thirdparty/behaviour/behaviour.js",
					"sapphire/javascript/prototype_improvements.js"
				)
			);
	
	
	... other stuff here
	
	Requirements::process_combined_files();
	



For me, this saved around 100Kb for a page and of course fewer downloads.  It is counter-intuitive, but actually makes
sense when you think about it a bit more, if you want to combine files you first have to add them using the regular
Requirements::css or Requirements::javascript and then list that same file in
Requirements::combine_files("mysite/test.js/", array("sameFilehere.js", "morehere.js")); 


