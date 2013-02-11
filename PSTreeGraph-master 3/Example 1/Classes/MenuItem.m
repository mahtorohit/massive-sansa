//
//  Created by Steffen Bauereiss on 24.12.12.
//  Copyright (c) 2012 Steffen Bauereiss. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

@synthesize img = _img;

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
	if (imgURL != nil && self.img == nil) {
		UIImage *img = [UIImage imageNamed:imgURL];
		
		CGSize newSize = CGSizeMake(500, 500);
		UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);
		
		float imgW = 500;
		float imgH = 500;
		float imgX = 0;
		float imgY = 0;
		
		if (img.size.height > img.size.width)
		{
			imgW = (500/img.size.height)*img.size.width;
			imgX = (500-imgW)/2;
		}
		else
		{
			imgH = (500/img.size.width)*img.size.height;
			imgY = (500-imgH)/2;
		}
		
		[[UIColor whiteColor] setFill];
		[[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, newSize.width, newSize.height)] fill];
		
		[img drawInRect:CGRectMake(imgX, imgY, imgW, imgH)];
	
		UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		self.img = newImage;
	}
	
	return self.img;
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

- (id<PSTreeGraphModelNode>)parentModelNode {
    return (MenuItem *)[self getParent];
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
        return -1;
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
