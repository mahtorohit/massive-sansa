//
//  IDPTaskProvider.h
//  TouchMenus
//
//  Created by Steffen Bauereiss on 15.02.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuItem.h"

@protocol MenuCandidate <NSObject>
- (void) reset; //resets all menu-structure to default;
				//?? REQUIRED TO RELOAD DATA! (DataProvider may have been changed by taskprovider)
@end

@protocol ExperimentStatus <NSObject>
- (void) didFinishExperiment;
@end

@interface IDPTaskProvider : NSObject

//singleton
+ (IDPTaskProvider *) sharedInstance;

//start/stop
- (void) startNextExperiment;

//collect all MenuItem clicks
- (void) selectItem:(MenuItem *)item;

//get notified when done
- (void) registerExperimentStatusDelegate:(id<ExperimentStatus>)experimentStatusDelegate;


@end
