#  StringsParser
## Overview
This swift package provides a simple way to enhance your Xcode builds so that Strings files within your project can be validated at build time _with actual error messages._

All Xcode does is, (as of Xcode 14.1) at build time, tell you that your Strings file is no good, and thats all.  It won't tell you why its no good; just that its no good.

😐 Thats pretty useless.

Xcode has never provided adequate error reporting for Strings files, and whilst this feature might seem like an obvious value-add for Xcode, after all these years, it has not been done.

I raised a feedback item (FB5747387) back in June 2017 hoping to get some traction on the issue.  The quick response from Apple was that the issue would be closed as a duplicate.

In May 2018 I asked again to see if there was any chance it would be addressed.  The response in September 2018 was that the issue is "still under investigation".

Well, it's November 2022, and I'm tired of waiting.
## The solution
Xcode isn't very extensible anymore.  The source editor extensions are weak, and of no use for what is needed.  Being able to add a plugin or extension that can be used during the build phase would actually be useful.

So what I've done, with a little nudge from the community was to create a small swift script that parses a named Strings file, outputting to standard out, any error messages, so that Xcode can automatically pick up and display them in the Issue Navigator.

Clicking on an error will helpfully highlight the line at which the problem resides.
## How to use it
### Installation - Xcode 14 only.
* Add this repo as a swift package to your Xcode project.
### Using it
* In your build phases for each target, in the Build-Tool plugin list, add StringsParserPlugin.
* Build your target!

The plugin will automatically parse the first strings file for the current target.  Nothing else is needed.

That's it!  Once you have this in place, you'll get errors reported whenever you have a typo or similar somewhere inside your Strings file, and you'll be told where it is.  Magic!
## TODO
* Add support for a pasing all strings files in the target file list instead of just parsing one.
