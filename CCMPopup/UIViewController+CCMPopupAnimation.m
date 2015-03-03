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

#import "UIViewController+CCMPopupAnimation.h"
#import "CCMPopupAnimation.h"

@implementation UIViewController (CCMPopupAnimation)

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    CCMPopupAnimation *animation = [CCMPopupAnimation new];
    animation.presenting = YES;
    return animation;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    CCMPopupAnimation *animation = [CCMPopupAnimation new];
    return animation;
}

-(void)dismissAnimated{
    if([self isKindOfClass:[UIViewController class]]){
        UIViewController *controller = (UIViewController *)self;
        [controller dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
