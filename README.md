#  StringsParser
## Overview
This swift package provides a simple way to enhance your Xcode builds so that any Strings files within your project can be validated at build time _with actual error messages._

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
### Installation
Unfortunately, you can't just install this into Xcode and enjoy the view.  You need to place the Swift file 'StringsParser.swift' somwhere that Xcode can see it.  Technically, it doesn't need to be added to your project, but you can do that if you want (as I've done in this sample project).
This repo was originally just an Xcode project with a working prototype of the parser.  This repo is a Swift Package, so you should be able to add the package to your project.  With that done, you should be able to locate StringsParser.swift.
### Using it
Now that the parser is where you want it, add a Run Script build phase and add the following to that phase:

    xcrun --sdk macosx swiftc -parse-as-library Scripts/StringsParser.swift -o CompiledScript
    ./CompiledScript $SCRIPT_INPUT_FILE_0

As you can see the run script is expecting to find the parser within a folder (or Group) inside the project called "Scripts". You will need to modify this as appropriate.
This script compiles the parser, and then executes it, passing the first script input as provided in the Run Script parameters.

That's it!  Once you have this in place, you'll get errors reported whenever you have a typo or similar somewhere inside your Strings file, and you'll be told where it is.  Magic!
## TODO
* Add support for a list of files instead of just parsing one.
* Find a way to get Xcode to display the link between an error and the localization key it actually belongs to.  The script already generates notes for this purpose however Xcode refuses to treat them in the same way it does for errors on objective-c code.
