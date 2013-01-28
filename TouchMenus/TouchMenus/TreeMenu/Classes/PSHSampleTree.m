//
//  PSHSampleTree.m
//  PSHTreeGraph
//
//  Created by mahmuzic on 10.01.13.
//  Copyright (c) 2013 Preston Software. All rights reserved.
//

#import "PSHSampleTree.h"

@implementation PSHSampleTree
@synthesize name;

- (id)init
{
    self = [super init];
    if (self) {
        self.name = @"Test";
    }
    return self;
}
- (id<PSTreeGraphModelNode>)parentModelNode {
    return self;
}

- (NSArray *)childModelNodes {
    return nil;
}

@end
