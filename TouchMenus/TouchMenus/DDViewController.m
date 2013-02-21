//
//  DDViewController.m
//  DropDown
//
//  Created by Steffen Bauereiss on 10.01.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import "DDViewController.h"

@interface DDViewController ()

@property UIPopoverController *popover;

@end

@implementation DDViewController

@synthesize popover;

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor grayColor]];
	// Do any additional setup after loading the view, typically from a nib.
	
//	NSArray *items = [[DataProvider sharedInstance] getRootLevelElements];
//	int pos = 10;
//	int cnt = 10;
//	for (MenuItem *item in items) {
//		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(pos, 200, 150, 44)];
//		pos += 160;
//		[button setTag:cnt++];
//		[button setBackgroundColor:[UIColor lightGrayColor]];
//		[button setTitle:[item getTitle] forState:UIControlStateNormal];
//		[button addTarget:self action:@selector(openSubMenu:) forControlEvents:UIControlEventTouchUpInside];
//		[self.view addSubview:button];
//	}
//}
//
//- (void)openSubMenu:(UIButton *)sender
//{
//	NSLog(@"afasdgf");
//	NSArray *items = [[[[DataProvider sharedInstance] getRootLevelElements] objectAtIndex:sender.tag-10] getChildren];
//	
//	DDTableViewController *tblvc = [[DDTableViewController alloc] initWithMenuItems:items
//															 usingSelectionDelegate:self
//																			 inView:self.view
//																	 withOtherViews:[[NSMutableArray alloc] initWithObjects:self.view, nil]];
//	
//	self.popover = [[UIPopoverController alloc] initWithContentViewController:tblvc];
//	self.popover.delegate = self;
//    [self.popover presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height / 1, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openMenu:(UIButton *)sender {
	
	NSArray *items = [[DataProvider sharedInstance] getRootLevelElements];
		
	DDTableViewController *tblvc = [[DDTableViewController alloc] initWithMenuItems:items
															 usingSelectionDelegate:self
																			 inView:self.view
																	 withOtherViews:[[NSMutableArray alloc] initWithObjects:self.view, nil]];
	[self.popover dismissPopoverAnimated:NO];
	
	self.popover = [[UIPopoverController alloc] initWithContentViewController:tblvc];
	self.popover.delegate = self;
    [self.popover presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height / 1, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (void) selectMenuItem:(MenuItem *)item {
	[self.popover dismissPopoverAnimated:NO];
	NSLog(@"Selected %@", [item getTitle]);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.popover dismissPopoverAnimated:NO];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
//	NSLog(@"dismissed");
}

@end
