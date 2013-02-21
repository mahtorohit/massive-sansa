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

@synthesize menuItem = _menuItem;


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // if nil, assume this as a root view
    if (!self.menuItem) {
        
        self.menuItem = [[DataProvider sharedInstance] getRootMenuItem];
        self.title = @"GridMenu";
    }
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    
    [self.delegate addToBreadCrumb:self];
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
    return [self.menuItem getChildrenCount];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"MyCell"
                                    forIndexPath:indexPath];
    int row = [indexPath row];
    
    MenuItem *currentMenuItem = [[self.menuItem getChildren] objectAtIndex:row];
    
    [myCell.label setText:[currentMenuItem getTitle]];
    [myCell.imageView setImage:[currentMenuItem getImg]];

    
    return myCell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
    int row = [indexPath row];

	if (![[[self.menuItem getChildren] objectAtIndex:row] isLeaf]) {
		[[[self.menuItem getChildren] objectAtIndex:row] selectItem];
		
        MyCollectionViewController *collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier: @"MyCollectionViewController"];
        collectionViewController.menuItem = [[self.menuItem getChildren] objectAtIndex:row];
        collectionViewController.title = [[[self.menuItem getChildren] objectAtIndex:row] getTitle];
        collectionViewController.delegate = self.delegate;
        [self.navigationController pushViewController:collectionViewController animated:YES];
    }
    else {
		[[[self.menuItem getChildren] objectAtIndex:row] selectItem];
    }
}

- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.menuItem getParent] != nil)
        [self.delegate breadCrumbPopOnce];
}

@end
