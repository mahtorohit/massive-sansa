//
//  MainViewController.m
//  TouchMenus
//
//  Created by Steffen Bauereiss on 19.02.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import "MainViewController.h"
#import "DataProvider.h"

@interface MainViewController ()

@property UIViewController *controller;
@property UIView *lockView;

@end

@implementation MainViewController

@synthesize controller = _controller;
@synthesize lockView = _lockView;

BOOL locked;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
    }
    return self;
}

- (UIViewController *)tellMe
{
	return self;
}

- (void)viewDidLoad
{
    
	[super viewDidLoad];
	
	[DataProvider sharedInstance]; //just to be sure the images will be cached in the background

	
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Reihenfolge festlegen"
													 message:@"Limesurvey-Probanden-ID)"
													delegate:self
										   cancelButtonTitle:@"OK"
										   otherButtonTitles:nil];
	alert.alertViewStyle = UIAlertViewStylePlainTextInput;
	[alert show];
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *input = [[alertView textFieldAtIndex:0] text];

	[[IDPTaskProvider sharedInstance] loadExerciseSet:MAX(0,[input integerValue]-1)];
	[[IDPTaskProvider sharedInstance] setExperimentControllerDelegate:self];
	[[IDPTaskProvider sharedInstance] prepareNextExperiment];
}

- (void)unlock
{
	[self.lockView removeFromSuperview];
	locked = NO;
}

- (UIViewController *) createViewControllerOfName:(NSString *)viewControllerName andLock:(BOOL)lock
{
	[self.taskLabel setText:@"Einführung"];
	
	[self.controller.view removeFromSuperview];
	self.controller = nil; //dealloc old instance;
	
	self.controller = [self.storyboard instantiateViewControllerWithIdentifier:viewControllerName];
	
	[self.view addSubview:self.controller.view];
	[self.controller.view setFrame:CGRectMake(0, 66, self.view.bounds.size.width, self.view.bounds.size.height - 66)];

	if (lock)
	{
		self.lockView = [[UIView alloc] initWithFrame:CGRectMake(0, 66, 1024, 702)];
		[self.view addSubview:self.lockView];
		
		locked = YES;
		
		[self.startButton setHidden:NO];
	}
	else
	{
		[self.startButton setHidden:YES];	
	}
	
	return self.controller;
}
- (void) setTaskMessage:(NSString *)message
{
	[self.taskLabel setText:message];
}

- (void) didFinish
{
	[self.controller.view removeFromSuperview];
	self.controller = nil; //dealloc old instance;
	[self.taskLabel setText:@"Danke für die Teilnahme"];
	//alles fertig
}
- (void) didFinishExperiment
{
	[self.taskLabel setText:@""];
	[self.startButton setHidden:NO];
}

- (void) didFinishTask
{
	
}

- (IBAction)startClicked:(UIButton *)sender
{
	if (locked)
	{
		[self unlock];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ausprobieren"
														message:@"Jetzt hast Du die Möglichkeit, das Menü auszuprobieren"
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
	}
	else
	{
		[[IDPTaskProvider sharedInstance] startNextExperiment];
		[self.startButton setHidden:YES];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
