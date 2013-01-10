//
//  ZTUIGraphMenuItem.m
//  ZoomableTree
//
//  Created by Steffen Bauereiss on 02.01.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import "ZTUIGraphMenuItem.h"

@implementation ZTUIGraphMenuItem {
	
	CGPoint circleCenter;
	CGPoint circleOffset;
	
	int depth;

	BOOL selected;
	BOOL visible;
	
	CGFloat scaling;
}

@synthesize menuItem = _menuItem;
@synthesize label = _label;
@synthesize children = _children;
@synthesize parent = _parent;
@synthesize view = _view;


- (ZTUIGraphMenuItem *) initWithMenuItem:(MenuItem *)item usingView:(UIView *)view andCenter:(CGPoint)center andItem:(int)num ofItems:(int)total atDepth:(int)d{
		
	self = [super init];
	
	self.menuItem = item;
	
	self.view = view;
	
	depth = d;
	
	self.children = [[NSMutableArray alloc] init];
	
	circleCenter = center;
	
	if (total > 0) {
		CGPoint radialOffset = [self positionOfItem:num of:total];
		circleOffset = CGPointMake(radialOffset.x*(300-d*50), radialOffset.y*(300-d*50));
	} else {
		circleOffset = CGPointMake(0, 0);
	}
	
	self.label = [[UILabel alloc] initWithFrame:CGRectMake(circleCenter.x-75, circleCenter.y-22, 150, 44)];
	[self.label setText:@"Menu"];
	[self.label setBackgroundColor:[UIColor clearColor]];
	[self.label setTextAlignment:NSTextAlignmentCenter];
	[self.label setUserInteractionEnabled:YES];

	UIGestureRecognizer *r;

	r = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(selectItem:)];
	[self.label addGestureRecognizer: r];
	r.delegate = self;
	
	[view addSubview:self.label];

	selected = NO;
		
	int c = 0;
	
	if (item == nil) {
		//root		
		visible = YES;
		selected = YES;
		
		DataProvider *p = [DataProvider sharedInstance];
		
		for (MenuItem *child in [p getRootLevelElements]) {
			ZTUIGraphMenuItem *childitem = [[ZTUIGraphMenuItem alloc] initWithMenuItem:child
																			 usingView:view
																			 andCenter:CGPointMake(center.x + circleOffset.x, center.y + circleOffset.y)
																			   andItem:c++
																			   ofItems:[[p getRootLevelElements] count]
																			   atDepth:d+1];
			[self.children addObject:childitem];
			[childitem setCircleCenter:circleCenter withOffset:circleOffset andScale:0];
			[childitem setParent:self];
			[childitem setVisible:NO];
		}
	} else {

		[self.label setText:[item getTitle]];
		
		for (MenuItem *child in [item getChildren]) {
			ZTUIGraphMenuItem *childitem = [[ZTUIGraphMenuItem alloc] initWithMenuItem:child
																			 usingView:view
																			 andCenter:CGPointMake(center.x + circleOffset.x, center.y + circleOffset.y)
																			   andItem:c++
																			   ofItems:[item getChildrenCount]
																			   atDepth:d+1];
			[self.children addObject:childitem];
			[childitem setCircleCenter:circleCenter withOffset:circleOffset andScale:0];
			[childitem setParent:self];
			[childitem setVisible:NO];
		}
	}
		
	for (ZTUIGraphMenuItem *child in self.children) {
		[child setNeighbours:self.children];
	}
	
	if (item == nil) {
		[self select];
	}
	[self setScale:1 atPos:CGPointMake(2048, 2048)];

	return self;
}

- (CGPoint) positionOfItem:(int)num of:(int)total {
	return CGPointMake(sin(num * (2.0*M_PI/total)), -cos(num * (2.0*M_PI/total)));
}

- (CGFloat) distanceBetween:(CGPoint)p1 and:(CGPoint)p2 {
	CGFloat x = p1.x - p2.x;
	CGFloat y = p1.y - p2.y;
	return sqrtf(x*x + y*y);
}

- (void) setScale:(CGFloat)scale atPos:(CGPoint)pos {
	
	BOOL distanceOK = [self distanceBetween:circleCenter and:pos] < 50;
	scaling = scale;
	
//	if (scaling > 1 && visible) {
//		
//		//Zoom Level too high for this depth - gray out and continue zooming for children
//		
//		[self.label setTextColor:[UIColor colorWithWhite:0.0 alpha:2-scaling]];
//		
//		for (ZTUIGraphMenuItem *child in self.children) {
//			[child setScale:scaling-1 atPos:pos];
//		}
//	
//	} else
		if (scaling > 0 && visible) {
		
		//Zoom Level ok for this depth - refresh the position of the circleCenter for children
		
		[self.label setFrame:CGRectMake(circleCenter.x+circleOffset.x*scaling-75*scaling, circleCenter.y+circleOffset.y*scaling-22*scaling, 150*scaling, 44*scaling)];
		[self.view drawRect:CGRectMake(circleCenter.x+circleOffset.x*scaling-75*scaling, circleCenter.y+circleOffset.y*scaling-22*scaling, circleCenter.x, circleCenter.y)];
		[self.label setFont:[UIFont systemFontOfSize:20*scaling]];
		[self.label setTextColor:[UIColor colorWithWhite:0.0 alpha:scaling]];
		
		for (ZTUIGraphMenuItem *child in self.children) {
			[child setCircleCenter:circleCenter withOffset:circleOffset andScale:scaling];
			[child setScale:scaling-1  atPos:pos];
		}

	} else if (scaling > 0 && !visible) {
		
		[self.label setFrame:CGRectMake(circleCenter.x+circleOffset.x*scaling-75*scaling, circleCenter.y+circleOffset.y*scaling-22*scaling, 150*scaling, 44*scaling)];
		[self.view drawRect:CGRectMake(circleCenter.x+circleOffset.x*scaling-75*scaling, circleCenter.y+circleOffset.y*scaling-22*scaling, circleCenter.x, circleCenter.y)];
		[self.label setFont:[UIFont systemFontOfSize:20*scaling]];
		[self.label setTextColor:[UIColor colorWithWhite:0.0 alpha:scaling]];
	
//		if (distanceOK) {
			[self setVisible:YES];
//		}
				
	} else if (scaling <= 0) {
		
		//Zoom Level too low for this depth - set invisible
		
		for (ZTUIGraphMenuItem *child in self.children) {
//			[child setVisible:NO];
			[child setCircleCenter:circleCenter withOffset:circleOffset andScale:scaling];
			[child setScale:scaling-1  atPos:pos];
		}
		
		[self setVisible:NO];
		
	}
	
	
}

- (void) setCircleCenter:(CGPoint)pos withOffset:(CGPoint)off1 andScale:(CGFloat)scale{
	circleCenter = CGPointMake(pos.x + off1.x*scale, pos.y + off1.y*scale);
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
	NSLog(@"Selected %@", self.label.text);
	[self setScale:scaling+0.5 atPos:circleCenter];
	[self setScale:scaling+0.5 atPos:circleCenter];
	selected = YES;
	for (ZTUIGraphMenuItem *child in self.children) {
		[child deselect];
	}
	for (ZTUIGraphMenuItem *neigh in self.neighbours) {
		[neigh deselect];
	}
}

- (void) deselect {
	selected = NO;
}


- (void) selectItem:(UITapGestureRecognizer*)r {
	[self select];
}

@end
