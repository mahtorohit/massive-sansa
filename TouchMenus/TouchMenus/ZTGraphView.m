//
//  ZTGraphView.m
//  ZoomableTree
//
//  Created by Steffen Bauereiss on 07.01.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import "ZTGraphView.h"

@implementation ZTGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void) drawRect:(CGRect)rect {
//	
//	NSLog(@"%f %f  %f %f",rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
//	
//	CGContextRef context = UIGraphicsGetCurrentContext();
//
//	CGContextBeginPath(context); // <---- this
//
//	CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
//	// Draw them with a 2.0 stroke width so they are a bit more visible.
//	CGContextSetLineWidth(context, 2.0);
//	CGContextMoveToPoint(context, rect.origin.x, rect.origin.x); //start at this point
//	CGContextAddLineToPoint(context, rect.size.width, rect.size.height); //draw to this point
//	// and now draw the Path!
//	CGContextStrokePath(context);
//
//	
//}
@end
