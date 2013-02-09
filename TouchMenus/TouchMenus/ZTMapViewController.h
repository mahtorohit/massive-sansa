//
//  ViewController.h
//  MapView
//
//  Created by Steffen Bauereiss on 07.02.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ZTMapViewController : UIViewController <MKMapViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign) IBOutlet MKMapView * mapView;

@end
