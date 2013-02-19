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
	self.menuItem3 = nil;
	
	[self.carousel1 setBackgroundColor:[UIColor clearColor]];
	[self.carousel3 setBackgroundColor:[UIColor clearColor]];

}

//delegate
- (void) resetMenu
{
	DataProvider *dp = [DataProvider sharedInstance];

	self.menuItem1 = [dp getRootMenuItem];
	self.menuItem3 = nil;
	
	[self carouselReload:self.carousel1];
	[self carouselReload:self.carousel3];
	
	[self.carousel1 setCurrentItemIndex:0];
	[self.carousel3 setCurrentItemIndex:0];
	
	[self.carousel1 setHidden:NO];
	[self.carousel3 setHidden:YES];
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
	UIImageView *imgV = nil;
	
	view = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 200.0f)];
	view.backgroundColor = /*(index == 0) ? [UIColor clearColor] :*/ [UIColor lightGrayColor];
	view.layer.cornerRadius = 10;
	view.layer.masksToBounds = YES;
		
	imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 160.0f)];
	[view addSubview:imgV];

	label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 160.0f, 200.0f, 40.0f)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [label.font fontWithSize:20];
	label.textAlignment = NSTextAlignmentCenter;
	[view addSubview:label];
	
	NSString *title;
	UIImage *img;
	if (carousel == self.carousel1)
	{
		if (index == 0)
		{
			title = [self.menuItem1 getTitle];
			img = [self.menuItem1 getImg];
		}
		else
		{
			title = [[self.menuItem1.getChildren objectAtIndex:index-1] getTitle];
			img = [[self.menuItem1.getChildren objectAtIndex:index-1] getImg];
		}
	}
	else if (carousel == self.carousel3)
	{
		if (index == 0)
		{
			title = [self.menuItem3 getTitle];
			img = [self.menuItem3 getImg];
		}
		else
		{
			title = [[self.menuItem3.getChildren objectAtIndex:index-1] getTitle];
			img = [[self.menuItem3.getChildren objectAtIndex:index-1] getImg];
		}
	}
	
	label.text = title;
	imgV.image = img;
		
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
	[self startCarouseling:carousel];
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
	if (carousel.currentItemIndex != index) //no movement?! -> no animation -> no carouselReload -> don't startCarouseling!
		[self startCarouseling:carousel];
}

-(void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate
{
	//Anschubsen vermeiden!
	[carousel setCurrentItemIndex:carousel.currentItemIndex];
}

BOOL reloadCarousel1;
BOOL reloadCarousel3;

- (void)startCarouseling:(iCarousel*)carousel
{
	self.carousel1.layer.zPosition = 9;
	self.carousel3.layer.zPosition = 9;
	carousel.layer.zPosition = 10;
	
	if (self.menuItem3 == nil) //if at rootlevel, do not bring carousel3 to foreground;
	{
		self.carousel1.layer.zPosition = 10;
	} else {
		carousel.layer.zPosition = 10;
	}
	
	if (self.menuItem3 != nil) //if at rootlevel, do not hide carousel1;
		[self.carousel1 setHidden:YES];
	[self.carousel3 setHidden:YES];
	[carousel setHidden:NO];
	
	if (carousel == self.carousel1)
		reloadCarousel1 = YES;
	else if (self.menuItem3 != nil)
		reloadCarousel3 = YES;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
	if (reloadCarousel1) {
		reloadCarousel1 = NO;
		[self carouselReload:self.carousel1];
	}
	if (reloadCarousel3) {
		reloadCarousel3 = NO;
		[self carouselReload:self.carousel3];
	}
}

- (void)carouselReload:(iCarousel *)carousel
{
	if (carousel == self.carousel1)
	{
		int index = self.carousel1.currentItemIndex;
		
		if (index == 0)
		{
			//back
			self.menuItem3 = self.menuItem1.getParent;
			
			[[IDPTaskProvider sharedInstance] selectItem:self.menuItem1];

//			if (self.menuItem3 == nil) self.menuItem3 = self.menuItem1; //Anti-"Nothing visible"-bug
			int backindex = [[self.menuItem3 getChildren] indexOfObject:self.menuItem1]+1;
			[self.carousel3 reloadData];
			[self.carousel3 setCurrentItemIndex:backindex];
			[self.carousel3 setHidden:NO];
		}
		else
		{
			//down
			self.menuItem3 = [self.menuItem1.getChildren objectAtIndex:index-1];
			
			[[IDPTaskProvider sharedInstance] selectItem:self.menuItem3];
			
			if ([self.menuItem3 getChildrenCount] == 0)
			{
				[self.carousel3 setHidden:YES];
			}
			else
			{
				[self.carousel3 setCurrentItemIndex:0];
				[self.carousel3 reloadData];
				[self.carousel3 setHidden:NO];
			}
		}
	}
	else if (carousel == self.carousel3)
	{
		if (self.menuItem3 == nil) return; //Anti-"Nothing visible"-bug
		
		int index = self.carousel3.currentItemIndex;
		
		if (index == 0)
		{
			//back
			self.menuItem1 = self.menuItem3.getParent;
			
			[[IDPTaskProvider sharedInstance] selectItem:self.menuItem3];

//			if (self.menuItem1 == nil) self.menuItem1 = self.menuItem3; //Anti-"Nothing visible"-bug
			int backindex = [[self.menuItem1 getChildren] indexOfObject:self.menuItem3]+1;
			[self.carousel1 reloadData];
			[self.carousel1 setCurrentItemIndex:backindex];
			[self.carousel1 setHidden:NO];
		}
		else
		{
			//down
			self.menuItem1 = [self.menuItem3.getChildren objectAtIndex:index-1];
			
			[[IDPTaskProvider sharedInstance] selectItem:self.menuItem1];
			
			if ([self.menuItem1 getChildrenCount] == 0)
			{
				[self.carousel1 setHidden:YES];
			}
			else
			{
				[self.carousel1 setCurrentItemIndex:0];
				[self.carousel1 reloadData];
				[self.carousel1 setHidden:NO];
			}
		}
		
	}
	
}

@end
