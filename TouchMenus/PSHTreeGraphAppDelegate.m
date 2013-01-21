//
//  PSHTreeGraphAppDelegate.m
//  PSHTreeGraph - Example 1
//
//  Created by Ed Preston on 7/25/10.
//  Copyright Preston Software 2010. All rights reserved.
//


#import "PSHTreeGraphAppDelegate.h"
#import "PSHTreeGraphViewController.h"


#pragma mark - Internal Interface

@interface PSHTreeGraphAppDelegate () 
{

@private
    UIWindow *window_;
    PSHTreeGraphViewController *viewController_;
}

@end


@implementation PSHTreeGraphAppDelegate


@synthesize window = window_;
@synthesize viewController = viewController_;


#pragma mark - Application Lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    // Override point for customization after app launch
    // [window addSubview:viewController.view];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewController_];
    self.window.rootViewController = self.tabBarController;
    
    // Hide Bottom bar
    [self hideTabBar:self.tabBarController animated:NO];
    
    
    [window_ makeKeyAndVisible];
}

- (void)hideTabBar:(UITabBarController *)tabBarController
          animated:(BOOL)animated {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    if (animated) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
    }
    
    float fHeight = screenRect.size.height;
    if(  UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) )
    {
        fHeight = screenRect.size.width;
    }
    
    for(UIView *view in tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
            view.backgroundColor = [UIColor blackColor];
        }
    }
    
    if (animated) {
        [UIView commitAnimations];
    }
}

- (void) showTabBar:(UITabBarController *) tabBarController
           animated:(BOOL) animated
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float fHeight = screenRect.size.height - 49.0;
    
    if(  UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) )
    {
        fHeight = screenRect.size.width - 49.0;
    }
    
    if (animated) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
    }
    
    for(UIView *view in tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
        }
    }
    
    if (animated)
        [UIView commitAnimations];
    
}


#pragma mark - Resouce Management

- (void) dealloc
{
    [viewController_ release];
    [window_ release];
    [super dealloc];
}


@end
