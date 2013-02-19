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
- (void) resetMenu;
	//resets all menu-structure to default;
	//?? REQUIRED TO RELOAD DATA! (DataProvider may have been changed by taskprovider)
@end

@protocol ExperimentStatus <NSObject>
- (void) setTaskMessage:(NSString *)message;
- (void) didFinishExperiment;
- (void) didFinishTask;
@end

@protocol ExperimentController <NSObject>

- (void) createViewControllerOfName:(NSString *)viewControllerName;

@end

@interface IDPTaskProvider : NSObject

@property id<ExperimentController> experimentControllerDelegate;

//singleton
+ (IDPTaskProvider *) sharedInstance;

//start/stop
- (void) startNextExperiment;

//collect all MenuItem clicks
- (void) selectItem:(MenuItem *)item;

- (void) registerExperimentStatusDelegate:(id<ExperimentStatus>)experimentStatusDelegate;

@end
