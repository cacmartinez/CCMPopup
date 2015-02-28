//
//  PopupSegue.h
//  SecondPrototypePrintoo
//
//  Created by Compean on 21/08/14.
//  Copyright (c) 2014 Icalia Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCMPopupSegue : UIStoryboardSegue

@property CGRect destinationBounds;
@property CGFloat backgroundBlurRadius;
@property UIColor *backgroundViewColor;
@property CGFloat backgroundViewAlpha;
@property BOOL dismissableByTouchingBackground;

@end
