//
//  CSVLogger.h
//  TouchMenus
//
//  Created by Steffen Bauereiss on 26.02.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSVLogger : NSObject

+ (CSVLogger *) sharedInstance;

- (void) logToFileAt:(double)timestamp mesage:(NSString *)msg itemTitle:(NSString *)title;


@end
