//
//  ViewController.m
//  MapView
//
//  Created by Steffen Bauereiss on 07.02.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import "ZTMapViewController.h"
#import "MapOverlay.h"
#import "MapOverlayView.h"

@implementation ZTMapViewController

@synthesize mapView = _mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Centering map
    CLLocationCoordinate2D coord1 = {0,0};
	
	MKCoordinateSpan span = {.latitudeDelta = 180, .longitudeDelta = 180};
	MKCoordinateRegion region = {coord1, span};
	[_mapView setRegion:region animated:YES];
    
    //Adding our overlay to the map
    MapOverlay *mapOverlay = [[MapOverlay alloc] init];
    [self.mapView addOverlay:mapOverlay];    
}


- (void)viewDidUnload
{
    self.mapView = nil;
    [super viewDidUnload];
}

//delegate fired bby mapview requesting a MKOverlayView for each MapOverlay added
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
	
    MapOverlay *mapOverlay = (MapOverlay *)overlay;
    MapOverlayView *mapOverlayView = [[MapOverlayView alloc] initWithOverlay:mapOverlay];
    
    return mapOverlayView;
}

@end
