//
//  IDPExercise.h
//  TouchMenus
//
//  Created by Steffen Bauereiss on 21.02.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPExercise : NSObject

@property NSString *menuIdentifier;
@property NSMutableArray *tasksForMenu;


+ (NSMutableArray *) exerciseSet;

@end
