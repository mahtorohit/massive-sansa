//
//  Created by Steffen Bauereiss on 24.12.12.
//  Copyright (c) 2012 Steffen Bauereiss. All rights reserved.
//

#import "TreeMenuItem.h"

@implementation TreeMenuItem

// Initialization/Setup

- (id) initWithTitle:(NSString*)theTitle imgUrl:(NSString*)theImgURL usingChildren:(NSArray *)children andParent:(TreeMenuItem *)theParent{
	if (self = [super init]) {
		title = theTitle;
		imgURL = theImgURL;
		childMenuItems = children;
		parent = theParent;
	}
	
	return self;
}
- (void) setChildren:(NSArray*) children {
	childMenuItems = children;
}- (void) setParent:(TreeMenuItem*) theParent {
	parent = theParent;
}

// View / Represenatation relevant

- (NSString*) getTitle {
	return title;
}

- (NSString*) getImgUrl {
	return imgURL;
}
- (UIImage *) getImg {
	if (imgURL == nil) return nil;
	return [UIImage imageNamed:[[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:imgURL] encoding:NSUTF8StringEncoding error:nil]];
}

// Navigation relevant

- (int) getChildrenCount {
	if (![self isLeaf]) {
		return [childMenuItems count];
	}
	return 0;
}
- (NSArray *) getChildren {
	return childMenuItems;
}
- (TreeMenuItem *) getParent {
	return parent;
}

- (BOOL) isLeaf {
	return childMenuItems == nil;
}


- (id<PSTreeGraphModelNode>)parentModelNode {
    return [self getParent];
}

- (NSArray *)childModelNodes {
    NSArray *children = [self getChildren];
    if (!children)
        return [NSArray array];
        
    return children;
}

- (id)copyWithZone:(NSZone *)zone {
    return [self retain];
}

@end
