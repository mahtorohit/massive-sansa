//
//  GMCollectionViewController.h
//  TouchMenus
//
//  Created by Nađa on 2/15/13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCTableViewController.h"
#import "IDPTaskProvider.h"

@interface GMCollectionViewController : UIViewController <BreadCrumbDelegate, MenuCandidate>

@property (strong, nonatomic) IBOutlet UIButton *backButton;

@end
