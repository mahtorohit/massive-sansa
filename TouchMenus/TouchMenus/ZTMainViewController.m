//
//  ZTMainViewController.m
//  TouchMenus
//
//  Created by Steffen Bauereiss on 28.01.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import "ZTMainViewController.h"

@interface ZTMainViewController () {
	CGPoint lastPosition;
}

@property (strong) ZTMenuItem *menuRoot;

@end

@implementation ZTMainViewController

@synthesize debugLabel = _debugLabel;
@synthesize menuRoot = _menuRoot;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.debugLabel setText:@"Touches:\n"];
	
	self.menuRoot = [[ZTMenuItem alloc] initWithMenuItem:nil usingView:self.view andPosition:CGPointMake(512, 368) andRadius:1500 atDepth:0 withParent:nil];
	
	UIGestureRecognizer *r;
	r = [[UIPanGestureRecognizer alloc] initWithTarget:self action: @selector(handlePanGesture:)];
	[self.view addGestureRecognizer: r];
	r.delegate = self;
	
	r = [[UIPinchGestureRecognizer alloc] initWithTarget: self action: @selector(handlePinchGesture:)];
	[self.view addGestureRecognizer: r];
	r.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) handlePanGesture:(UIPanGestureRecognizer*)r {

	NSString *s = @"Touches:\n";
	
	NSInteger numTouches = [r numberOfTouches];
	for (NSUInteger i = 0; i < numTouches; i++) {
		CGPoint pos = [r locationOfTouch:i inView:self.view];
		s = [s stringByAppendingString:[NSString stringWithFormat:@"%.2f %.2f\n", pos.x, pos.y]];
	}

	CGPoint pos = [r locationInView:self.view];

	CGAffineTransform trans = self.menuRoot.transform;
	
	trans = CGAffineTransformTranslate(trans, pos.x - lastPosition.x, pos.y - lastPosition.y);
	[self.menuRoot transform:trans];
	
	lastPosition = pos;
	
	[self.debugLabel setText:s];
}

-(void) handlePinchGesture: (UIPinchGestureRecognizer*) r {
	[self.menuRoot setScale:r.scale atPos:[r locationInView:self.view]];
	
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)r {
	if ([r isKindOfClass: [UIPanGestureRecognizer class]]) {
		lastPosition = [r locationInView: self.view.superview];
	} else if ([r isKindOfClass: [UIPinchGestureRecognizer class]]) {
		
	}
	return true;
}

@end
