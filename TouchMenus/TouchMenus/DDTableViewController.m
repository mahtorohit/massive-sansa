//
//  DDTableViewController.m
//  DropDown
//
//  Created by Steffen Bauereiss on 10.01.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import "DDTableViewController.h"

@interface DDTableViewController ()

@property (retain) id<selectionDelegate> sdelegate;
@property (retain) NSArray *menuItems;
@property (retain) UIPopoverController *popover;
@property (retain) NSMutableArray *parentviews;
@property (retain) NSIndexPath *selIndexPath;

@end

@implementation DDTableViewController

@synthesize sdelegate = _sdelegate;
@synthesize menuItems = _menuItems;
@synthesize popover = _popover;
@synthesize parentviews = _parentviews;
@synthesize selIndexPath = _selIndexPath;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithMenuItems:(NSArray *)menuItems
  usingSelectionDelegate:(id<selectionDelegate>)sdelegate
				  inView:(UIView *)view
		  withOtherViews:(NSMutableArray *)views
{
	
	self = [super initWithStyle:UITableViewStylePlain];
	
	self.sdelegate = sdelegate;
	self.menuItems = menuItems;
	self.parentviews = views;
	
	self.parentviews = [[NSMutableArray alloc] initWithObjects:self.view, nil];
	[self.parentviews addObjectsFromArray:views];
	
	[self.tableView registerNib:[UINib nibWithNibName:@"CellNib" bundle:nil] forCellReuseIdentifier:@"Cell"];

	self.tableView.scrollEnabled = NO;
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.contentSizeForViewInPopover = CGSizeMake(200, [self tableView:self.tableView numberOfRowsInSection:0]*44);

}

- (void)viewWillDisappear:(BOOL)animated {
	[self.popover dismissPopoverAnimated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
    	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	
	[cell.textLabel setText:[[self.menuItems objectAtIndex:[indexPath row]] getTitle]];
	[cell.imageView setImage:[[self.menuItems objectAtIndex:[indexPath row]] getImg]];
	[cell.textLabel setNumberOfLines:2];
	[cell.textLabel setFont:[UIFont systemFontOfSize:16]];
	
	
	if ([[self.menuItems objectAtIndex:[indexPath row]] getChildrenCount] > 0) {
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	} else {
		[cell setAccessoryType:UITableViewCellAccessoryNone];		
	}
	
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	self.selIndexPath = indexPath;
	 
	[[self.menuItems objectAtIndex:[indexPath row]] selectItem];
	
	if ([[self.menuItems objectAtIndex:[indexPath row]] getChildrenCount] > 0) {
		
		DDTableViewController *tblvc = [[DDTableViewController alloc] initWithMenuItems:[[self.menuItems objectAtIndex:[indexPath row]] getChildren]
																 usingSelectionDelegate:self.sdelegate
																				 inView:self.view
																		 withOtherViews:self.parentviews];
		[self.popover dismissPopoverAnimated:NO];
		
		self.popover = [[UIPopoverController alloc] initWithContentViewController:tblvc];
		self.popover.passthroughViews = self.parentviews;
		self.popover.delegate = self;
		[self.popover presentPopoverFromRect:CGRectMake(tableView.frame.size.width / 1.0 - 12, tableView.frame.origin.y+[indexPath row]*44+20, 1, 1) inView:tableView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
	
	} else {
		
		[self.sdelegate selectMenuItem:[self.menuItems objectAtIndex:[indexPath row]]];
		
	}
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
	[self.tableView deselectRowAtIndexPath:self.selIndexPath animated:NO];
}

@end
