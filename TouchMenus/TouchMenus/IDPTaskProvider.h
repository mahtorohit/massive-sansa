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

@protocol ExperimentController <NSObject>

- (void) createViewControllerOfName:(NSString *)viewControllerName;
- (void) setTaskMessage:(NSString *)message;
- (void) didFinish;
- (void) didFinishExperiment;
- (void) didFinishTask;

@end

@interface IDPTaskProvider : NSObject <UIAlertViewDelegate>

@property id<ExperimentController> experimentControllerDelegate;
@property id<MenuCandidate> currentMenu;

//singleton
+ (IDPTaskProvider *) sharedInstance;

//start/stop
- (void) prepareNextExperiment;
- (void) startNextExperiment;

//collect all MenuItem clicks
- (void) selectItem:(MenuItem *)item;

//- (void) registerExperimentStatusDelegate:(id<ExperimentStatus>)experimentStatusDelegate;

@end
