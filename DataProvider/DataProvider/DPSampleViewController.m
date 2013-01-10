//
//  DPSampleViewController.m
//  DataProvider
//
//  Created by Steffen Bauereiss on 24.12.12.
//  Copyright (c) 2012 Steffen Bauereiss. All rights reserved.
//

#import "DPSampleViewController.h"
#import "DataProvider.h"
@interface DPSampleViewController ()

@end

@implementation DPSampleViewController

DataProvider *data;
NSArray* content;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	data = [DataProvider sharedInstance];
	content = [data getRootLevelElements];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [content count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
	MenuItem *item = (MenuItem *)[content objectAtIndex:[indexPath row]];
	
    [cell.textLabel setText:[item getTitle]];
    if (![item isLeaf]) {
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	} else {
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	}
	
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	MenuItem *item = (MenuItem *)[content objectAtIndex:[indexPath row]];
	
	if (![item isLeaf]) {
		content = [item getChildren];
		[self.tableView reloadData];
	}
 }

@end
