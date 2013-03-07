//
//  IDPTaskProvider.m
//  TouchMenus
//
//  Created by Steffen Bauereiss on 15.02.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import "IDPTaskProvider.h"
#import "IDPExercise.h"
#import "DataProvider.h"
#import <AVFoundation/AVFoundation.h>
#import "CSVLogger.h"

@interface IDPTaskProvider() {
	double startTime;
	double endTime;
}

@property NSString *targetItem;
@property NSMutableArray *exercises;
@property IDPExercise *currentExercise;
@property AVAudioPlayer *audioPlayer;
@property UIAlertView *alert;

@end

@implementation IDPTaskProvider

@synthesize targetItem = _targetItem;
@synthesize currentMenu = _currentMenu;
@synthesize experimentControllerDelegate = _experimentControllerDelegate;

@synthesize exercises = _exercises;

@synthesize audioPlayer = _audioPlayer;

@synthesize alert = _alert;


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
	
	[[DataProvider sharedInstance] useDataset:[self.currentExercise.dataSet integerValue]];
	
	BOOL lock = [self.currentExercise.dataSet intValue] == 2;
	
	UIViewController *vc = [self.experimentControllerDelegate createViewControllerOfName:self.currentExercise.menuIdentifier andLock:lock];
	self.currentMenu = (id<MenuCandidate>)vc; //TODO: MAKE SURE THIS HOLDS FOR EVERY MENU
	
	vc = nil;
	
	if (lock)
	{
//		[NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(unlock) userInfo:nil repeats:NO];
	} else {
		[self startNextExperiment];
	}
}
- (void)unlock
{
	[self.experimentControllerDelegate unlock];
}

- (void) startNextExperiment
{
	startTime = CACurrentMediaTime();

	[self startNextTask:NO];
}

- (void) startNextTask:(BOOL)audio
{
	if (audio) [self playClickAudio];
	
	endTime = CACurrentMediaTime();
	
	if (audio)
	{
		//this audio flag works for this logmsg as audio is always plaed upon selections but never upon START EXPERIMENT
		[[CSVLogger sharedInstance] logToFileAt:endTime message:@"FOUND" itemTitle:self.targetItem];
	}

	self.targetItem = nil;
	
	if ([self.currentExercise.tasksForMenu count] == 0)
	{
		if ([self.exercises count] > 0)
		{
			//done with ex
			
			//was it a dummy exercise???
			if ([self.currentExercise.dataSet intValue] == 2) {
				[[CSVLogger sharedInstance] logToFileAt:endTime message:@"EXERCISE DONE" itemTitle:@""];
				
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Los gehts!"
																message:@""
															   delegate:self
													  cancelButtonTitle:@"OK"
													  otherButtonTitles:nil];
				[alert show];
			}
			//is the next one the same menu???
			else if ([self.currentExercise.menuIdentifier isEqualToString:((IDPExercise *)[self.exercises lastObject]).menuIdentifier]) {
				[[CSVLogger sharedInstance] logToFileAt:endTime message:@"EXERCISE DONE" itemTitle:@""];
				
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gefunden"
																message:@"Weiter mit dem nächsten Shop"
															   delegate:self
													  cancelButtonTitle:@"OK"
													  otherButtonTitles:nil];
				[alert show];
			}
			else
			{
				[[CSVLogger sharedInstance] logToFileAt:endTime message:@"EXERCISE DONE" itemTitle:@""];
				
				self.alert = [[UIAlertView alloc] initWithTitle:@"Gefunden"
																message:@"Das wars mit diesem Menü. \n\n Bitte wende dich an den Versuchsleiter um fortzufahren. \n\n  Weiter geht es mit den Fragebögen zu diesem Menü."
															   delegate:self
													  cancelButtonTitle:nil
													  otherButtonTitles:nil];
				[self.alert show];
				[NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(makeDoneAlertClickable) userInfo:nil repeats:NO];
				
			}
			
		}
		else
		{
			//all done

			[[CSVLogger sharedInstance] logToFileAt:endTime message:@"FINISHED" itemTitle:@""];
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Geschafft"
															message:@"Danke für die Teilnahme"
														   delegate:nil
												  cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
			[alert show];
			
			[self.experimentControllerDelegate didFinish];
			
			[[CSVLogger sharedInstance] closeFileHandle:[self.experimentControllerDelegate tellMe]];
		}
	}
	else
	{
		//next
		self.targetItem = [self.currentExercise.tasksForMenu lastObject];
		[self.currentExercise.tasksForMenu removeLastObject];

		[self.currentMenu resetMenu];
		
		[self.experimentControllerDelegate setTaskMessage:[NSString stringWithFormat:@"Bitte suchen Sie \"%@\"", self.targetItem]];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Neue Aufgabe"
														message:[NSString stringWithFormat:@"Bitte suchen Sie \"%@\"", self.targetItem]
													   delegate:self
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];

	}	
}

- (void) makeDoneAlertClickable
{
	[self.alert dismissWithClickedButtonIndex:99 animated:NO];
	
	[[CSVLogger sharedInstance] logToFileAt:endTime message:@"EXERCISE DONE" itemTitle:@""];
	
	self.alert = [[UIAlertView alloc] initWithTitle:@"Gefunden"
											message:@"Das wars mit diesem Menü. \n\n Bitte wende dich an den Versuchsleiter um fortzufahren. \n\n  Weiter geht es mit den Fragebögen zu diesem Menü."
										   delegate:self
								  cancelButtonTitle:@"Ok, fertig"
								  otherButtonTitles:nil];
	[self.alert show];
}

- (void) playClickAudio {
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/button-16.mp3", [[NSBundle mainBundle] resourcePath]]];
	
	NSError *error;
	self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	self.audioPlayer.numberOfLoops = 0;
	
	if (self.audioPlayer == nil)
		NSLog(@"%@", [error description]);
	else
		[self.audioPlayer play];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
	if (buttonIndex == 99) return;
	
	startTime = CACurrentMediaTime();
	
	if ([alertView.title isEqualToString:@"Gefunden"] || [alertView.title isEqualToString:@"Los gehts!"]) //GEFUNDEN indicates that the current Experiment was completed
	{
		[self.experimentControllerDelegate didFinishExperiment];
		[self prepareNextExperiment];
	}
	else if ([alertView.title isEqualToString:@"Neue Aufgabe"])
	{
		[[CSVLogger sharedInstance] logToFileAt:startTime message:@"ISSUED" itemTitle:self.targetItem];
	}
}

- (void) selectItem:(MenuItem *)item
{
	//Protokollierung aller gelaufenen Wege hier möglich!

	[[CSVLogger sharedInstance] logToFileAt:CACurrentMediaTime() message:@"SELECT" itemTitle:[item getTitle]];
    NSLog(@"Selected: %@ and target is %@", item.getTitle, _targetItem);
    
	if ([[item getTitle] isEqualToString:self.targetItem])
	{
		[self finishedTask];
//		[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(finishedTask) userInfo:nil repeats:NO];
	}
}

- (void) finishedTask
{	
	[self.experimentControllerDelegate didFinishTask];
	[self startNextTask:YES];
}


//only for logging:
- (void) backButtonClicked
{
	[[CSVLogger sharedInstance] logToFileAt:CACurrentMediaTime() message:@"BACKBUTTON" itemTitle:@""];
}
- (void) breadCrumbClickedToTargetItem:(MenuItem *)item
{
	[[CSVLogger sharedInstance] logToFileAt:CACurrentMediaTime() message:@"BREADCRUMB" itemTitle:[item getTitle]];
}
- (void) breadCrumbClickedToTarget:(NSString *)itemTitle
{
	[[CSVLogger sharedInstance] logToFileAt:CACurrentMediaTime() message:@"BREADCRUMB" itemTitle:itemTitle];
}
- (void) swipeRecognizedFrom:(CGPoint)from to:(CGPoint)to
{
	[[CSVLogger sharedInstance] logToFileAt:CACurrentMediaTime() swipeFrom:from to:to direction:0];
}
- (void) swipeRecognizedInDirection:(UISwipeGestureRecognizerDirection)direction
{
	[[CSVLogger sharedInstance] logToFileAt:CACurrentMediaTime() swipeFrom:CGPointMake(-1, -1) to:CGPointMake(-1, -1) direction:direction];
}
- (void) clickedOutside
{
	[[CSVLogger sharedInstance] logToFileAt:CACurrentMediaTime() message:@"OUTSIDE" itemTitle:@""];
}
- (void) otherActionPerformed:(NSString *)action withDescription:(NSString *)description
{
	[[CSVLogger sharedInstance] logToFileAt:CACurrentMediaTime() message:action itemTitle:description];
}

@end