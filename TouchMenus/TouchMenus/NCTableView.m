//
//  NCTableView.m
//  NavController
//
//  Created by Steffen Bauereiss on 10.02.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import "NCTableView.h"

@implementation NCTableView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    assert([aDecoder isKindOfClass:[NSCoder class]]);
	
    self = [super initWithCoder:aDecoder];
	
    if (self) {
		
        const CGFloat k90DegreesCounterClockwiseAngle = (CGFloat) -(90 * M_PI / 180.0);
		
        CGRect frame = self.frame;
        self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, k90DegreesCounterClockwiseAngle);
        self.frame = frame;
		
    }
	
    assert(self);
    return self;
}

@end
