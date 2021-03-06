##  Doing the official CMS and Dev overview videos 

*  http://www.silverstripe.org/assets/video/cms.html

*  http://www.silverstripe.org/assets/video/dev.html

##### Tools used

*  Created on Mac OS X environment (by Siggy)

*  iShowU used for screen capture (http://shinywhitebox.com/)

*  Apple iMovie used for editing, condensing, and concatenating screencaptures (e.g. for CMS overview)

*  Apple Keynote used for explanations (e.g. for developer tutorial)

*  ffmpegx used to convert .MOV quicktime into .FLV flash video (http://homepage.mac.com/major4/)

*  flvtool2 used to add metadata to FLV files so that you can seek around them and show progress
(http://www.inlet-media.de/flvtool2). Requires compiling on MacOSX.

*  jp media player used to embed FLV files when playing (http://www.jeroenwijering.com/)

##### Procedure

*  Current screencaptures of CMS are in a Firefox 2 window (on MacOS X) of 975x779 (TBC?).

*  Update iMovie/Keynote files as needed.

*  Export iMovie and Keynote files as Quicktime H264 at 1024x768 resolution, highest quality, frame-reordering,
double-pass.

*  Convert to FLV (ffmpeg) to 768x576 (a 4:3 ratio), no sound, 400kbit video.

*  Run flvtool2 on completed FLV files (adds a few kilobytes only)
    * e.g.: ruby /Library/Ruby/Site/1.8/flvtool2.rb dev.flv -UP

*  Upload to silverstripe.com/assets/video/

##### Jp media player settings

*  Reference: http://www.jeroenwijering.com/?item=Supported_Flashvars

*  width=768

*  height=596 (576 plus 20 pixels for the progress bar shown along the bottom)

*  autostart=true

*  searchbar=false

##### Typical resulting file-size

*  Aim for ~50 kb/second maximum.
    * CMS.flv: 25,833KB (8 minutes)
    * DEV.flv: 12,303KB (4 minutes)



### Doing youtube screencasts

*  Use iShowU HD to capture the footage for the screencast, and iMovie to edit.


*  When using iShowU beware of its tendency to 'letterbox'(black lines at top and bottom of video). This can easily be
cropped out in iMovie. (There may be a setting in iShowU to prevent this, if you know what it is let us know!)


*  Mouse mode in iShowU: the 'Follow' option can look a bit unsettling if moving the mouse around a lot in the video. I
found the 'Fixed' option worked well for most footage.


*  When slowing down footage from iShowU in iMovie it can lose quality and become slightly blurry, which can make the
text hard to read, especially in a youtube sized video. It can be better to simply take the footage slowly in iShowU
instead of trying to slow it down later.


*  Ideally, upload as 1280x720 resolution for HD quality.
    * Check official FAQ to confirm this is still accurate:
http://www.google.com/support/youtube/bin/answer.py?hl=en&answer=132460
