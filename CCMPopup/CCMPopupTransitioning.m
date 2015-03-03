//
//  Copyright (c) 2015 Carlos Compean (cacmartinez@msn.com).
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
    _presentedController.modalPresentationStyle = UIModalPresentationCustom;
}

@end
