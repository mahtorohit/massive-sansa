//
//  TreeMenuItem.m
//  PSHTreeGraph
//
//  Created by mahmuzic on 11.02.13.
//  Copyright (c) 2013 Preston Software. All rights reserved.
//

#import "TreeMenuItem.h"

@implementation TreeMenuItem

- (id<PSTreeGraphModelNode>)parentModelNode {
    return (TreeMenuItem *)[self getParent];
}

- (NSArray *)childModelNodes {
    int childrenCount = [self getChildrenCount];
    if (childrenCount == 0)
        return [NSArray array];
    else
        return [self getChildren];
}

- (int)currentLevel {
    if ([self parentModelNode] == nil)
        return 0;
    else
        return 1 + [[self parentModelNode] currentLevel];
}

- (BOOL)isOnSameBranchAsNode:(id<PSTreeGraphModelNode>)modelNode {
    // modelnode is new node
    
    if (modelNode == self)
        return YES;
    
    if ([modelNode parentModelNode] == nil)
        return NO;
    else
        return NO || [self isOnSameBranchAsNode:[modelNode parentModelNode]];
}

- (id<PSTreeGraphModelNode>)ancestorFromLevel:(int)level {
    if (level == 0)
        return nil;
    else if ([self currentLevel] == level)
        return self;
    else
        return [[self parentModelNode] ancestorFromLevel:level];
}

#pragma mark - NSCopying

- (id) copyWithZone:(NSZone *)zone
{
    return [self retain];
}


@end
