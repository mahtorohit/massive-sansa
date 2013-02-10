//
//  HLViewController.h
//  TouchMenus
//
//  Created by Nađa on 2/10/13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *menuItems;
@property (weak, nonatomic) IBOutlet UICollectionView *colView;

@end
