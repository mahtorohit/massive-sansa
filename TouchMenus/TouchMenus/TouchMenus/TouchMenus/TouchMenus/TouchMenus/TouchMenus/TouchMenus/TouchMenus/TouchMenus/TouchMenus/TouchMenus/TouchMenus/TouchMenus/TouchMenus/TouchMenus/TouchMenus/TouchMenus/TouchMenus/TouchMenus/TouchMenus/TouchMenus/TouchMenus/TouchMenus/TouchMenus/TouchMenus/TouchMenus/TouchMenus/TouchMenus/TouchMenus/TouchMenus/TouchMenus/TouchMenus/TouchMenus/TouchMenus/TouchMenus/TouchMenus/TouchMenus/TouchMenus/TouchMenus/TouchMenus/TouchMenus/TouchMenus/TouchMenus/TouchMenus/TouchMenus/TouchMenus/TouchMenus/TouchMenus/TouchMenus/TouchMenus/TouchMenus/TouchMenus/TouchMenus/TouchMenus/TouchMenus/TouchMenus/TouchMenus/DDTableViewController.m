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

@end

@implementation DDTableViewController

@synthesize sdelegate = _sdelegate;
@synthesize menuItems = _menuItems;
@synthesize popover = _popover;


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithMenuItems:(NSArray *)menuItems
  usingSelectionDelegate:(id<selectionDelegate>)sdelegate
				  inView:(UIView *)view {
	
	self = [super initWithStyle:UITableViewStylePlain];
	
	self.sdelegate = sdelegate;
	self.menuItems = menuItems;
	
	[self.tableView registerNib:[UINib nibWithNibName:@"CellNib" bundle:nil] forCellReuseIdentifier:@"Cell"];

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
	
	if ([[self.menuItems objectAtIndex:[indexPath row]] getChildrenCount] > 0) {
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	} else {
		[cell setAccessoryType:UITableViewCellAccessoryNone];		
	}
	
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	if ([[self.menuItems objectAtIndex:[indexPath row]] getChildrenCount] > 0) {
		DDTableViewController *tblvc = [[DDTableViewController alloc] initWithMenuItems:[[self.menuItems objectAtIndex:[indexPath row]] getChildren]
																 usingSelectionDelegate:self.sdelegate
																				 inView:self.view];
		
		self.popover = [[UIPopoverController alloc] initWithContentViewController:tblvc];
		[self.popover presentPopoverFromRect:CGRectMake(tableView.frame.size.width / 1 - 12, tableView.frame.origin.y+[indexPath row]*44+20, 1, 1) inView:tableView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
	} else {
		
		[self.sdelegate selectMenuItem:[self.menuItems objectAtIndex:[indexPath row]]];
		
	}
	

}

@end
