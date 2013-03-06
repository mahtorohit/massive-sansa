//
//  TDViewController.m
//  Grid
//
//  Created by mahmuzic on 20.02.13.
//  Copyright (c) 2013 tum. All rights reserved.
//

#import "TDViewController.h"
#import "DataProvider.h"

#define ITEM_DISTANCE_HORIZONTAL        15
#define ITEM_DISTANCE_VERTICAL          15

@interface TDViewController () {
    TDTreeItemView *currentSelected;
    TDTreeItemView *previousSelected;
}

@end

@implementation TDViewController
@synthesize rootMenuItem;
@synthesize rootItemView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // preparing of the view
    DataProvider *dataProvider = [DataProvider sharedInstance];
    self.rootMenuItem = [dataProvider getRootMenuItem];
    [self addRootItem: self.rootMenuItem];
    
    [self setupGestureRecognizer];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

  	self.view.frame = CGRectMake(0, 66, 1024, 702);

	[self forceViewRefresh];
}

- (void) addRootItem: (MenuItem *) menuItem {
    
    self.rootItemView = [[[NSBundle mainBundle] loadNibNamed:@"TDTreeItemView" owner:self options:nil] objectAtIndex:0];
    self.rootItemView.tag = -1;
    self.rootItemView.menuItem = menuItem;
    self.rootItemView.itemDelegate = self;
    self.rootItemView.titleLabel.text = menuItem.getTitle;
    self.rootItemView.itemImageView.image = menuItem.getImg;
    
    CGPoint itemPoint = [self pointForItem:self.rootItemView];
    
    CGRect frame = self.rootItemView.frame;
    frame.origin.x = itemPoint.x;
    frame.origin.y = itemPoint.y;
    self.rootItemView.frame = frame;
    
    [self.view addSubview: self.rootItemView];
    
}

- (void) drawChildrenForMenuItem: (TDTreeItemView *) treeMenuItem {
    
    NSAssert(treeMenuItem != nil, @"TreeItemView is nil!");
    
    NSArray *children = treeMenuItem.menuItem.getChildren;
    int childrenCount = children.count;
    
    CGRect menuItemFrame = treeMenuItem.frame;
    
    int totalWidthChildren = (menuItemFrame.size.width + ITEM_DISTANCE_HORIZONTAL - 3) * childrenCount;
    int nextPositionX = (menuItemFrame.origin.x + menuItemFrame.size.width / 2) - (totalWidthChildren / 2) ;
    
    // Disallow to draw items outside of the view on left
    if (nextPositionX < 0)
        nextPositionX = ITEM_DISTANCE_HORIZONTAL;

    // on right
    float height = [UIScreen mainScreen].bounds.size.height;
    while ((nextPositionX + totalWidthChildren) > height) {
        nextPositionX -= 3*ITEM_DISTANCE_HORIZONTAL;
    }
    
    int nextPositionY = menuItemFrame.origin.y - ITEM_DISTANCE_VERTICAL - menuItemFrame.size.height;
    
    // Actual Drawing
    for (MenuItem *menuItem in children) {
        
        TDTreeItemView *itemView = [[[NSBundle mainBundle] loadNibNamed:@"TDTreeItemView" owner:self options:nil] objectAtIndex:0];
        itemView.menuItem = menuItem;
        itemView.itemDelegate = self;
        itemView.itemParentView = treeMenuItem;
        itemView.titleLabel.text = menuItem.getTitle;
        itemView.itemImageView.image = menuItem.getImg;
        [itemView.itemParentView.itemChildren addObject:itemView];
        
        CGRect frame = itemView.frame;
        frame.origin.x = nextPositionX;
        frame.origin.y = nextPositionY;
        itemView.frame = frame;

        [self.view addSubview: itemView];
        
        nextPositionX += ITEM_DISTANCE_HORIZONTAL + itemView.frame.size.width;
    }
}

- (CGPoint) pointForItem: (TDTreeItemView *) item {
    
    BOOL isRoot = [item.menuItem getParent] == nil;
    
    if (!isRoot) {
        // do for not root items
    }
   
    // Assuming it is root and horizontal position
    CGRect screenRect = [UIScreen mainScreen].bounds;
    float screenWidth = screenRect.size.height;
    float screenHeight = screenRect.size.width;
    
    float x = (screenWidth - item.frame.size.width) / 2;
    float y = (screenHeight - 2*item.frame.size.height);
    
    return CGPointMake(x, y);
}

- (void)userItemPressed:(TDTreeItemView *)treeItemView {
    
    MenuItem *clickedMenuItem = treeItemView.menuItem;
    BOOL hasChildren = (clickedMenuItem.getChildren.count > 0);
    
    if (hasChildren)
        [self drawChildrenForMenuItem: treeItemView];
    
    [self playClickAudio];
    previousSelected = currentSelected;
    currentSelected = treeItemView;

    [self hideNodesFromDifferentBranchIfNeeded];

}

- (void)forceViewRefresh {
    [self.view setNeedsLayout];
    [self.view setNeedsDisplay];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint touchLocation = [touch locationInView: self.view];
    
    for (UIView *subview in self.view.subviews) {
        if (CGRectContainsPoint(subview.frame, touchLocation)){
            TDTreeItemView *touchedItem = (TDTreeItemView *) subview;
            
            if (!touchedItem.isExpanded) {

                touchedItem.isExpanded = YES;
                [touchedItem setSelected:YES];
                
                BOOL hasChildren = touchedItem.menuItem.getChildren.count > 0;
                if (hasChildren) {
                    [self userItemPressed:touchedItem];
                }
                
                [self playClickAudio];
                
                previousSelected = currentSelected;
                currentSelected = touchedItem;
                
                // Hide nodes if not from the same level
                [self hideNodesFromDifferentBranchIfNeeded];
                
            }
            
        }
    }
}

- (void) hideNodesFromDifferentBranchIfNeeded {
    TDTreeItemView *previousSelectedModelNode = previousSelected;
    TDTreeItemView *newModelNode = currentSelected;
    
    BOOL oldNodeOnSameBranchAsNewNode = [previousSelectedModelNode isOnSameBranchAsNode:newModelNode];
    
    if (!oldNodeOnSameBranchAsNewNode) {
        int newModelNodeLevel = [newModelNode currentLevel];
        TDTreeItemView *ancestorOfPreviousNodeFromSameLevel = [previousSelectedModelNode ancestorFromLevel:newModelNodeLevel];
        
        if (ancestorOfPreviousNodeFromSameLevel.isExpanded) {
            [ancestorOfPreviousNodeFromSameLevel collapseChildren];
        }
        
    }
    
}

- (void) playClickAudio {
    // Clenup needed - Antipattern
}

- (void) setupGestureRecognizer {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collapseTree:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void) collapseTree: (UISwipeGestureRecognizer *)recognizer {
    [rootItemView collapseChildren];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)resetMenu {
    [self collapseTree:nil];
}



@end
