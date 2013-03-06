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
	
	[[IDPTaskProvider sharedInstance] setExperimentControllerDelegate:self];
	[[IDPTaskProvider sharedInstance] prepareNextExperiment];
	
}

- (void)unlock
{
	[self.lockView removeFromSuperview];
	[self.startButton setHidden:NO];

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
	[[IDPTaskProvider sharedInstance] startNextExperiment];
	[self.startButton setHidden:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
