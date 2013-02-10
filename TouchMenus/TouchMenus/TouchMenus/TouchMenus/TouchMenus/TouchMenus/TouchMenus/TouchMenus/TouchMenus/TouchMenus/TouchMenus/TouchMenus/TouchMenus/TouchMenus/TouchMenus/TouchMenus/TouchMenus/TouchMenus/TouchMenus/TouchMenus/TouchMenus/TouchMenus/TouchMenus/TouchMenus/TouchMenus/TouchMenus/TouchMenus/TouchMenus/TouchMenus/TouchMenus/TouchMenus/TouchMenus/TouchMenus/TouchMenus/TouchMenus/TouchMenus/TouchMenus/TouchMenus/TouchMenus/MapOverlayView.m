//
//  MapOverlayView.m
//  MapView
//
//  Created by Steffen Bauereiss on 07.02.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import "MapOverlayView.h"
#import "MapOverlay.h"

@implementation MapOverlayView

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)ctx
{
    
//UIImage *image = [[UIImage imageNamed:@"indigo_eiffel_blog.png"] retain];
//CGImageRef imageReference = image.CGImage;
    
    //Loading and setting the image
    MKMapRect theMapRect = [self.overlay boundingMapRect];
    CGRect theRect = [self rectForMapRect:theMapRect];
	
    
    // We need to flip and reposition the image here
    CGContextScaleCTM(ctx, 1.0, -1.0);
    CGContextTranslateCTM(ctx, 0.0, -theRect.size.height);
    
    //drawing the image to the context
//CGContextDrawImage(ctx, theRect, imageReference);
    
	CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor whiteColor] CGColor]));
	CGContextFillRect(ctx, theRect);
	
}


@end
