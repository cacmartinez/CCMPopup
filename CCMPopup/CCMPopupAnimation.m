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

#import "CCMPopupAnimation.h"
#import "CCMPopupTransitioning.h"
#import "UIImage+screenshot.h"
#import "UIImage+ImageEffects.h"
#import "UIViewController+CCMPopupAnimation.h"
#import "FXBlurView.h"

static FXBlurView *blurredBackground;
static UIView *touchView;

@interface CCMPopupAnimation ()

@property id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation CCMPopupAnimation

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.4;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    if (self.presenting) {
        [self animatePresentationTransition:transitionContext];
    } else {
        [self animateDismissTransition:transitionContext];
    }
}

- (void)animatePresentationTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CCMPopupTransitioning *popupTransitioning = [CCMPopupTransitioning sharedInstance];
    CGRect endBounds = [popupTransitioning destinationBounds];
    
    toViewController.view.frame = endBounds;
    toViewController.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    if (popupTransitioning.backgroundBlurRadius != 0) {
//        blurredBackground = [[UIImageView alloc] initWithImage:[[UIImage screenshot] applyBlurWithRadius:5.0 tintColor:[UIColor colorWithRed:20/255.0 green:36/255.0 blue:47/255.0 alpha:0.6] saturationDeltaFactor:1.0 maskImage:nil]];
        //blurredBackground = [[UIImageView alloc] initWithImage:[[UIImage screenshot] applyBlurWithRadius:popupTransitioning.backgroundBlurRadius tintColor:nil saturationDeltaFactor:1.0 maskImage:nil]];
        blurredBackground = [[FXBlurView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        blurredBackground.tintColor = [UIColor clearColor];
        blurredBackground.blurRadius = popupTransitioning.backgroundBlurRadius;
        blurredBackground.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        blurredBackground.dynamic = popupTransitioning.dynamic;
    }
    touchView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    touchView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    if (popupTransitioning.backgroundViewAlpha != 0) {
        touchView.backgroundColor = popupTransitioning.backgroundViewColor;
        touchView.alpha = popupTransitioning.backgroundViewAlpha;
    } else {
        touchView.alpha = 1;
        touchView.backgroundColor = [UIColor clearColor];
    }
    
    
    toViewController.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
    toViewController.view.layer.position = fromViewController.view.center;
    toViewController.view.layer.bounds = endBounds;
    //toViewController.view.layer.cornerRadius = 6.0;
    //toViewController.view.clipsToBounds = YES;
    
    [transitionContext.containerView addSubview:fromViewController.view];
    if (popupTransitioning.backgroundBlurRadius != 0) {
        [transitionContext.containerView addSubview:blurredBackground];
    }
    [transitionContext.containerView addSubview:touchView];
    [transitionContext.containerView addSubview:toViewController.view];
    
    if (popupTransitioning.dismissableByTouchingBackground) {
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:toViewController action:@selector(dismissAnimated)];
        [touchView addGestureRecognizer:gestureRecognizer];
    }
    
    CAKeyframeAnimation *popupAnimation = [CAKeyframeAnimation animation];
    popupAnimation.keyPath = @"transform.scale";
    popupAnimation.values = @[@(1/3.0), @1.1, @1.0];
    popupAnimation.keyTimes = @[@0, @(10/20.0), @1];
    popupAnimation.timingFunctions = @[
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]
                                       ];
    popupAnimation.duration = [self transitionDuration:transitionContext];
    
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animation];
    fadeInAnimation.keyPath = @"opacity";
    fadeInAnimation.fromValue = @0.3;
    fadeInAnimation.toValue = @1;
    fadeInAnimation.duration = [self transitionDuration:transitionContext]/2;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = [self transitionDuration:transitionContext];
    animationGroup.delegate = self;
    animationGroup.animations = @[popupAnimation, fadeInAnimation];
    
    [toViewController.view.layer addAnimation:animationGroup forKey:@"toViewAnimations"];
    
    if (popupTransitioning.backgroundBlurRadius != 0) {
        CABasicAnimation *fadeInBlurredBackgroundAnimation = [CABasicAnimation animation];
        fadeInBlurredBackgroundAnimation.keyPath = @"opacity";
        fadeInBlurredBackgroundAnimation.fromValue = @0.2;
        fadeInBlurredBackgroundAnimation.toValue = @1;
        fadeInBlurredBackgroundAnimation.duration = 3 * [self transitionDuration:transitionContext] / 4;
    
        [blurredBackground.layer addAnimation:fadeInBlurredBackgroundAnimation forKey:@"fadeInBackground"];
    }
    
    if (popupTransitioning.backgroundViewAlpha != 0) {
        CABasicAnimation *fadeInTouchViewAnimation = [CABasicAnimation animation];
        fadeInTouchViewAnimation.keyPath = @"opacity";
        fadeInTouchViewAnimation.fromValue = @0;
        fadeInTouchViewAnimation.toValue = @(touchView.alpha);
        fadeInTouchViewAnimation.duration = 3 * [self transitionDuration:transitionContext] / 4;
        
        [touchView.layer addAnimation:fadeInTouchViewAnimation forKey:@"fadeInTouchView"];
    }
}

- (void)animateDismissTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CCMPopupTransitioning *popupTransitioning = [CCMPopupTransitioning sharedInstance];
    //CGRect endBounds = [popupTransitioning destinationBounds];
    
    [transitionContext.containerView addSubview:toViewController.view];
    if (popupTransitioning.backgroundBlurRadius != 0) {
        [transitionContext.containerView addSubview:blurredBackground];
    }
    [transitionContext.containerView addSubview:touchView];
    [transitionContext.containerView addSubview:fromViewController.view];
    
    CAKeyframeAnimation *popupAnimation = [CAKeyframeAnimation animation];
    popupAnimation.keyPath = @"transform.scale";
    popupAnimation.values = @[@1.0, @1.1, @(1/3.0)];
    popupAnimation.keyTimes = @[@0, @(10/20.0), @1];
    popupAnimation.timingFunctions = @[
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]
                                       ];
    popupAnimation.duration = [self transitionDuration:transitionContext];
    popupAnimation.removedOnCompletion = NO;
    
    CAKeyframeAnimation *fadeInAnimation = [CAKeyframeAnimation animation];
    fadeInAnimation.keyPath = @"opacity";
    fadeInAnimation.values = @[@1, @1, @0.3];
    fadeInAnimation.keyTimes = @[@0, @0.5, @1];
    fadeInAnimation.duration = [self transitionDuration:transitionContext];
    fadeInAnimation.removedOnCompletion = NO;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = [self transitionDuration:transitionContext];
    animationGroup.delegate = self;
    animationGroup.animations = @[fadeInAnimation, popupAnimation];
    animationGroup.removedOnCompletion = NO;
    
    if (popupTransitioning.backgroundBlurRadius != 0) {
        CABasicAnimation *fadeInBlurredBackgroundAnimation = [CABasicAnimation animation];
        fadeInBlurredBackgroundAnimation.keyPath = @"opacity";
        fadeInBlurredBackgroundAnimation.fromValue = @1;
        fadeInBlurredBackgroundAnimation.toValue = @0.2;
        fadeInBlurredBackgroundAnimation.duration = 3 * [self transitionDuration:transitionContext] / 4;
        fadeInBlurredBackgroundAnimation.removedOnCompletion = NO;
        
        blurredBackground.layer.opacity = 0.2;
        
        [blurredBackground.layer addAnimation:fadeInBlurredBackgroundAnimation forKey:@"fadeOutBackground"];
    }
    
    if (popupTransitioning.backgroundViewAlpha != 0) {
        CABasicAnimation *fadeOutTouchViewAnimation = [CABasicAnimation animation];
        fadeOutTouchViewAnimation.keyPath = @"opacity";
        fadeOutTouchViewAnimation.fromValue = @(popupTransitioning.backgroundViewAlpha);
        fadeOutTouchViewAnimation.toValue = @0;
        fadeOutTouchViewAnimation.duration = 3 * [self transitionDuration:transitionContext] / 4;
        fadeOutTouchViewAnimation.removedOnCompletion = NO;
        
        touchView.layer.opacity = 0;
        [touchView.layer addAnimation:fadeOutTouchViewAnimation forKey:@"fadeOutTouchView"];
    }
    
    
    fromViewController.view.layer.transform = CATransform3DMakeScale(1/3.0, 1/3.0, 1);
    fromViewController.view.layer.opacity = 0.3;
    
    [fromViewController.view.layer addAnimation:animationGroup forKey:@"fromViewAnimations"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [self.transitionContext completeTransition:YES];
        if (!self.presenting) {
            blurredBackground = nil;
            touchView = nil;
            [CCMPopupTransitioning nilOutSharedInstance];
        }
        UIViewController *toViewController = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        if (!toViewController.view.window) {
            [[[UIApplication sharedApplication] keyWindow] addSubview:toViewController.view];
        }
    }
}

@end
