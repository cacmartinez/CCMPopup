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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTop;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBotton;
@property (weak, nonatomic) IBOutlet CCMBorderView *buttonContainerView;

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CCMPopupSegue *popupSegue = (CCMPopupSegue *)segue;
    popupSegue.destinationBounds = CGRectMake(0, 0, 300, 400);
    popupSegue.backgroundBlurRadius = 7;
    popupSegue.backgroundViewAlpha = 0.3;
    popupSegue.backgroundViewColor = [UIColor blackColor];
    popupSegue.dismissableByTouchingBackground = YES;
}

- (IBAction)didDismissSegue:(UIStoryboardSegue *)segue {
    
}

@end
