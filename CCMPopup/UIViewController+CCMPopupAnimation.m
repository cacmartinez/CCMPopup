//
//  UIViewController+PopupAnimation.m
//  SecondPrototypePrintoo
//
//  Created by Compean on 21/08/14.
//  Copyright (c) 2014 Icalia Labs. All rights reserved.
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
