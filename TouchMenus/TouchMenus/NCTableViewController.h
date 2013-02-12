//
//  NCTableViewController.h
//  NavController
//
//  Created by Steffen Bauereiss on 10.02.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"

@protocol BreadCrumbDelegate <NSObject>
- (void) addToBreadCrumb:(id)tblv;
@end

@interface NCTableViewController : UITableViewController

@property (strong,nonatomic) MenuItem* menuItem;
@property id<BreadCrumbDelegate> delegate;

@end