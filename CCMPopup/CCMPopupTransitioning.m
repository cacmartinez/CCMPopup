//
//  PopupTranstioningDelegate.m
//  SecondPrototypePrintoo
//
//  Created by Compean on 21/08/14.
//  Copyright (c) 2014 Icalia Labs. All rights reserved.
//

#import "CCMPopupTransitioning.h"
#import "UIViewController+CCMPopupAnimation.h"

static CCMPopupTransitioning *instance;

@implementation CCMPopupTransitioning

@synthesize presentingController = _presentingController;
@synthesize presentedController = _presentedController;

-(id)init{
    if (instance) {
        return instance;
    }
    self = [super init];
    if (self) {
        instance = self;
        _backgroundBlurRadius = 5;
        _backgroundViewAlpha = 0;
    }
    return self;
}

+(instancetype)sharedInstance{
    @autoreleasepool {
        return (instance)? instance:[[self.class alloc] init];
    }
}

+(void)nilOutSharedInstance {
    instance = nil;
}

-(UIViewController *)presentingController{
    return _presentingController;
}

-(void)setPresentingController:(UIViewController *)presentingController{
    _presentingController = presentingController;
    _presentingController.transitioningDelegate = self;
}

-(UIViewController *)presentedController{
    return _presentedController;
}

-(void)setPresentedController:(UIViewController *)presentedController{
    _presentedController = presentedController;
    _presentedController.transitioningDelegate = self;
}

@end
