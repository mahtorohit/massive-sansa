//
//  TDTreeItemView.m
//  Grid
//
//  Created by mahmuzic on 20.02.13.
//  Copyright (c) 2013 tum. All rights reserved.
//

#import "TDTreeItemView.h"

#define COLOR_SELECTED          [UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f]
#define COLOR_UNSELECTED        [UIColor whiteColor]
#define COLOR_SHADOW            [UIColor grayColor]
#define COLOR_LINE              [UIColor orangeColor]

@implementation TDTreeItemView
@synthesize itemPoistion;
@synthesize itemTitle;
@synthesize itemImageView;
@synthesize itemChildren;
@synthesize itemParentView;
@synthesize menuItem;
@synthesize itemDelegate;
@synthesize isExpanded;
@synthesize titleLabel;
@synthesize selected = selected_;   

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isExpanded = NO;
        [self setupAppearance];
        self.itemChildren = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self setupAppearance];
        self.isExpanded = NO;
        self.itemChildren = [[NSMutableArray alloc] init];
        [self setupGestureRecognizer];
    }
    return self;
}

- (void) setupAppearance {
    self.layer.cornerRadius = 5.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [[UIColor grayColor] CGColor];
    
    self.layer.masksToBounds = NO;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5.0;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    
}

- (void) collapseChildren {
    self.isExpanded = NO;
    [self setSelected:NO];
    for (TDTreeItemView *childView in itemChildren) {
        [childView collapseChildren];
        [childView setHidden: YES];
        [childView removeFromSuperview];
    }
}

- (void)setSelected:(BOOL)_selected {
    self->selected_ = _selected;
    if (selected_) {
        self.backgroundColor = COLOR_SELECTED;
    } else {
        self.backgroundColor = COLOR_UNSELECTED;
    }
}


- (void) setupGestureRecognizer {
    // Touch
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

- (void)handleTouch:(UISwipeGestureRecognizer *)recognizer {
    if (!self.isExpanded) {
        self.isExpanded = YES;
        [self.itemDelegate userItemPressed: self];
        [self setSelected:YES];
    } else {
        [self collapseChildren];
        [self.itemDelegate forceViewRefresh];
    }
}

- (int) currentLevel {
    if (self.itemParentView == nil)
        return 0;
    else
        return 1 + [self.itemParentView currentLevel];
}

- (BOOL)isOnSameBranchAsNode:(TDTreeItemView *)modelNode {
    // modelnode is new node
    
    if (modelNode == self)
        return YES;
    
    if (modelNode.itemParentView == nil)
        return NO;
    else
        return NO || [self isOnSameBranchAsNode: modelNode.itemParentView];
}

- (TDTreeItemView *)ancestorFromLevel:(int)level {
    if (level == 0)
        return nil;
    else if ([self currentLevel] == level)
        return self;
    else
        return [self.itemParentView ancestorFromLevel:level];
}


@end
