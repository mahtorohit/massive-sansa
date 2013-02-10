//
//  NCTableViewCell.m
//  NavController
//
//  Created by Steffen Bauereiss on 10.02.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import "NCTableViewCell.h"

@implementation NCTableViewCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    assert([aDecoder isKindOfClass:[NSCoder class]]);
	
    self = [super initWithCoder:aDecoder];
	
    if (self) {
		
        CGFloat k90DegreesClockwiseAngle = (CGFloat) (90 * M_PI / 180.0);
		
        self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, k90DegreesClockwiseAngle);
    }
	
    assert(self);
    return self;
}

@end
