//
//  MainViewController.h
//  TouchMenus
//
//  Created by Steffen Bauereiss on 19.02.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDPTaskProvider.h"

@interface MainViewController : UIViewController <ExperimentController, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *taskLabel;
@property (strong, nonatomic) IBOutlet UIButton *startButton;

@end
