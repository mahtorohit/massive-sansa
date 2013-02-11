//
//  MyLeafView.m
//  PSHTreeGraph - Example 1
//
//  Created by Ed Preston on 7/26/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "MyLeafView.h"


@interface MyLeafView () 
{
    
@private
    // Interface
 //   UIButton *expandButton_;
    UILabel *titleLabel_;
//    UILabel *detailLabel_;
}

@end


@implementation MyLeafView


#pragma mark - Property Accessors

//@synthesize expandButton = expandButton_;
@synthesize titleLabel = titleLabel_;
//@synthesize detailLabel = detailLabel_;


#pragma mark - NSCoding

- (id) initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        
        

        // Initialization code, leaf views are always loaded from the corresponding XIB.
        // Be sure to set the view class to your subclass in interface builder.

        // Example: Inverse the color scheme

        self.fillColor = [UIColor whiteColor];
        self.selectionColor = [UIColor colorWithRed:233.0f/255.0f green:233.0f/255.0f blue:233.0f/255.0f alpha:1.0f];;
        self.borderWidth = 2;
        self.borderColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
        
        self.layer.shadowOffset = CGSizeMake(1, 0);
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = .25;
        
        CGRect shadowFrame = self.layer.bounds;
        CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
        self.layer.shadowPath = shadowPath;
    }
    return self;
}


#pragma mark - Resource Management

- (void) dealloc
{
    [super dealloc];
}

@end
