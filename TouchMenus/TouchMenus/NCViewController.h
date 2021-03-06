//
//  NCViewController.h
//  NavController
//
//  Created by Steffen Bauereiss on 10.02.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCTableViewController.h"
#import "IDPTaskProvider.h"


@interface NCViewController : UIViewController <UIGestureRecognizerDelegate, BreadCrumbDelegate, MenuCandidate>

@property (strong, nonatomic) IBOutlet UIButton *backButton;

@end
