//
//  CSVLogger.h
//  TouchMenus
//
//  Created by Steffen Bauereiss on 26.02.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface CSVLogger : NSObject <MFMailComposeViewControllerDelegate>

+ (CSVLogger *) sharedInstance;

- (void) logToFileAt:(double)timestamp message:(NSString *)msg itemTitle:(NSString *)title;

- (void) logToFileAt:(double)timestamp swipeFrom:(CGPoint)from to:(CGPoint)to direction:(UISwipeGestureRecognizerDirection)dir;

- (void)closeFileHandle:(UIViewController *)ctr;

@end
