//
//  NCTableViewController.m
//  NavController
//
//  Created by Steffen Bauereiss on 10.02.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import "NCTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DataProvider.h"
#import "MenuItem.h"

@interface NCTableViewController ()


@end

@implementation NCTableViewController

@synthesize menuItem = _menuItem;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self.tableView setBackgroundColor:[UIColor clearColor]];
	
	if (!self.menuItem) {
         self.menuItem = [[DataProvider sharedInstance] getRootMenuItem];
    }
	
	[self.delegate addToBreadCrumb:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.menuItem getChildrenCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    MenuItem* item = [[self.menuItem getChildren] objectAtIndex:[indexPath row]];
    
	[((UILabel *)[cell.contentView viewWithTag:11]) setText: [item getTitle]];
	UIImageView* imageView = (UIImageView *)[cell.contentView viewWithTag:10];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 10;
    [imageView setImage:[item getImg]];
	
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 186;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NCTableViewController *tblv = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"NCTBLV"];
    
    MenuItem* currentItem = [[self.menuItem getChildren] objectAtIndex:[indexPath row]];
    if (![currentItem isLeaf]) {
	
		tblv.menuItem = currentItem;
		tblv.delegate = self.delegate;
	
		CATransition* transition = [CATransition animation];
		transition.duration = 0.2;
		transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
		transition.type = kCATransitionMoveIn; //kCATransitionFade, kCATransitionPush, kCATransitionReveal, kCATransitionFade
		transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
		[self.navigationController pushViewController:tblv animated:NO];
		[self.navigationController.view.layer addAnimation:transition forKey:nil];
    }
	
	
}

@end
