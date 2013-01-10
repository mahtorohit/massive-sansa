//
//  ZTViewController.m
//  ZoomableTree
//
//  Created by Steffen Bauereiss on 02.01.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import "ZTViewController.h"
#import "DataProvider.h"
#import "ZTUIGraphMenuItem.h"

@interface ZTViewController () {
	DataProvider *data;
	
	MenuItem *selectedItem;
	
	ZTUIGraphMenuItem *menuRoot;
	
	CGFloat scale;
	CGFloat oscale;

}

@end

@implementation ZTViewController

@synthesize uiView = _uiView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	data = [DataProvider sharedInstance];
	oscale = 1;
	scale = 0;
	
	graphView = [[ZTGraphView alloc] initWithFrame:CGRectMake(0, 0, 4096, 4096)];
	[_uiView setBackgroundColor:[UIColor blackColor]];
	[_uiView addSubview:graphView];
	
	[graphView setBounds:CGRectMake(0, 0, 4096, 4096)];
	[graphView setNeedsDisplay];
	[graphView setCenter:CGPointMake(2048, 2048)];
	[graphView setBackgroundColor:[UIColor whiteColor]];
	
	selectedItem = nil;
		
	menuRoot = [[ZTUIGraphMenuItem alloc] initWithMenuItem:nil usingView:graphView andCenter:CGPointMake(2048, 2048) andItem:0 ofItems:0 atDepth:0];

	CGAffineTransform trans = graphView.transform;
	trans = CGAffineTransformTranslate(trans, -2048+500, -2048+400);
	graphView.transform = trans;

	UIGestureRecognizer *r;
	r = [[UIPanGestureRecognizer alloc] initWithTarget:self action: @selector(handlePanGesture:)];
	[graphView addGestureRecognizer: r];
	r.delegate = self;
	
	r = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapGesture:)];
	[graphView addGestureRecognizer: r];
	r.delegate = self;

	r = [[UIPinchGestureRecognizer alloc] initWithTarget: self action: @selector(handlePinchGesture:)];
	[graphView addGestureRecognizer: r];
	r.delegate = self;
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//- (void) zoomView {

	//	[menuRoot setScale:scale + oscale];

//	scale + oscale < 1 ? [menuRoot setScale:1] : [menuRoot setScale:scale +oscale];

//}

- (CGPoint) getPositionOfItem:(int)num of:(int)total {
	return CGPointMake(sin(num * (2.0*M_PI/total)), -cos(num * (2.0*M_PI/total)));
}

-(void) handleTapGesture:(UITapGestureRecognizer*)r {
	CGPoint posInDisplay = [r locationInView: graphView];
	UIView *tappedView = [graphView hitTest:posInDisplay withEvent:nil];
	if ([tappedView isKindOfClass: [UILabel class]]) {
		
		UILabel *tappedLabel = ((UILabel*) tappedView);
		CGPoint pos = tappedLabel.frame.origin;
		
		NSLog(@"Tapped %@", tappedLabel.text);
		
		CGAffineTransform trans = graphView.transform;
		trans = CGAffineTransformMakeTranslation(-pos.x+400, -pos.y+350);
		
		[UIView animateWithDuration:0.4
						 animations:^{
							 graphView.transform = trans;
						 }];
		oscale++;
		[menuRoot setScale:oscale atPos:pos];
		
	} else {
//		NSLog(@"Tap anywhere");
		//TODO navigate Back
	}
}

-(void) handlePanGesture:(UIPanGestureRecognizer*)r {
	
	CGPoint pos = [r locationInView: graphView.superview];
	
	CGAffineTransform trans = graphView.transform;
	trans = CGAffineTransformTranslate(trans, pos.x - previousPanPosition.x, pos.y - previousPanPosition.y);
	graphView.transform = trans;

	previousPanPosition = pos;
	
	if (([r state] == UIGestureRecognizerStateEnded)) {
		//...
	}
}

-(void) handlePinchGesture: (UIPinchGestureRecognizer*) r {
	scale = r.scale - 1;
	
	CGPoint pos = [r locationInView:graphView];

//	if (scale > 1) scale = 1;
	
//	scale + oscale < 1 ? [menuRoot setScale:1 atPos:pos] :
	[menuRoot setScale:scale + oscale  atPos:pos];

//	[self zoomView];

}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)r {
	if ([r isKindOfClass: [UIPanGestureRecognizer class]]) {
		previousPanPosition = [r locationInView: graphView.superview];
	} else if ([r isKindOfClass: [UIPinchGestureRecognizer class]]) {
		oscale = scale + oscale;
	}
	return true;
}


@end
