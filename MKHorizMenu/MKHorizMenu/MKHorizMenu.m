//
//  MKHorizMenu.m
//  MKHorizMenuDemo
//  Created by Mugunth on 09/05/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above
//  Read my blog post at http://mk.sg/8h on how to use this code

//  As a side note on using this code, you might consider giving some credit to me by
//	1) linking my website from your app's website 
//	2) or crediting me inside the app's credits page 
//	3) or a tweet mentioning @mugunthkumar
//	4) A paypal donation to mugunth.kumar@gmail.com
//
//  A note on redistribution
//	While I'm ok with modifications to this source code, 
//	if you are re-publishing after editing, please retain the above copyright notices

#import "MKHorizMenu.h"
#import "MenuItemWrapper.h"
#define kButtonBaseTag 10000
#define kLeftOffset 10

@implementation MKHorizMenu

@synthesize titles = _titles;
@synthesize selectedImage = _selectedImage;

@synthesize itemSelectedDelegate;
@synthesize dataSource;
@synthesize itemCount = _itemCount;

@synthesize rootMenuItem;
@synthesize menuItems;
@synthesize selectedItem;

-(void) awakeFromNib
{
    self.bounces = YES;
    self.scrollEnabled = YES;
    self.alwaysBounceHorizontal = YES;
    self.alwaysBounceVertical = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    self.rootMenuItem = [self.dataSource rootMenuItemForMenu:self];
    self.selectedItem = self.rootMenuItem;
    NSArray *rootMenuChildren = [self.rootMenuItem getChildren];
    
    [self reloadDataForItems: rootMenuChildren];
    [self createGestureRecognizer];
}

- (void) createGestureRecognizer {

    UISwipeGestureRecognizer *oneFingerSwipeDown = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeDown:)] autorelease];
    [oneFingerSwipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self addGestureRecognizer:oneFingerSwipeDown];
}

- (void)oneFingerSwipeDown:(UISwipeGestureRecognizer *)recognizer
{
    MenuItem *parentItem = [self.selectedItem getParent];
    if (parentItem != nil) {
        [self hideItemsAnimated:YES andDirection: MKHorizMenuHideDirectionDown];
        self.selectedItem = parentItem;
    }
}


- (void) reloadDataForItems:(NSArray*) items {
    
    self.menuItems = [NSMutableArray new];
    
    UIFont *buttonFont = [UIFont boldSystemFontOfSize:15];
    int buttonPadding = 25;
    
    //int tag = kButtonBaseTag;
    int xPos = kLeftOffset;
    
    for(int i = 0 ; i < items.count; i ++) {
        
        
        MenuItem *item = (MenuItem *) [items objectAtIndex: i];
        NSString *title = [item getTitle];
        
        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [customButton setTitle:title forState:UIControlStateNormal];
        customButton.titleLabel.font = buttonFont;
        
        [customButton setBackgroundImage:self.selectedImage forState:UIControlStateSelected];
        
        [customButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        int buttonWidth = [title sizeWithFont:customButton.titleLabel.font
                            constrainedToSize:CGSizeMake(150, 28)
                                lineBreakMode:UILineBreakModeClip].width;
        
        customButton.frame = CGRectMake(xPos, self.frame.origin.y, buttonWidth + buttonPadding, 28);
        
        [self addSubview:customButton];
        
        // Wrap the the model and the button
        MenuItemWrapper *itemWrapper = [MenuItemWrapper new];
        itemWrapper.button = customButton;
        itemWrapper.menuItem = item;
        [self.menuItems addObject:itemWrapper];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5f];
        {
            CGRect rect = customButton.frame;
            rect.origin.y = 7;
            customButton.frame = rect;
        }
        [UIView commitAnimations];
        
        xPos += buttonWidth;
        xPos += buttonPadding;
        
    }
    
    self.contentSize = CGSizeMake(xPos, 41);
    [self layoutSubviews];
}


-(void) setSelectedIndex:(int) index animated:(BOOL) animated
{
    UIButton *thisButton = (UIButton*) [self viewWithTag:index + kButtonBaseTag];
    thisButton.selected = YES;
    [self setContentOffset:CGPointMake(thisButton.frame.origin.x - kLeftOffset, 0) animated:animated];
    [self.itemSelectedDelegate horizMenu:self itemSelectedAtIndex:index];
}

- (void)hideItemsAnimated:(BOOL)animated andDirection: (MKHorizMenuHideDirection) direction{
    NSArray *subviews = [self subviews];
    
    CGRect containerRect = self.frame;
    
    for (UIView *view in subviews) {
    
        
        if (animated) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5f];
        }
        
        
        CGRect frame = view.frame;
        
        if (direction == MKHorizMenuHideDirectionUp) {
            frame.origin.y -= containerRect.size.height;
        } else {
            frame.origin.y += containerRect.size.height;
            
        }
        view.frame = frame;
        
        if (animated) {
            [UIView commitAnimations];
            [UIView setAnimationDelegate:view];
            [UIView setAnimationDidStopSelector:@selector(removeSubviews)];
        }
    }
}

- (void) removeSubviews {
    for (UIView *view in self.subviews) {
        [view setHidden:YES];
        [view removeFromSuperview];
    }
}

-(void) buttonTapped:(id) sender
{
    UIButton *button = (UIButton*) sender;
    
    for (MenuItemWrapper *itemWrapper in menuItems) {
        UIButton *wrappedButton = itemWrapper.button;
        
        if (button == wrappedButton) {
            NSArray *children = [itemWrapper.menuItem getChildren];
            if (children.count != 0) {
                [self hideItemsAnimated:YES andDirection:MKHorizMenuHideDirectionUp];
                [self reloadDataForItems:children];
            } else {
                NSLog(@"selected item: %@", [wrappedButton.titleLabel text]);
            }
            
            self.selectedItem = itemWrapper.menuItem;
        }
        
    }
}

- (void)dealloc
{
    [_selectedImage release];
    _selectedImage = nil;
    [_titles release];
    _titles = nil;
    
    [super dealloc];
}

@end
