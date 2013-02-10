//
//  Created by Steffen Bauereiss on 24.12.12.
//  Copyright (c) 2012 Steffen Bauereiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject {
	NSString *title;
	NSString *imgURL;
	NSArray *childMenuItems;
	MenuItem *parent;
}

@property (retain) UIImage *img;

- (id) initWithTitle:(NSString*)theTitle imgUrl:(NSString*)theImgURL usingChildren:(NSArray *)children andParent:(MenuItem*)parent;
- (void) setChildren:(NSArray*) children;
- (void) setParent:(MenuItem*) parent;

- (NSString*) getTitle; //nil if none

- (NSString*) getImgUrl; //nil if none
- (UIImage *) getImg; //nil if none

- (int) getChildrenCount; //0 if none
- (NSArray *) getChildren; //nil if none
- (int) getLevel; //0 if none
- (NSArray *) getAncestors; //nil if none
- (MenuItem *) getParent; //nil if none
- (BOOL) isLeaf;

@end
