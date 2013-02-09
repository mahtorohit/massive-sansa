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
#import "ZTMenuItem.h"

@interface ZTMapViewController() {
}

@property ZTMenuItem *menuRoot;
@property NSMutableArray *allItems;

@end

@implementation ZTMapViewController

@synthesize menuRoot = _menuRoot;
@synthesize mapView = _mapView;
@synthesize allItems = _allItems;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
	[NSURLCache setSharedURLCache:sharedCache];
	
    //Centering map
    CLLocationCoordinate2D coord1 = {0,0};
	
	MKCoordinateSpan span = {.latitudeDelta = 50, .longitudeDelta = 50};
	MKCoordinateRegion region = {coord1, span};
	[_mapView setRegion:region animated:YES];
    
    //Adding our overlay to the map
    MapOverlay *mapOverlay = [[MapOverlay alloc] init];
    [self.mapView addOverlay:mapOverlay];
	
	CLLocationCoordinate2D location;
	location.latitude = (double) 0;
	location.longitude = (double) 0;
	
	self.menuRoot = [[ZTMenuItem alloc] initWithMenuItem:nil usingMapView:self.mapView andPosition:CGPointMake(0,0) andRadius:1000 atDepth:0 withParent:nil];
	
	self.allItems = [[NSMutableArray alloc] init];
	[self.menuRoot addAllItemsToArray:self.allItems];
	
	UIGestureRecognizer *r;
	r = [[UIPinchGestureRecognizer alloc] initWithTarget: self action: @selector(handlePinchGesture:)];
	[_mapView addGestureRecognizer: r];
	r.delegate = self;
	
}

int fontsize;

-(void) handlePinchGesture: (UIPinchGestureRecognizer*) r {
	
	if (_mapView.region.span.latitudeDelta > 50)
	{
		if (fontsize != 40)
		{
			fontsize = 40;
			for (ZTMenuItem *item in self.allItems)
			{
				[item setZoom:40];
			}
		}
	}
	else if (_mapView.region.span.latitudeDelta < 10)
	{
		if (fontsize != 60)
		{
			fontsize = 60;
			for (ZTMenuItem *item in self.allItems)
			{
				[item setZoom:60];
			}		}
	}
	else if (_mapView.region.span.latitudeDelta < 50)
	{
		if (fontsize != 50)
		{
			fontsize = 50;
			for (ZTMenuItem *item in self.allItems)
			{
				[item setZoom:50];
			}
		}
	}
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	return YES;
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	
	return (ZTMenuItem*) annotation;

	//getAnnotationView:mapView.region.span.longitudeDelta];

}

@end
