 Templates in SilverStripe are stored on the file-system, and if you're running Windows, this can be a problem for languages/countries that need the full set of UTF-8 characters to display the language.

Basically, Windows will use the wrong charset in some instances (ANSI instead of UTF-8) which means that when SilverStripe goes to parse the file, instead of seeing UTF-8 encoded characters, it sees (and will output) gibberish. 

To fix this, simply save the file in UTF-8 format instead. If your editor of choice doesn't let you either save in UTF-8 format or convert files to UTF-8, Notepad can do this (File -> Save As -> Choose 'UTF-8' from the Encoding drop-down).
