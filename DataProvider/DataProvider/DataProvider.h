//
//  Created by Steffen Bauereiss on 24.12.12.
//  Copyright (c) 2012 Steffen Bauereiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuItem.h"

@interface DataProvider : NSObject

+ (DataProvider *) sharedInstance;
- (NSArray *) getRootLevelElements;

@end
