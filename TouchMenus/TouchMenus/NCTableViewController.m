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

@synthesize menuItems = _menuItems;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (!self.menuItems) {
         self.menuItems = [[[DataProvider sharedInstance] getRootMenuItem]getChildren];
    }
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
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    MenuItem* item = [self.menuItems objectAtIndex:[indexPath row]];
    
	[((UILabel *)[cell.contentView viewWithTag:11]) setText: [item getTitle]];
	[((UIImageView *)[cell.contentView viewWithTag:10]) setImage:[item getImg]];
	
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 170;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NCTableViewController *tblv = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"NCTBLV"];
    
    MenuItem* currentItem = [self.menuItems objectAtIndex:[indexPath row]];
//    NSLog(@"%@",[currentItem getTitle]);
    if (![currentItem isLeaf]) {
    tblv.menuItems = [currentItem getChildren];
	
	CATransition* transition = [CATransition animation];
	transition.duration = 0.5;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionMoveIn; //kCATransitionFade, kCATransitionPush, kCATransitionReveal, kCATransitionFade
	transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
	[self.navigationController pushViewController:tblv animated:NO];
	[self.navigationController.view.layer addAnimation:transition forKey:nil];
//	[self.navigationController pushViewController:tblv animated:NO];
    }
	
	
}

@end
