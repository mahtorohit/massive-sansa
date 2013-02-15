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
{
	int pos;
}

@property (retain) UINavigationController *navController;
@property (retain) NSMutableArray *stack;

@end

@implementation NCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
	
	self.stack = [[NSMutableArray alloc] init];
	
	NCTableViewController *tblv = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"NCTBLV"];
	tblv.delegate = self;
	
	UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:tblv];
	self.navController = nc;
	
	UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-150, self.view.bounds.size.width, 150)];
	[navView setClipsToBounds:YES];
	[navView addSubview:self.navController.view];
	
	[navView setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
	
	[self.navController.view setFrame:CGRectMake(0, 0, navView.frame.size.width, navView.frame.size.height)];
	
	[self.navController.navigationBar setHidden:YES];
	
	UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [navView addGestureRecognizer:rightRecognizer];
	
	[self.view addSubview:navView];
	
	[self.backButton removeFromSuperview];
	[self.view addSubview:self.backButton];
	
	self.backButton.layer.zPosition = 10;
	[self.backButton setFrame:CGRectMake(-5,  self.view.bounds.size.height-190, 80, 80)];
	
	pos = 25;
	
}
- (IBAction)backButtonClick:(UIButton *)sender
{
	[self rightSwipeHandle];
}

- (void)rightSwipeHandle
{
	
	if ([self.navController.viewControllers count] == 1)
	{
		CGFloat offset = 100.0;
		CGFloat endposY = self.navController.view.frame.origin.y;
		[UIView animateWithDuration:.2 animations:^{
			CGRect frame = self.navController.view.frame;
			frame.origin.y = endposY + offset;
			self.navController.view.frame = frame;
		} completion:^(BOOL finished){
			[UIView animateWithDuration:.1 animations:^{
				CGRect frame = self.navController.view.frame;
				frame.origin.y = endposY;
				self.navController.view.frame = frame;
			}];
		}];
	}
	else
	{
		[self controllerPop];
	}
}

- (void)addToBreadCrumb:(id)tblv
{
	NCTableViewController *tblview = (NCTableViewController *)tblv;
	[self breadcrumPush:tblview];
}

- (void)breadcrumPush:(NCTableViewController *)tblv
{
	NSString *title = [tblv.menuItem getTitle];
//	UIFont *myFont = [UIFont systemFontOfSize:17.0];
	CGFloat width = 200; //[title sizeWithFont:myFont].width + 20;
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(pos,  self.view.bounds.size.height-186, width, 36)];
	
	[button addTarget:self action:@selector(breadcrumbClick:) forControlEvents:UIControlEventTouchUpInside];
	pos += width-25;
	
	[button setTitle:title forState:UIControlStateNormal];
	[[button titleLabel] setFont:[UIFont systemFontOfSize:15]];
	[button setBackgroundImage:[UIImage imageNamed:@"breadcrumb.png"] forState:UIControlStateNormal];
	
	[self.view addSubview:button];
	[self.stack addObject:button];
	
	[self.backButton removeFromSuperview];
	[self.view addSubview:self.backButton];
}

- (void)breadcrumbPop
{
	UIButton *button = [self.stack lastObject];
	[button removeFromSuperview];
	
	pos -= button.frame.size.width-25;
	[self.stack removeLastObject];
}
- (void)controllerPop
{
	CATransition* transition = [CATransition animation];
	transition.duration = 0.2;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionMoveIn; //kCATransitionFade, kCATransitionPush, kCATransitionReveal, kCATransitionFade
	transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
	[self.navController.view.layer addAnimation:transition forKey:nil];
	[self.navController popViewControllerAnimated:NO];
	//breadcrumbpop
	[self breadcrumbPop];
}
- (void)breadcrumbClick:(UIButton *)button
{
	while (![[((NCTableViewController *)self.navController.topViewController).menuItem getTitle] isEqualToString:[button titleLabel].text])
	{
		[self controllerPop];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end