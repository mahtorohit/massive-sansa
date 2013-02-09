//
//  iCarouselExampleViewController.m
//  iCarouselExample
//
//  Created by Nick Lockwood on 03/04/2011.
//  Copyright 2011 Charcoal Design. All rights reserved.
//

#import "iCarouselExampleViewController.h"
#import "DataProvider.h"

@interface iCarouselExampleViewController () {
	
}

@property (nonatomic, assign) BOOL wrap;

@property MenuItem *menuItem1;
@property MenuItem *menuItem3;

@end


@implementation iCarouselExampleViewController

@synthesize carousel1 = _carousel1;
@synthesize carousel3 = _carousel3;

@synthesize menuItem1 = _menuItem1;
@synthesize menuItem3 = _menuItem3;

- (void)setUp
{
	
	DataProvider *dp = [DataProvider sharedInstance];
	
	self.menuItem1 = [dp getRootMenuItem];
	self.menuItem3 = [[[dp getRootMenuItem] getChildren] objectAtIndex:0];
	
	[self.carousel1 setBackgroundColor:[UIColor clearColor]];
	[self.carousel3 setBackgroundColor:[UIColor clearColor]];
	
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setUp];
    }
    return self;
}

- (void)dealloc
{
	//it's a good idea to set these to nil here to avoid
	//sending messages to a deallocated viewcontroller
	self.carousel1.delegate = nil;
	self.carousel1.dataSource = nil;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configure carousel
    self.carousel1.type = iCarouselTypeCoverFlow2;
    self.carousel3.type = iCarouselTypeCoverFlow2;
	self.carousel3.vertical = !self.carousel1.vertical;
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel1 = nil;
	self.carousel3 = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark UIActionSheet methods

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //map button index to carousel type
    iCarouselType type = buttonIndex;
    
    //carousel can smoothly animate between types
    [UIView beginAnimations:nil context:nil];
    self.carousel1.type = type;
    self.carousel3.type = type;
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    if (carousel == self.carousel1) return [self.menuItem1 getChildrenCount] + 1;
	else if (carousel == self.carousel3) return [self.menuItem3 getChildrenCount] + 1;
	
	return 0;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
	//create new view if no view is available for recycling
	if (view == nil)
	{
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        view.backgroundColor = (index == 0) ? [UIColor orangeColor] : [UIColor lightGrayColor];
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.font = [label.font fontWithSize:20];
		label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
    }
    else
	{
		label = [[view subviews] lastObject];
	}
	
	NSString *title;
	if (carousel == self.carousel1)
	{
		if (index == 0)
			title = [self.menuItem1 getTitle];
		else
			title = [[self.menuItem1.getChildren objectAtIndex:index-1] getTitle];
	}
	else if (carousel == self.carousel3)
	{
		if (index == 0)
			title = [self.menuItem3 getTitle];
		else
			title = [[self.menuItem3.getChildren objectAtIndex:index-1] getTitle];
	}
	label.text = title;
		
	return view;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carousel1.itemWidth);
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            return NO;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.55f;
        }
        case iCarouselOptionFadeMax:
        {
            return value;
        }
        default:
        {
            return value;
        }
    }
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel
{
	self.carousel1.layer.zPosition = 9;
	self.carousel3.layer.zPosition = 9;
	[self.carousel1 setHidden:YES];
	[self.carousel3 setHidden:YES];
	carousel.layer.zPosition = 10;
	[carousel setHidden:NO];
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
	self.carousel1.layer.zPosition = 9;
	self.carousel3.layer.zPosition = 9;
	[self.carousel1 setHidden:YES];
	[self.carousel3 setHidden:YES];
	carousel.layer.zPosition = 10;
	[carousel setHidden:NO];
}
- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate
{

}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
	if (carousel == self.carousel1)
	{
		int index = self.carousel1.currentItemIndex;
		
		if (index == 0)
		{
			//back
			self.menuItem3 = self.menuItem1.getParent;
			[self.carousel3 setCurrentItemIndex:[[self.menuItem3 getChildren] indexOfObject:self.menuItem1]+1];
			[self.carousel3 reloadData];
			[self.carousel3 setHidden:NO];
			self.carousel1.layer.zPosition = 9;
			self.carousel3.layer.zPosition = 10;
			
		}
		else
		{
			//down
			MenuItem *oldItem = self.menuItem3;
			self.menuItem3 = [self.menuItem1.getChildren objectAtIndex:index-1];
			if ([self.menuItem3 getChildrenCount] == 0)
				self.menuItem3 = oldItem;
			else
			{
				[self.carousel3 setCurrentItemIndex:0];
				[self.carousel3 reloadData];
				[self.carousel3 setHidden:NO];
				//				self.carousel1.layer.zPosition = 9;
				//				self.carousel3.layer.zPosition = 10;
			}
		}
	}
	else if (carousel == self.carousel3)
	{
		int index = self.carousel3.currentItemIndex;
		
		if (index == 0)
		{
			//back
			self.menuItem1 = self.menuItem3.getParent;
			[self.carousel1 setCurrentItemIndex:[[self.menuItem1 getChildren] indexOfObject:self.menuItem3]+1];
			[self.carousel1 reloadData];
			[self.carousel1 setHidden:NO];
			self.carousel1.layer.zPosition = 10;
			self.carousel3.layer.zPosition = 9;
			
		}
		else
		{
			//down
			MenuItem *oldItem = self.menuItem1;
			self.menuItem1 = [self.menuItem3.getChildren objectAtIndex:index-1];
			if ([self.menuItem1 getChildrenCount] == 0)
				self.menuItem1 = oldItem;
			else
			{
				[self.carousel1 setCurrentItemIndex:0];
				[self.carousel1 reloadData];
				[self.carousel1 setHidden:NO];
				//				self.carousel1.layer.zPosition = 10;
				//				self.carousel3.layer.zPosition = 9;
			}
		}
		
	}
	
}

@end
