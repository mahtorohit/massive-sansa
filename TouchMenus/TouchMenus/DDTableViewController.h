//
//  DDTableViewController.h
//  DropDown
//
//  Created by Steffen Bauereiss on 10.01.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"

@protocol selectionDelegate <NSObject>

- (void) selectMenuItem:(MenuItem *)item;

@end;

@interface DDTableViewController : UITableViewController <UIPopoverControllerDelegate>

- (id) initWithMenuItems:(NSArray *)menuItems
  usingSelectionDelegate:(id<selectionDelegate>)delegate
				  inView:(UIView *)view
		  withOtherViews:(NSMutableArray *)views;
@end
