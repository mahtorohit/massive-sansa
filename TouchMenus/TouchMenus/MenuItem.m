//
//  Created by Steffen Bauereiss on 24.12.12.
//  Copyright (c) 2012 Steffen Bauereiss. All rights reserved.
//

#import "MenuItem.h"
#import "IDPTaskProvider.h"

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

// Logging relevant
- (void) selectItem
{
	[[IDPTaskProvider sharedInstance] selectItem:self];
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
		
		CGSize newSize = CGSizeMake(200, 200);
		UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);
		
		float imgW = newSize.width;
		float imgH = newSize.height;
		float imgX = 0;
		float imgY = 0;
		
		if (img.size.height > img.size.width)
		{
			imgW = (newSize.height/img.size.height)*img.size.width;
			imgX = (newSize.width-imgW)/2;
		}
		else
		{
			imgH = (newSize.width/img.size.width)*img.size.height;
			imgY = (newSize.height-imgH)/2;
		}
		
		[[UIColor whiteColor] setFill];
		[[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, newSize.width, newSize.height)] fill];
		
		[img drawInRect:CGRectMake(imgX, imgY, imgW, imgH)];
	
		if ([self getChildrenCount] > 0) [[UIImage imageNamed:@"toggle-expand-alt"] drawInRect:CGRectMake(newSize.width-64, newSize.height-64, 64, 64)];
		
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


@end
