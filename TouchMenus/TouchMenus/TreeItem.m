//
//  TreeItem.m
//  UnfoldingListMenu
//
//  Created by Nađa on 1/14/13.
//  Copyright (c) 2013 Nađa. All rights reserved.
//

#import "TreeItem.h"

@implementation TreeItem {
    BOOL unfolded;
    
}

@synthesize menuItem;

- (void) setUnfolded:(BOOL)b {
    unfolded = b;
}

- (BOOL) isUnfolded {
    return unfolded;
}

@end
