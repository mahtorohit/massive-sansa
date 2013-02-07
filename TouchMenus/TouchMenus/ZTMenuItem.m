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

- (id) initWithMenuItem:(MenuItem *)item
			  usingView:(UIView *)view

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

	if (self.menuItem == nil) {
		//root
		DataProvider *p = [DataProvider sharedInstance];
		self.menuItem = [p getRootMenuItem];
	}
	
	self.label = [[UILabel alloc] initWithFrame:CGRectMake(pos.x-250, pos.y-44, 500, 88)];
	
	[self.label setFont:[UIFont systemFontOfSize:MAX(40-10*depth,5)]];//UGLY
	
	[self.label setText:[self.menuItem getTitle]];
	[self.label setBackgroundColor:[UIColor clearColor]];
	[self.label setTextAlignment:NSTextAlignmentCenter];
	[self.label setUserInteractionEnabled:YES];
	
	[view addSubview:self.label];
	
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
														   usingView:view
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

- (void)transform:(CGAffineTransform)trans {
	self.label.transform = trans;
	
	for (ZTMenuItem *child in self.children) {
		[child transform:trans];
	}
}

- (CGAffineTransform)transform {
	return self.label.transform;
}


- (void) setScale:(CGFloat)scale atPos:(CGPoint)pos{
//	CGAffineTransform trans = self.transform;
//	trans = CGAffineTransformScale(trans, scale, scale);
//	[self transform:trans];
//
//	[self.label setFont:[UIFont systemFontOfSize:MIN(20*scale,20)]];
//	[self.label setTextColor:[UIColor colorWithWhite:0.0 alpha:1-scale]];
//	
//	for (ZTMenuItem *child in self.children) {
//		[child setScale:scale-1 atPos:pos];
//	}
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
