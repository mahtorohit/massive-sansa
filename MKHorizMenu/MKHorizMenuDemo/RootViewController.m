//
//  RootViewController.m
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import "RootViewController.h"
#import "MenuItem.h"
#import "DataProvider.h"

@implementation RootViewController

@synthesize horizMenu = _horizMenu;
@synthesize items = _items;
@synthesize selectionItemLabel = _selectionItemLabel;
@synthesize rootMenuItem = _rootMenuItem;

- (void)viewDidLoad
{
    
    //DataProvider *dataProvider = [DataProvider sharedInstance];
    //self.rootMenuItem = [dataProvider getRootMenuItem];
    
    
    //self.items = [NSArray arrayWithObjects:@"Headlines", @"UK", @"International", @"Politics", @"Weather", @"Travel", @"Radio", @"Hollywood", @"Sports", @"Others", nil];
    //[self.horizMenu reloadData];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.horizMenu setSelectedIndex:5 animated:YES];
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark HorizMenu Data Source
- (UIImage*) selectedItemImageForMenu:(MKHorizMenu*) tabMenu
{
    return [[UIImage imageNamed:@"ButtonSelected"] stretchableImageWithLeftCapWidth:16 topCapHeight:0];
}

- (UIColor*) backgroundColorForMenu:(MKHorizMenu *)tabView
{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"MenuBar"]];
}

- (int) numberOfItemsForMenu: (MKHorizMenu *)tabView
{
    return [self.items count];
}

- (NSString*) horizMenu:(MKHorizMenu *)horizMenu titleForItemAtIndex:(NSUInteger)index
{
    return [self.items objectAtIndex:index];
}

- (MenuItem *)rootMenuItemForMenu:(MKHorizMenu *)tabView {
    return [[DataProvider sharedInstance] getRootMenuItem];
}


#pragma mark -
#pragma mark HorizMenu Delegate
-(void) horizMenu:(MKHorizMenu *)horizMenu itemSelectedAtIndex:(NSUInteger)index
{        
    self.selectionItemLabel.text = [self.items objectAtIndex:index];
}

- (void)horizMenu:(MKHorizMenu *)horizMenu itemSelected:(MenuItem *)item {
    NSLog(@"Selected item: %@", [item getTitle]);
}
@end
