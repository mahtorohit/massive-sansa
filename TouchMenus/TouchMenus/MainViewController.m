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

@end

@implementation MainViewController

@synthesize controller = _controller;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    
	[super viewDidLoad];
	
	[DataProvider sharedInstance]; //just to be sure the images will be cached in the background
	
	[[IDPTaskProvider sharedInstance] setExperimentControllerDelegate:self];
	[[IDPTaskProvider sharedInstance] prepareNextExperiment];
	
}

- (void) createViewControllerOfName:(NSString *)viewControllerName
{
	[self.taskLabel setText:@"Einführung"];
	
	[self.controller.view removeFromSuperview];
	self.controller = nil; //dealloc old instance;
	
	self.controller = [self.storyboard instantiateViewControllerWithIdentifier:viewControllerName];
	
	[self.view addSubview:self.controller.view];
	[self.controller.view setFrame:CGRectMake(0, 66, self.view.bounds.size.width, self.view.bounds.size.height - 66)];

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
