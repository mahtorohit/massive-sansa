//
//  TDTreeItemView.h
//  Grid
//
//  Created by mahmuzic on 20.02.13.
//  Copyright (c) 2013 tum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "MenuItem.h"

@class TDTreeItemView;
@protocol TDTreeItemProtocol <NSObject>

- (void) userItemPressed: (TDTreeItemView *) treeItemView;
- (void) forceViewRefresh;
@end

@interface TDTreeItemView : UIView {
    
}

@property (nonatomic, retain) id<TDTreeItemProtocol> itemDelegate;
@property (nonatomic) CGPoint itemPoistion;
@property (nonatomic, retain) NSString *itemTitle;
@property (nonatomic, retain) IBOutlet UIImageView *itemImageView;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) TDTreeItemView *itemParentView;
@property (nonatomic, retain) NSMutableArray *itemChildren;
@property (nonatomic, retain) MenuItem *menuItem;
@property (nonatomic) BOOL isExpanded;
@property (nonatomic) BOOL selected;

- (void) collapseChildren;

- (int) currentLevel;

// bottom up
- (BOOL) isOnSameBranchAsNode: (TDTreeItemView *) modelNode;

// bottom up
- (TDTreeItemView *) ancestorFromLevel: (int) level;

@end
