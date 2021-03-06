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

- (void)resetMenu
{
	for (TreeItem* item in treeItems) {
		[item setUnfolded:NO];
	}
	[self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSMutableArray* array = [[NSMutableArray alloc] init];

    [self createTreeInArray:array withMenuItem:[[DataProvider sharedInstance] getRootMenuItem] andParentTreeItem:nil];
    treeItems = array;
    
//    NSLog(@"%i", [treeItems count]);
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated
{
	[self.tableView setFrame:CGRectMake(0, 66, 400, 702)];
}

-(void) createTreeInArray:(NSMutableArray *)array withMenuItem:(MenuItem *)menuItem andParentTreeItem:(TreeItem *)ptreeItem {

		
    TreeItem* item = [[TreeItem alloc] init];
    [item setMenuItem:menuItem];
	[item setPtreeItem:ptreeItem];
    [item setUnfolded:NO];

//	NSLog(@"%@", [item.menuItem getTitle]);

    [array addObject:item];
    
    for (MenuItem* child in [menuItem getChildren]) {
        [self createTreeInArray:array withMenuItem:child andParentTreeItem:item];
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
    
    UILabel* label = (UILabel*)[cell viewWithTag:12];

    UIImageView* icon = (UIImageView*)[cell viewWithTag:10];
    
    
    if (![displayedItem.menuItem isLeaf]) {
        //[image2 setImage:[UIImage imageNamed:@"leopard-folder-big.png"]];
        if (![displayedItem isUnfolded]) {
            [icon setImage:[UIImage imageNamed:@"plusa"]];
        } else {
            [icon setImage:[UIImage imageNamed:@"minusa"]];
		}
    } else {
        [icon setImage:[displayedItem.menuItem getImg]];
        //[icon setImage:nil];
    }
    
    [label setText:[NSString stringWithFormat:@"%@",[displayedItem.menuItem getTitle]]];
    
//    NSLog(@"%@ %i", [displayedItem.menuItem getTitle], [displayedItem.menuItem getLevel]);
    [self setLevelBounds:[displayedItem.menuItem getLevel] forLabel:label AndIcon:icon ];
       
    return cell;
}

- (void)setLevelBounds:(NSInteger)level forLabel: (UILabel*) label AndIcon: (UIImageView*) icon {
	
    CGRect rect;
    // Label
    rect = label.frame;
    //rect.origin.x = 45 + 35 * (level - 1);
    label.frame = rect;
    [label setFrame:CGRectMake(45 + 35 * (level - 1), rect.origin.y, rect.size.width, rect.size.height)];
    // Icon
    rect = icon.frame;
    //rect.origin.x = 5 + 35 * (level - 1);
    icon.frame = rect;
    [icon setFrame:CGRectMake(5 + 35 * (level - 1), rect.origin.y, rect.size.width, rect.size.height)];

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UILabel* label = (UILabel*)[cell viewWithTag:12];
    
    UIImageView* icon = (UIImageView*)[cell viewWithTag:10];
    
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
    
    [self setLevelBounds:[displayedItem.menuItem getLevel] forLabel:label AndIcon:icon];
    
//    [cell setBackgroundColor:[UIColor grayColor]];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    


    int currentIndex = 0;
    int level = 1;
    int itemIndex = [indexPath row];
	
    TreeItem* selectedItem = [[TreeItem alloc]init];
    
    for (TreeItem* item in treeItems) {
		int itemLevel = [item.menuItem getLevel];

        if (itemLevel == 0) continue;
        if (itemLevel <= level) {

//			NSLog(@"%@", [item.menuItem getTitle]);
    
                if (currentIndex == itemIndex) {
                    [item setUnfolded: ![item isUnfolded]];
                    selectedItem = item;
                    break;
                }
                else
                    currentIndex++;
        
			if (itemLevel < level) {
				level = [item.menuItem getLevel];
			}

			if ([item isUnfolded])
			{
                level++;
			}
		}
    }
    
	[selectedItem.menuItem selectItem];
	
    for (TreeItem* item in treeItems) {
        if ([item ptreeItem] == [selectedItem ptreeItem]) {
            if  (![[item.menuItem getTitle]isEqualToString:[selectedItem.menuItem getTitle]]) {
				[item setUnfolded:NO];
				[self collapseTreeFrom:item];
			}
		}
    }

	//    for (TreeItem* item in treeItems) {
	//        if ([item.menuItem getParent] == [selectedItem.menuItem getParent]) {
	//            if  (![[item.menuItem getTitle]isEqualToString:[selectedItem.menuItem getTitle]]) {
	//				[item setUnfolded:NO];
	//			}
	//		}
	//    }

    
    [self.tableView reloadData];
}

- (void) collapseTreeFrom:(TreeItem *)parentitem
{
	for (TreeItem* item in treeItems) {
        if ([item ptreeItem] == parentitem) {
			[item setUnfolded:NO];
			[self collapseTreeFrom:item];
		}
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
