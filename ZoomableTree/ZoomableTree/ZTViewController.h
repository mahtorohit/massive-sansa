//
//  ZTViewController.h
//  ZoomableTree
//
//  Created by Steffen Bauereiss on 02.01.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTGraphView.h"

@interface ZTViewController : UIViewController<UIGestureRecognizerDelegate> {
	
	CGPoint previousPanPosition;
	ZTGraphView *graphView;

}

@property (strong, nonatomic) IBOutlet UIView *uiView;

@end
