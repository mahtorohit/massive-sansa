//
//  MainViewController.m
//  TouchMenus
//
//  Created by Steffen Bauereiss on 19.02.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property UIViewController *controller;
@property UILabel *description;

@end

@implementation MainViewController

@synthesize controller = _controller;
@synthesize description = _description;

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
	
	[[IDPTaskProvider sharedInstance] registerExperimentStatusDelegate:self];
	[[IDPTaskProvider sharedInstance] setExperimentControllerDelegate:self];
	
	self.description = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 66)];
	[self.description setTextAlignment:NSTextAlignmentCenter];
	[self.view addSubview:self.description];
	
	[[IDPTaskProvider sharedInstance] startNextExperiment];
	
}

- (void) createViewControllerOfName:(NSString *)viewControllerName
{
	self.controller = nil; //dealloc old instance;
	
	self.controller = [self.storyboard instantiateViewControllerWithIdentifier:viewControllerName];
	
	[self.view addSubview:self.controller.view];
	[self.controller.view setFrame:CGRectMake(0, 66, self.view.bounds.size.width, self.view.bounds.size.height - 66)];

}
- (void) setTaskMessage:(NSString *)message
{
	[self.description setText:message];
}
- (void) didFinishExperiment
{
	[self.description setText:@"Fertig!"];

}
- (void) didFinishTask
{
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
