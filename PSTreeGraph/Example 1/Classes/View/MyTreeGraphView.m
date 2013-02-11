//
//  MyTreeGraphView.m
//  PSHTreeGraph - Example 1
//
//  Created by Ed Preston on 7/25/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "MyTreeGraphView.h"


@implementation MyTreeGraphView


#pragma mark - UIView

- (id) initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {

        // Initialization code when created dynamicly

    }
    return self;
}


#pragma mark - NSCoding

- (id) initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {

        // Initialization code when loaded from XIB (this example)

        // Example: Set a larger content margin than default.

        //        self.contentMargin = 60.0;
        
        self.connectingLineStyle = PSTreeGraphConnectingLineStyleOrthogonal;
        self.connectingLineColor = [UIColor grayColor];
        self.treeGraphOrientation = PSTreeGraphOrientationStyleVertical;
        self.backgroundColor = [UIColor whiteColor];
        self.parentChildSpacing = 25.0f;
        self.siblingSpacing = 25.0f;
        
    }
    return self;
}

#pragma mark - Resource Management

- (void) dealloc
{
    [super dealloc];
}

@end
