//
//  Created by Steffen Bauereiss on 24.12.12.
//  Copyright (c) 2012 Steffen Bauereiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSTreeGraphModelNode.h"
#import "S&TNode.h"

@interface TreeMenuItem : NSObject<PSTreeGraphModelNode, NSCopying> {
	NSString *title;
	NSString *imgURL;
	NSMutableArray *childMenuItems;
    
	TreeMenuItem *parent;
}

- (id) initWithTitle:(NSString*)theTitle imgUrl:(NSString*)theImgURL usingChildren:(NSArray *)children andParent:(TreeMenuItem*)parent;
- (void) setChildren:(NSArray*) children;
- (void) addChildren:(TreeMenuItem*) children;
- (void) setParent:(TreeMenuItem*) parent;

- (NSString*) getTitle; //nil if none

- (NSString*) getImgUrl; //nil if none
- (UIImage *) getImg; //nil if none

- (int) getChildrenCount; //0 if none
- (NSArray *) getChildren; //nil if none
- (TreeMenuItem *) getParent; //nil if none
- (BOOL) isLeaf;
@property (nonatomic,strong) S_TNode * s_tNode;
@end
