//
//  iCarouselExampleViewController.h
//  iCarouselExample
//
//  Created by Nick Lockwood on 03/04/2011.
//  Copyright 2011 Charcoal Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "IDPTaskProvider.h"


@interface iCarouselExampleViewController : UIViewController <iCarouselDataSource, iCarouselDelegate, MenuCandidate>

@property (nonatomic, strong) IBOutlet iCarousel *carousel1;
@property (nonatomic, strong) IBOutlet iCarousel *carousel3;

@end
