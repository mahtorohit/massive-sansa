//
//  IDPTaskProvider.m
//  TouchMenus
//
//  Created by Steffen Bauereiss on 15.02.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import "IDPTaskProvider.h"

@interface IDPTaskProvider()

@property NSString *targetItem;
@property NSMutableArray *experimentStatusDelegate;

@property NSMutableArray *taskSet;

@end

@implementation IDPTaskProvider

@synthesize targetItem = _targetItem;
@synthesize experimentStatusDelegate = _experimentStatusDelegate;
@synthesize experimentControllerDelegate = _experimentControllerDelegate;

@synthesize taskSet = _taskSet;

static IDPTaskProvider *_sharedMySingleton = nil;

+ (IDPTaskProvider *) sharedInstance
{
	@synchronized([IDPTaskProvider class])
	{
		if (!_sharedMySingleton)
			return [[self alloc] init];
		return _sharedMySingleton;
	}
	return nil;
}

+ (id) alloc
{
	@synchronized([IDPTaskProvider class])
	{
		NSAssert(_sharedMySingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedMySingleton = [super alloc];
		return _sharedMySingleton;
	}
	return nil;
}

- (id) init
{
	self = [super init];
	if (self != nil) {
		self.experimentStatusDelegate = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void) startNextExperiment
{
	
	[self.experimentControllerDelegate createViewControllerOfName:@"2DCoverflow"];
	self.taskSet = [[NSMutableArray alloc] initWithObjects:@"Feldsalat", @"Erbsen", @"Apfel", @"Limette", nil];

	[self startNextTask];
}

- (void) startNextTask
{
	
	if ([self.taskSet count] == 0)
	{
		for (id<ExperimentStatus> delegate in self.experimentStatusDelegate)
		{
			[delegate didFinishExperiment];
			[self startNextExperiment];
		}
	}
	else
	{
		self.targetItem = [self.taskSet lastObject];
		[self.taskSet removeLastObject];
		
		for (id<ExperimentStatus> delegate in self.experimentStatusDelegate)
		{
			[delegate setTaskMessage:[NSString stringWithFormat:@"Bitte suchen sie \"%@\"", self.targetItem]];
		}
	}
	
}

- (void) registerExperimentStatusDelegate:(id<ExperimentStatus>)experimentStatusDelegate
{
	[self.experimentStatusDelegate addObject:experimentStatusDelegate];
}

- (void) selectItem:(MenuItem *)item
{
	//Protokollierung aller gelaufenen Wege hier möglich!
	NSLog(@"%@",[item getTitle]);
	
	if ([[item getTitle] isEqualToString:self.targetItem])
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gefunden"
														message:@"und weiter gehts..."
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
		
		[self startNextTask];
	}
}

@end