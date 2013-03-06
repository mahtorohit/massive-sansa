//
//  ULViewController.h
//  UnfoldingListMenu
//
//  Created by Nađa on 1/14/13.
//  Copyright (c) 2013 Nađa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDPTaskProvider.h"

@interface ULViewController : UITableViewController<MenuCandidate>

@property (strong, nonatomic) NSArray* treeItems;

@end
