//
//  PopupTranstioningDelegate.h
//  SecondPrototypePrintoo
//
//  Created by Compean on 21/08/14.
//  Copyright (c) 2014 Icalia Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CCMPopupTransitioning : UIViewController

@property (weak) UIViewController *presentingController;
@property (weak) UIViewController *presentedController;
@property CGRect destinationBounds;
@property CGFloat backgroundBlurRadius;
@property UIColor *backgroundViewColor;
@property CGFloat backgroundViewAlpha;
@property BOOL dismissableByTouchingBackground;

+(instancetype)sharedInstance;
+(void)nilOutSharedInstance;

@end
