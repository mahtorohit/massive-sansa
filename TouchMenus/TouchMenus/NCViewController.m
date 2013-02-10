//
//  NCViewController.m
//  NavController
//
//  Created by Steffen Bauereiss on 10.02.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import "NCViewController.h"
#import "NCTableViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface NCViewController ()

@property (retain) UINavigationController *navController;

@end

@implementation NCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
	[self.view setBackgroundColor:[UIColor redColor]];

	UINavigationController *nc = [[UINavigationController alloc] init];
	self.navController = nc;
	
	UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-150, self.view.bounds.size.width, 150)];
	[navView setClipsToBounds:YES];
	[navView addSubview:self.navController.view];
	[self.navController.view setFrame:CGRectMake(0, 0, navView.frame.size.width, navView.frame.size.height)];
	
	UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [navView addGestureRecognizer:rightRecognizer];
	
	[self.view addSubview:navView];
	
	NCTableViewController *tblv = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"NCTBLV"];
	[self.navController pushViewController:tblv animated:YES];

}

- (void)rightSwipeHandle
{
	CATransition* transition = [CATransition animation];
	transition.duration = 0.5;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionMoveIn; //kCATransitionFade, kCATransitionPush, kCATransitionReveal, kCATransitionFade
	transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
	[self.navController.view.layer addAnimation:transition forKey:nil];
	[self.navController popViewControllerAnimated:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
