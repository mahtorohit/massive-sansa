//
//  MenuItemWrapper.h
//  MKHorizMenuDemo
//
//  Created by mahmuzic on 10.02.13.
//  Copyright (c) 2013 Steinlogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuItem.h"

@interface MenuItemWrapper : NSObject

@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) MenuItem *menuItem;

@end
