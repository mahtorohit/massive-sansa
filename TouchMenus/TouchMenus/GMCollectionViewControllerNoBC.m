//
//  GMCollectionViewController.m
//  TouchMenus
//
//  Created by Nađa on 2/15/13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import "GMCollectionViewControllerNoBC.h"
#import <QuartzCore/QuartzCore.h>
#import "MyCollectionViewController.h"
#import "IDPTaskProvider.h"

@interface GMCollectionViewControllerNoBC ()

{
	int pos;
}

@property (retain) UINavigationController *navController;
@property (retain) NSMutableArray *stack;

@end

@implementation GMCollectionViewControllerNoBC


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
	self.view.frame = CGRectMake(0, 66, 1024, 702);
	
	self.stack = [[NSMutableArray alloc] init];
	
    MyCollectionViewController *gridView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"MyCollectionViewController"];
	
	UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:gridView];
	self.navController = nc;
	
	UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 650)];
	[navView setClipsToBounds:YES];
	[navView addSubview:self.navController.view];
	
	///[navView setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
	
	[self.navController.view setFrame:CGRectMake(0, 0, navView.frame.size.width, navView.frame.size.height)];
	
//	[self.navController.navigationBar setHidden:YES];
	
	UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [navView addGestureRecognizer:rightRecognizer];
	
	[self.view addSubview:navView];
	
	pos = 25;
	
}

- (void)rightSwipeHandle
{
	[[IDPTaskProvider sharedInstance] swipeRecognizedInDirection:UISwipeGestureRecognizerDirectionRight];

	if ([self.navController.viewControllers count] == 1)
	{
		//bounce
		[UIView animateWithDuration:.2 animations:^{
			CGRect frame = self.navController.view.frame;
			frame.origin.x = 100.0;
			self.navController.view.frame = frame;
		} completion:^(BOOL finished){
			[UIView animateWithDuration:.1 animations:^{
				CGRect frame = self.navController.view.frame;
				frame.origin.x = 0.0;
				self.navController.view.frame = frame;
			}];
		}];
	}
	else
	{
		[self controllerPop];
	}
}

- (void)controllerPop
{
	CATransition* transition = [CATransition animation];
	transition.duration = 0.4;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionMoveIn; //kCATransitionFade, kCATransitionPush, kCATransitionReveal, kCATransitionFade
	transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navController.view.layer addAnimation:transition forKey:nil];
	[self.navController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end