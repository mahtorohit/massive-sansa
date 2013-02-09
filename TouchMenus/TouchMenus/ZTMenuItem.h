//
//  ZTMenuItem.h
//  TouchMenus
//
//  Created by Steffen Bauereiss on 28.01.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "DataProvider.h"

@interface ZTMenuItem : MKAnnotationView <MKAnnotation>

@property (retain) MenuItem *menuItem;
@property (retain) UILabel *label;
@property (retain) NSMutableArray *children;
@property (retain) NSMutableArray *neighbours;
@property (retain) ZTMenuItem *parent;
@property (retain) UIView* view;

- (id) initWithMenuItem:(MenuItem *)item
			  usingMapView:(MKMapView *)view
			andPosition:(CGPoint)pos
			  andRadius:(CGFloat)radius
				atDepth:(int)d
			 withParent:(ZTMenuItem *)parent;

- (void)setZoom:(double)zoom;

- (void)addAllItemsToArray:(NSMutableArray *)array;

- (void)setVisible:(BOOL)b;
- (void)setDepth:(int)d;
- (void)select;
- (void)deselect;

@end
