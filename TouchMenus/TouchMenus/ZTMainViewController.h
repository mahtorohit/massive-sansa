//
//  ZTMainViewController.h
//  TouchMenus
//
//  Created by Steffen Bauereiss on 28.01.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTMenuItem.h"

@interface ZTMainViewController : UIViewController<UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *debugLabel;

@end
