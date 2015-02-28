//
//  PopupSegue.m
//  SecondPrototypePrintoo
//
//  Created by Compean on 21/08/14.
//  Copyright (c) 2014 Icalia Labs. All rights reserved.
//

#import "CCMPopupSegue.h"
#import "CCMPopupTransitioning.h"

@implementation CCMPopupSegue

- (instancetype)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination{
    self = [super initWithIdentifier:identifier source:source destination:destination];
    if (self) {
        _backgroundBlurRadius = 5;
        _backgroundViewAlpha = 0;
    }
    return self;
}

-(void)perform{
    UIViewController<UIViewControllerTransitioningDelegate> *source = [self sourceViewController];
    UIViewController *destination = [self destinationViewController];
    
    //destination.transitioningDelegate = source;
    
    //CGRect sourceBounds = source.view.bounds;
    //CGSize navSize = self.presentingViewSize;
    
    CCMPopupTransitioning *delegate = [CCMPopupTransitioning sharedInstance];
    delegate.backgroundBlurRadius = self.backgroundBlurRadius;
    delegate.backgroundViewAlpha = self.backgroundViewAlpha;
    delegate.backgroundViewColor = self.backgroundViewColor;
    delegate.dismissableByTouchingBackground = self.dismissableByTouchingBackground;
    delegate.presentedController = destination;
    delegate.presentingController = source;
    delegate.presentedController.modalPresentationStyle = UIModalPresentationCustom;
    delegate.destinationBounds = self.destinationBounds;
    
    if ([source conformsToProtocol:@protocol(UIViewControllerTransitioningDelegate)]) {
        source.transitioningDelegate = source;
        destination.transitioningDelegate = source;
    }
    //delegate.destinationFrame = self.destinationFrame;
    
    [source presentViewController:destination animated:YES completion:nil];
}

@end
