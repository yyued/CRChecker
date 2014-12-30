CRChecker
=========

Objective-C Circular Reference Checker

## How can we find out circular reference problem?

It's not a difficult issue.

We just swizzling Objective-C init and dealloc method, every object will execute these method at live cycle start and end.

If your instanced object has circular reference problem. These object may not be dealloc.

So, we set a counter, just make all classes init +1, dealloc -1.

You see, the dashBoard data source came here.

![](https://github.com/duowan/CRChecker/raw/master/ReadmeResource/DemoScreen01.png)

## Usage

It's really easy to use this tool.

Be careful, this tool should not use under production.

If you use CocoaPods
1. Podfile add `Pod 'CRChecker'`
2. pod update
3. It's OK~

If you eager use source code
1. Go to Github Download latest version zip.
2. Add CRChecker/CRChecker files into your project
3. It's OK~

## Counter will not record system libraries class.

Version 1.0.1

CRCounter will not record any system libraries. That's because, we think developer should focus on your code.

## Counter could only record custom prefix class.

add this line to your code

[CRChecker addCustomClassPrefix:@"Demo"];

Only Demo Prefix Classes will be record. 

