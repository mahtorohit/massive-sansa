//
//  ZTUIGraphMenuItem.h
//  ZoomableTree
//
//  Created by Steffen Bauereiss on 02.01.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuItem.h"
#import "DataProvider.h"

@interface ZTUIGraphMenuItem : NSObject<UIGestureRecognizerDelegate> {

}

@property (retain) MenuItem *menuItem;
@property (retain) UILabel *label;
@property (retain) NSMutableArray *children;
@property (retain) NSMutableArray *neighbours;
@property (retain) ZTUIGraphMenuItem *parent;
@property (retain) UIView* view;

- (ZTUIGraphMenuItem *) initWithMenuItem:(MenuItem *)item usingView:(UIView *)view andCenter:(CGPoint)center andItem:(int)num ofItems:(int)total atDepth:(int)d;

- (void) setScale:(CGFloat)scale atPos:(CGPoint)pos;

- (void) setVisible:(BOOL)b;
- (void) setDepth:(int)d;
- (void) select;
- (void) deselect;

@end
