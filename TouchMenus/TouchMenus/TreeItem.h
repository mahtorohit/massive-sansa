//
//  TreeItem.h
//  UnfoldingListMenu
//
//  Created by Nađa on 1/14/13.
//  Copyright (c) 2013 Nađa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuItem.h"

@interface TreeItem : NSObject 

@property (strong,nonatomic) MenuItem *menuItem;
@property (strong,nonatomic) TreeItem *ptreeItem;

- (void) setUnfolded:(BOOL)b;
- (BOOL) isUnfolded;

@end
