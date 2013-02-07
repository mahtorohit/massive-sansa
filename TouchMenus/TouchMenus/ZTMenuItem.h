//
//  ZTMenuItem.h
//  TouchMenus
//
//  Created by Steffen Bauereiss on 28.01.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataProvider.h"

@interface ZTMenuItem : NSObject

@property (retain) MenuItem *menuItem;
@property (retain) UILabel *label;
@property (retain) NSMutableArray *children;
@property (retain) NSMutableArray *neighbours;
@property (retain) ZTMenuItem *parent;
@property (retain) UIView* view;

- (id) initWithMenuItem:(MenuItem *)item
			  usingView:(UIView *)view
			andPosition:(CGPoint)pos
			  andRadius:(CGFloat)radius
				atDepth:(int)d
			 withParent:(ZTMenuItem *)parent;

- (void)setScale:(CGFloat)scale atPos:(CGPoint)pos;

- (void)transform:(CGAffineTransform)trans;
- (CGAffineTransform)transform;

- (void)setVisible:(BOOL)b;
- (void)setDepth:(int)d;
- (void)select;
- (void)deselect;

@end
