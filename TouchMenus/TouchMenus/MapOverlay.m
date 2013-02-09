//
//  MapOverlay.m
//  MapView
//
//  Created by Steffen Bauereiss on 07.02.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import "MapOverlay.h"

@implementation MapOverlay

-(CLLocationCoordinate2D)coordinate {
    //Image center point
    return CLLocationCoordinate2DMake(0.0, 0.0);
}

- (MKMapRect)boundingMapRect
{
    //Latitue and longitude for each corner point
    MKMapPoint upperLeft = MKMapPointForCoordinate(CLLocationCoordinate2DMake(90, -180));
    MKMapPoint upperRight = MKMapPointForCoordinate(CLLocationCoordinate2DMake(90, 180));
    MKMapPoint bottomLeft = MKMapPointForCoordinate(CLLocationCoordinate2DMake(-90, -180));
    
    //Building a map rect that represents the image projection on the map
    MKMapRect bounds = MKMapRectMake(upperLeft.x, upperLeft.y, fabs(upperLeft.x - upperRight.x), fabs(upperLeft.y - bottomLeft.y));
	
    return bounds;
}

@end
