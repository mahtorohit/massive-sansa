//
//  ZTMenuItem.m
//  TouchMenus
//
//  Created by Steffen Bauereiss on 28.01.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import "ZTMenuItem.h"

@implementation ZTMenuItem {
	
	CGPoint position;

	int depth;

	BOOL selected;
	BOOL visible;

	CGFloat realCoordX;
	CGFloat realCoordY;
}

@synthesize menuItem = _menuItem;
@synthesize label = _label;
@synthesize children = _children;
@synthesize parent = _parent;
@synthesize view = _view;

@synthesize title = _title;
@synthesize coordinate = _coordinate;

- (id) initWithMenuItem:(MenuItem *)item
		   usingMapView:(MKMapView *)view
			andPosition:(CGPoint)pos
			  andRadius:(CGFloat)radius
				atDepth:(int)d
			 withParent:(ZTMenuItem *)parent {

	self = [super init];
	
	self.parent = parent;
	self.menuItem = item;
	self.view = view;
	
	self.children = [[NSMutableArray alloc] init];
	
	depth = d;
	position = pos;
	
	_title = [self.menuItem getTitle];
	_coordinate = CLLocationCoordinate2DMake(pos.x/30, pos.y/30);
	[view addAnnotation:self];
	
	if (self.menuItem == nil) {
		//root
		DataProvider *p = [DataProvider sharedInstance];
		self.menuItem = [p getRootMenuItem];
	}
	
	self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 500, 88)];
	
	[self setZoom:50];
	
	[self.label setText:[self.menuItem getTitle]];
	[self.label setBackgroundColor:[UIColor clearColor]];
	[self.label setTextAlignment:NSTextAlignmentLeft];
	[self.label setUserInteractionEnabled:YES];
	
	[self addSubview:self.label];
	
	selected = NO;
	
	NSArray *children = [self.menuItem getChildren];
	int childrenCount = [children count];
	
	for (int i = 0; i < childrenCount; i++) {
		MenuItem *child = [children objectAtIndex:i];
		
		CGPoint childPositionEinheitskreis = [self positionOfItem:i of:childrenCount];
		
		CGPoint childPosition = CGPointMake(pos.x + childPositionEinheitskreis.x * radius, pos.y + childPositionEinheitskreis.y * radius);
		
		CGFloat childRadius = MIN(radius / 2.0,
								  radius * (2.0 * M_PI / (4.0 * childrenCount)));
							//TODO: COSINUS
		
		ZTMenuItem *childItem = [[ZTMenuItem alloc] initWithMenuItem:child
														   usingMapView:view
														 andPosition:childPosition
														   andRadius:childRadius
															 atDepth:depth+1
														  withParent:self];
		[self.children addObject:childItem];
	}
	
	if (item == nil) {
		[self select];
	}

	return self;
}

- (CGPoint) positionOfItem:(int)num of:(int)total {
	return CGPointMake(sin(num * (2.0 * M_PI/total)), -cos(num * (2.0 * M_PI/total)));
}

- (void)setZoom:(double)startfont
{
	[self.label setFont:[UIFont systemFontOfSize:MAX(startfont-depth*10,5)]];
}

- (void)addAllItemsToArray:(NSMutableArray *)array
{
	[array addObject:self];
	for (ZTMenuItem *child in self.children)
	{
		[child addAllItemsToArray:array];
	}
}

- (void) setDepth:(int)d {
	depth = d;
}

- (void) setHidden:(BOOL)b {
	[self.label setHidden:b];
}

- (void) setVisible:(BOOL)b {
	visible = b;
	[self setHidden:!b];
}

- (void) select {
	selected = YES;
}

- (void) deselect {
	selected = NO;
}

@end
