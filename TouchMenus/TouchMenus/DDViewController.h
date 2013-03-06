//
//  DDViewController.h
//  DropDown
//
//  Created by Steffen Bauereiss on 10.01.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"
#import "DDTableViewController.h"
#import "IDPTaskProvider.h"


@interface DDViewController : UIViewController <selectionDelegate, UIPopoverControllerDelegate, MenuCandidate>

@end
