//
//  RootViewController.h
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKHorizMenu.h"
#import "MenuItem.h"
@interface RootViewController : UIViewController <MKHorizMenuDataSource, MKHorizMenuDelegate> {

    MKHorizMenu *_horizMenu;
    NSMutableArray *_items;
    
    UILabel *_selectionItemLabel;

    MenuItem *rootMenuItem;
    
}

@property (nonatomic, retain) MenuItem* rootMenuItem;
@property (nonatomic, retain) IBOutlet MKHorizMenu *horizMenu;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, assign) IBOutlet UILabel *selectionItemLabel;

@end
