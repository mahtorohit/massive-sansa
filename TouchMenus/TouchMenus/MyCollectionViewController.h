//
//  MyCollectionViewController.h
//  GridMenu
//
//  Created by Nađa on 1/10/13.
//  Copyright (c) 2013 Nađa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionViewCell.h"
#import "DataProvider.h"
#import "LeafViewController.h"
#import "NCTableViewController.h"//for delegate protocol

@interface MyCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) MenuItem *menuItem;

@property id<BreadCrumbDelegate> delegate;

@end
