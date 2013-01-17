//
//  ULViewController.m
//  UnfoldingListMenu
//
//  Created by Nađa on 1/14/13.
//  Copyright (c) 2013 Nađa. All rights reserved.
//

#import "ULViewController.h"
#import "DataProvider.h"
#import "TreeItem.h"

@interface ULViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ULViewController

@synthesize treeItems;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSMutableArray* array = [[NSMutableArray alloc] init];

    [self createTreeInArray:array withMenuItem:[[DataProvider sharedInstance] getRootMenuItem]];
    treeItems = array;
    
    NSLog(@"%i", [treeItems count]);
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) createTreeInArray:(NSMutableArray *)array withMenuItem:(MenuItem *)menuItem {

    TreeItem* item = [[TreeItem alloc] init];
    [item setMenuItem:menuItem];
    [item setUnfolded:NO];

    [array addObject:item];
    
    for (MenuItem* child in [menuItem getChildren]) {
        [self createTreeInArray:array withMenuItem:child];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    int level = 1;
    
    for (TreeItem* item in treeItems) {
        
		//We dont' want the "rootnode"
		if ([item.menuItem getLevel] == 0) continue;
		
		//level fits -> same level or moving to children
        if ([item.menuItem getLevel] == level) {
            count++;
            if ([item isUnfolded])
                level++;
        }
		//level fits -> moving up in hierarchy
        else if ([item.menuItem getLevel] < level) {
			count++;

            level = [item.menuItem getLevel];
            if ([item isUnfolded])
                level++;
        }
        
    }
    
//    NSLog(@"%i", count);
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor grayColor]];
    
    TreeItem* displayedItem = [[TreeItem alloc] init];
    
    int currentIndex = 0;
    int level = 1;
    
    for (TreeItem* item in treeItems) {
        int itemLevel = [item.menuItem getLevel];
        
		//we don't want the root node
        if (itemLevel == 0) continue;
		
		//level fits, moving on same leel or to children
        if (itemLevel <= level) {
            if (currentIndex == [indexPath row]) {
                displayedItem = item;
                break;
            }
            else
                currentIndex++;
            
			if (itemLevel < level) {
				level = itemLevel;
			}
			
			if ([item isUnfolded]) {
                level++;
			}
				
        }        

    }
    
    UILabel* label = (UILabel*)[cell viewWithTag:11];
    UIImageView* image = (UIImageView*)[cell viewWithTag:10];
    
    [self setLevelBounds:[displayedItem.menuItem getLevel] forLabel:label AndImageView:image];
    
    if (![displayedItem.menuItem isLeaf]) {
        if (![displayedItem isUnfolded]) {
            [image setImage:[UIImage imageNamed:@"disclosure"]];
        } else {
            [image setImage:[UIImage imageNamed:@"disclosure90"]];
		}
    } else {
        [image setImage:nil];
    }
       
    [label setText:[NSString stringWithFormat:@"%@",[displayedItem.menuItem getTitle]]];
    
    return cell;
}

- (void)setLevelBounds:(NSInteger)level forLabel: (UILabel*) label AndImageView: (UIImageView*) image {
	
    CGRect rect;
    
    rect = image.bounds;
    rect.origin.x = 20 * level;
    image.bounds = rect;
    
    rect = label.bounds;
    rect.origin.x = -10 + 20 * level;
    label.bounds = rect;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    [cell setBackgroundColor: [UIColor grayColor]];
//    
//}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    


    int currentIndex = 0;
    int level = 1;
    
    for (TreeItem* item in treeItems) {
        if ([item.menuItem getLevel] == 0) continue;
        if ([item.menuItem getLevel] <= level) {
            
			if (currentIndex == [indexPath row]) {
                
				[item setUnfolded: ![item isUnfolded]];
                break;
            }
            else
                currentIndex++;
            
			if ([item.menuItem getLevel] < level) {
				level = [item.menuItem getLevel];
			}

			
			if ([item isUnfolded])
                level++;
        }
    }

    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
