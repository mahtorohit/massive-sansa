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
   
    // if nil, assume this as a root view
    if (!self.menuItems) {
        
        self.menuItems = [[DataProvider sharedInstance] getRootLevelElements];
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
    return [self.menuItems count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"MyCell"
                                    forIndexPath:indexPath];
    int row = [indexPath row];
    
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
        collectionViewController.delegate = self.delegate;
        [self.navigationController pushViewController:collectionViewController animated:YES];
    }
    else {
        ///clickclick
    }
}

- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([[[self.menuItems objectAtIndex:0] getParent] getParent]!= nil)
        [self.delegate breadCrumbPopOnce];
}

@end
