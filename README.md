# CCMPopup

[![License APACHE](https://img.shields.io/hexpm/l/plug.svg)](https://github.com/cacmartinez/CCMPopup/blob/master/LICENSE)
[![Release](https://img.shields.io/github/release/cacmartinez/CCMPopup.svg)](https://github.com/cacmartinez/CCMPopup)
[![Version](https://img.shields.io/cocoapods/v/CCMPopup.svg?style=flat)](http://cocoadocs.org/docsets/CCMPopup)
[![License](https://img.shields.io/cocoapods/l/CCMPopup.svg?style=flat)](http://cocoadocs.org/docsets/CCMPopup)
[![Platform](https://img.shields.io/cocoapods/p/CCMPopup.svg?style=flat)](http://cocoadocs.org/docsets/CCMPopup)

CCMPopup is an easy to use transition animation, that makes a window pop from the center of the presenting controller. It's is customizable and it comes with it's own segue for even easier use with storyboards.

![CCMPopup](https://github.com/cacmartinez/CCMPopup/blob/master/Screenshots/demoGif.gif)

# Usage

## Presenting

### With segue

1. First Step of using the CCMPopup with segues is as simple as clicking and dragging:
![CCMPopup](https://github.com/cacmartinez/CCMPopup/blob/master/Screenshots/usingSeguesDemo.gif)

2. Second step is to import the CCMPopupSegue in the source controller: `#import <CCMPopup/CCMPopupSegue.h>`

3. Then you have to implement the source controller's `prepareForSegue:sender:` method, and cast the segue to a `CCMPopupSegue` in order to call the `destinationBounds` property and be able to set the size of the destination controller (x and y origin are ignored):

```Objective-C
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue isKindOfClass:[CCMPopupSegue class]]){
	CCMPopupSegue *popupSegue = (CCMPopupSegue *)segue;
        popupSegue.destinationBounds = CGRectMake(0, 0, 50, 50);
    }
}
```

### With code:

1. First Step of using the CCMPopup with code is to import the CCMPopupTransitioning: `#import <CCMPopup/CCMPopupTransitioning.h>`

2. Then in your code you get the shared instance of CCMPopupTransitioning, and assign the destinationBounds, the presentingController, and the presentedController

```Objective-C
    CCMPopupTransitioning *popup = [CCMPopupTransitioning sharedInstance];
    popup.destinationBounds = CGRectMake(0, 0, 300, 400);
    popup.presentedController = presentingController;
    popup.presentingController = self;
    [self presentViewController:presentingController animated:YES completion:nil];
```

## Dismissing

* To dismiss call the presented controller's `dismissViewControllerAnimated:completion:`

* You can also use an unwind segue method

# Customization

CCMPopup has five properties for presentation customization:

* *destinationBound:* This property lets you define the size of the destination controller.

* *backgroundBlurRadius:* The blur radius for the background. Default is 5.

* *backgroundViewColor:* The background adds a view for custom tint color, this property should be combined with backgroundViewAlpha to let the background show. This property is ignored if backgroundViewAlpha is 0. Default is nil.

* *backgroundViewAlpha:* The alpha property that is to be applied to the background colored view. Default is 0.5

* *dismissableByTouchingBackground:* If set to YES, lets the presented view controller get dismissed if background is touched. Default is NO.

All of these properties are to be assigned to the segue, or the popupTransitioning depending of the implementation method

# Requirements

iOS 7.0 or up

# Installation

## With CocoaPods

CCMPopup is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "CCMPopup"

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Files

Download or clone the repo, and then add the folder CCMPopup to your proyect

# Author

Carlos Compean, ccompean@icalialabs.com

# License

CCMPopup is available under the Apache 2.0 license. See the LICENSE file for more info.

