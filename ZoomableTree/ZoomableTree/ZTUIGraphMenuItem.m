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
	CGFloat realCoordX;
	CGFloat realCoordY;
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
		circleOffset = CGPointMake(radialOffset.x*(400-d*100), radialOffset.y*(400-d*100));
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
	return CGPointMake(sin(num * (2.0 * M_PI/total)), -cos(num * (2.0 * M_PI/total)));
}

- (void) calcPositionWithScaling {
	realCoordX = circleCenter.x + circleOffset.x*scaling-75*scaling;
	realCoordY = circleCenter.y + circleOffset.y*scaling-22*scaling;
}

- (void) setScale:(CGFloat)scale atPos:(CGPoint)pos {
	
	scaling = scale;
	
	[self calcPositionWithScaling];
	
	if (realCoordX < pos.x - 200
		|| realCoordX > pos.x + 1200
		|| realCoordY < pos.y - 200
		|| realCoordY > pos.y + 900) {
		[self setVisible:NO];
	} else {
		[self setVisible:YES];
	}
	
	if (scaling > 0 && visible) {
		
		[self.label setFrame:CGRectMake(realCoordX, realCoordY, 150*scaling, 44*scaling)];
		[self.label setFont:[UIFont systemFontOfSize:20*scaling]];
		[self.label setTextColor:[UIColor colorWithWhite:0.0 alpha:scaling]];
		
	}
	else {
		[self setVisible:NO];
		
	}
	
	for (ZTUIGraphMenuItem *child in self.children) {
		[child setCircleCenter:circleCenter withOffset:circleOffset andScale:scaling];
		[child setScale:scaling-1  atPos:pos];
	}
	
//	if (scaling > 0 && visible) {
//		
//		//Zoom Level ok for this depth - refresh the position of the circleCenter for children
//		
//		[self.label setFrame:CGRectMake(circleCenter.x+circleOffset.x*scaling-75*scaling, circleCenter.y+circleOffset.y*scaling-22*scaling, 150*scaling, 44*scaling)];
//		[self.view drawRect:CGRectMake(circleCenter.x+circleOffset.x*scaling-75*scaling, circleCenter.y+circleOffset.y*scaling-22*scaling, circleCenter.x, circleCenter.y)];
//		[self.label setFont:[UIFont systemFontOfSize:20*scaling]];
//		[self.label setTextColor:[UIColor colorWithWhite:0.0 alpha:scaling]];
//		
//		for (ZTUIGraphMenuItem *child in self.children) {
//			[child setCircleCenter:circleCenter withOffset:circleOffset andScale:scaling];
//			[child setScale:scaling-1  atPos:pos];
//		}
//
//	} else if (scaling > 0 && !visible) {
//		
//		[self.label setFrame:CGRectMake(circleCenter.x+circleOffset.x*scaling-75*scaling, circleCenter.y+circleOffset.y*scaling-22*scaling, 150*scaling, 44*scaling)];
//		[self.view drawRect:CGRectMake(circleCenter.x+circleOffset.x*scaling-75*scaling, circleCenter.y+circleOffset.y*scaling-22*scaling, circleCenter.x, circleCenter.y)];
//		[self.label setFont:[UIFont systemFontOfSize:20*scaling]];
//		[self.label setTextColor:[UIColor colorWithWhite:0.0 alpha:scaling]];
//	
////		[self setVisible:YES];
//				
//	} else if (scaling <= 0) {
//		
//		//Zoom Level too low for this depth - set invisible
//		
//		for (ZTUIGraphMenuItem *child in self.children) {
////			[child setVisible:NO];
//			[child setCircleCenter:circleCenter withOffset:circleOffset andScale:scaling];
//			[child setScale:scaling-1  atPos:pos];
//		}
//		
////		[self setVisible:NO];
//		
//	}
	
	
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
//	NSLog(@"Selected %@", self.label.text);
//	[self setScale:scaling+0.5 atPos:circleCenter];
//	[self setScale:scaling+0.5 atPos:circleCenter];
//	selected = YES;
//	for (ZTUIGraphMenuItem *child in self.children) {
//		[child deselect];
//	}
//	for (ZTUIGraphMenuItem *neigh in self.neighbours) {
//		[neigh deselect];
//	}
}

- (void) deselect {
	selected = NO;
}


- (void) selectItem:(UITapGestureRecognizer*)r {
	[self select];
}

@end
