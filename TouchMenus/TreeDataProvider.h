//
//  Created by Steffen Bauereiss on 24.12.12.
//  Copyright (c) 2012 Steffen Bauereiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeMenuItem.h"

@interface TreeDataProvider : NSObject

+ (TreeDataProvider *) sharedInstance;
- (NSArray *) getRootLevelElements;
- (TreeMenuItem *) getRootMenuItem;


@end
