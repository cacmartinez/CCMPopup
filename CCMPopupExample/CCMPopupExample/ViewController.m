//
//  ViewController.m
//  CCMPopupExample
//
//  Created by Compean on 26/02/15.
//  Copyright (c) 2015 Carlos Compean. All rights reserved.
//

#import "ViewController.h"
#import "CCMPopupSegue.h"
#import "CCMBorderView.h"
#import "CCMPopupTransitioning.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTop;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBotton;
@property (weak, nonatomic) IBOutlet CCMBorderView *buttonContainerView;
@property (weak, nonatomic) IBOutlet CCMBorderView *secondButtonContainerView;
@property (weak) UIViewController *popupController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageViewTop.image = [self.imageViewTop.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.imageViewBotton.image = [self.imageViewBotton.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.buttonContainerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.buttonContainerView.layer.shadowRadius = 15;
    self.buttonContainerView.clipsToBounds = NO;
    self.buttonContainerView.layer.shadowOffset = CGSizeMake(0, 5);
    //self.imageViewTop.tintColor = [UIColor whiteColor];
    //self.imageViewBotton.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation) && UIInterfaceOrientationIsLandscape([[UIDevice currentDevice] orientation]) && self.popupController.view.bounds.size.height > [UIScreen mainScreen].bounds.size.width) {
        self.popupController.view.bounds = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-20) * .75, [UIScreen mainScreen].bounds.size.width-20);
    } else if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        self.popupController.view.bounds = CGRectMake(0, 0, 300, 400);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressedPopupWithCode:(UIButton *)sender {
    UIViewController *presentingController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"popupController"];
    
    CCMPopupTransitioning *popup = [CCMPopupTransitioning sharedInstance];
    if (UIInterfaceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        popup.destinationBounds = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.height-20) * .75, [UIScreen mainScreen].bounds.size.height-20);
    } else {
        popup.destinationBounds = CGRectMake(0, 0, 300, 400);
    }
    popup.presentedController = presentingController;
    popup.presentingController = self;
    self.popupController = presentingController;
    [self presentViewController:presentingController animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CCMPopupSegue *popupSegue = (CCMPopupSegue *)segue;
    if (UIInterfaceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        popupSegue.destinationBounds = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.height-20) * .75, [UIScreen mainScreen].bounds.size.height-20);
    } else {
        popupSegue.destinationBounds = CGRectMake(0, 0, 300, 400);
    }
    popupSegue.backgroundBlurRadius = 7;
    popupSegue.backgroundViewAlpha = 0.3;
    popupSegue.backgroundViewColor = [UIColor blackColor];
    popupSegue.dismissableByTouchingBackground = YES;
    self.popupController = popupSegue.destinationViewController;
}

- (IBAction)didDismissSegue:(UIStoryboardSegue *)segue {
    
}

@end
