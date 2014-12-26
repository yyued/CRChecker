CRChecker
=========

Objective-C Circular Reference Checker

Here's another way to find circular reference problem tool, instare of 'Instrument Leaks Tool', CRChecker use runtime swizzling init/dealloc method.

* Demo

I wrote this code to create a reference problem.

![Code01](https://github.com/duowan/CRChecker/raw/master/ReadmeResource/DemoCode01.png)

![Code02](https://github.com/duowan/CRChecker/raw/master/ReadmeResource/DemoCode02.png)

![Code03](https://github.com/duowan/CRChecker/raw/master/ReadmeResource/DemoCode03.png)

When We try to enter DemoSecondViewController and present DemoModalViewController, again and again.

Now, present The DashBoardViewController.

![Screen01](https://github.com/duowan/CRChecker/raw/master/ReadmeResource/DemoScreen01.png)

You see, The DemoSecondViewController and DemoModalViewController still 4 objects alive. Normally, it should be zero.

And you find a circular reference problem, try to fix it.

* Usage

pod "CRChecker" or "Download ZIP -> add CRChecker Dir.'s file to your project"

If you eagering check your Prefix class Only.

use ` [CRChecker addCustomClassPrefix:@"Demo"];`

Else remove it, CRChecker will check all classes including system library.
