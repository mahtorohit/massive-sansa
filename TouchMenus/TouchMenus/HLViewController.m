//
//  HLViewController.m
//  TouchMenus
//
//  Created by Nađa on 2/10/13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import "HLViewController.h"
#import "DataProvider.h"
#import "HLCollectionViewCell.h"

@interface HLViewController ()

@end

@implementation HLViewController

@synthesize menuItems = _menuItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // if nil, assume this as a root view
    if (!self.menuItems) {
        
        self.menuItems = [[[DataProvider sharedInstance]getRootMenuItem]getChildren];
        //self.title = @"GridMenu";
    }
    
//    UICollectionViewFlowLayout *myLayout =
//    [[UICollectionViewFlowLayout alloc]init];
//    
//    myLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //[self.collectionView setCollectionViewLayout:myLayout animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return [self.menuItems count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HLCollectionViewCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:@"HorizontalListCell"
                                  forIndexPath:indexPath];
    
    int row = [indexPath row];
    
    MenuItem *currentMenuItem = [self.menuItems objectAtIndex:row];
    
    [cell.label setText:[currentMenuItem getTitle]];
    [cell.imageView setImage:[currentMenuItem getImg]];
    
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    int row = [indexPath row];
    
    NSArray *children = [[self.menuItems objectAtIndex:row] getChildren];
    
//    
//     *collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier: @"HorizontalList"];
//    collectionViewController.menuItems = children;
//    collectionViewController.title = [[self.menuItems objectAtIndex:row] getTitle];
//    [self.navigationController pushViewController:collectionViewController animated:YES];
    
}



@end
