//
//  DDViewController.m
//  DropDown
//
//  Created by Steffen Bauereiss on 10.01.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import "DDViewController.h"
#import "IDPTaskProvider.h"

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
}

- (void)viewWillDisappear:(BOOL)animated
{
	[self.popover dismissPopoverAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openMenu:(UIButton *)sender {
	
	[[IDPTaskProvider sharedInstance] otherActionPerformed:@"OPENED" withDescription:@"Dropdown opened"];
	
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
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.popover dismissPopoverAnimated:NO];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{

}

@end
