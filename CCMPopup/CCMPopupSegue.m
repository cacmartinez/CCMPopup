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
    delegate.dynamic = self.dynamic;
    delegate.dismissableByTouchingBackground = self.dismissableByTouchingBackground;
    delegate.presentedController = destination;
    delegate.presentingController = source;
    //delegate.presentedController.modalPresentationStyle = UIModalPresentationCustom;
    delegate.destinationBounds = self.destinationBounds;
    
    if ([source conformsToProtocol:@protocol(UIViewControllerTransitioningDelegate)]) {
        source.transitioningDelegate = source;
        destination.transitioningDelegate = source;
    }
    //delegate.destinationFrame = self.destinationFrame;
    
    [source presentViewController:destination animated:YES completion:nil];
}

@end
