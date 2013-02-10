//
//  Created by Steffen Bauereiss on 24.12.12.
//  Copyright (c) 2012 Steffen Bauereiss. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

// Initialization/Setup

- (id) initWithTitle:(NSString*)theTitle imgUrl:(NSString*)theImgURL usingChildren:(NSArray *)children andParent:(MenuItem *)theParent{
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
}- (void) setParent:(MenuItem*) theParent {
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
	return [UIImage imageNamed:imgURL];
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
- (MenuItem *) getParent {
	return parent;
}

- (BOOL) isLeaf {
	return childMenuItems == nil;
}

- (int) getLevel {
    
    int level = 0;
    MenuItem* currentParent = self.getParent;

    while (currentParent != nil){
        level++;
        currentParent = [currentParent getParent];
    }
    
    return level;
}

- (NSArray*) getAncestors {
    
    NSMutableArray* ancestors = [[NSMutableArray alloc]init];
    MenuItem* currentParent = self.getParent;
    
    while (currentParent != nil) {
        [ancestors addObject:currentParent];
        currentParent = [currentParent getParent];
    }
    
    return ancestors;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"MenuItem=%@", [self getTitle]];
}


@end
