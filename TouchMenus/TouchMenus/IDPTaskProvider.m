//
//  IDPTaskProvider.m
//  TouchMenus
//
//  Created by Steffen Bauereiss on 15.02.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import "IDPTaskProvider.h"
#import "IDPExercise.h"

@interface IDPTaskProvider()

@property NSString *targetItem;
@property NSMutableArray *exercises;
@property IDPExercise *currentExercise;

@end

@implementation IDPTaskProvider

@synthesize targetItem = _targetItem;
@synthesize currentMenu = _currentMenu;
@synthesize experimentControllerDelegate = _experimentControllerDelegate;

@synthesize exercises = _exercises;

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
		
		self.exercises = [IDPExercise exerciseSet];
		
	}
	return self;
}

int cnt = 0;

- (void) prepareNextExperiment
{
	
	self.currentExercise = [self.exercises lastObject];
	[self.exercises removeLastObject];
	
	[self.experimentControllerDelegate createViewControllerOfName:self.currentExercise.menuIdentifier];
}

- (void) startNextExperiment
{
	[self.currentMenu resetMenu];
	[self startNextTask];
}

- (void) startNextTask
{
	if ([self.currentExercise.tasksForMenu count] == 0)
	{
		if ([self.exercises count] > 0)
		{
			[self.experimentControllerDelegate didFinishExperiment];
			[self prepareNextExperiment];
		}
		else
		{
			[self.experimentControllerDelegate didFinish];
		}
	}
	else
	{
		self.targetItem = [self.currentExercise.tasksForMenu lastObject];
		[self.currentExercise.tasksForMenu removeLastObject];
		
		[self.experimentControllerDelegate setTaskMessage:[NSString stringWithFormat:@"Bitte suchen Sie \"%@\"", self.targetItem]];
		
	}	
}

- (void) selectItem:(MenuItem *)item
{
	//Protokollierung aller gelaufenen Wege hier möglich!
	
	NSLog(@"%@",[item getTitle]);
	
	if ([[item getTitle] isEqualToString:self.targetItem])
	{
		[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(finishedTask) userInfo:nil repeats:NO];
	}
}

- (void) finishedTask
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gefunden"
													message:@"und weiter gehts..."
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
	
	[self.experimentControllerDelegate didFinishTask];
	[self startNextTask];
}

@end