//
//  MyCollectionViewController.m
//  GridMenu
//
//  Created by Nađa on 1/10/13.
//  Copyright (c) 2013 Nađa. All rights reserved.
//

#import "MyCollectionViewController.h"

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

@synthesize menuItems = _menuItems;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _carImages = [@[@"chevy_small.jpg",
                  @"mini_small.jpg",
                  @"rover_small.jpg",
                  @"smart_small.jpg",
                  @"highlander_small.jpg",
                  @"venza_small.jpg",
                  @"volvo_small.jpg",
                  @"vw_small.jpg",
                  @"ford_small.jpg",
                  @"nissan_small.jpg",
                  @"honda_small.jpg",
                  @"jeep_small.jpg"] mutableCopy];
   
    // if nil, assume this as a root view
    if (!self.menuItems) {
        
        self.menuItems = [[DataProvider sharedInstance] getRootLevelElements];
        self.title = @"Root";
    }
    
   
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
    MyCollectionViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"MyCell"
                                    forIndexPath:indexPath];
    UIImage *image;
    
    int row = [indexPath row];
    image = [UIImage imageNamed:_carImages[row]];
    
    MenuItem *currentMenuItem = [self.menuItems objectAtIndex:row];
    
    [myCell.label setText:[currentMenuItem getTitle]];
    [myCell.imageView setImage:[currentMenuItem getImg]];

    
    return myCell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
    int row = [indexPath row];

    NSArray *children = [[self.menuItems objectAtIndex:row] getChildren];
    
    if (children) {
        MyCollectionViewController *collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier: @"MyCollectionViewController"];
        collectionViewController.menuItems = children;
        collectionViewController.title = [[self.menuItems objectAtIndex:row] getTitle];
        [self.navigationController pushViewController:collectionViewController animated:YES];
    }
    else {
        LeafViewController *leafViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeafViewController"];
        leafViewController.title = [[self.menuItems objectAtIndex:row] getTitle];
        [self.navigationController pushViewController:leafViewController animated:YES];
    }
}

@end
