//
//  Created by Steffen Bauereiss on 24.12.12.
//  Copyright (c) 2012 Steffen Bauereiss. All rights reserved.
//

#import "DataProvider.h"
#import "SMXMLDocument.h"

@implementation DataProvider

NSArray* rootElements1;
NSArray* rootElements2;
BOOL dataSet1;

static DataProvider *_sharedMySingleton = nil;

+ (DataProvider *) sharedInstance {
	@synchronized([DataProvider class])
	{
		if (!_sharedMySingleton)
			return [[self alloc] init];
		return _sharedMySingleton;
	}
	
	return nil;
}

+ (id) alloc {
	@synchronized([DataProvider class])
	{
		NSAssert(_sharedMySingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedMySingleton = [super alloc];
		return _sharedMySingleton;
	}
	
	return nil;
}

- (id) init {
	self = [super init];
	if (self != nil) {
		
		NSError *error;

		NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sample2" ofType:@"xml"]];
		SMXMLDocument *document = [SMXMLDocument documentWithData:data error:&error];
		SMXMLElement *item = document.root;
		rootElements1 = [[self getChildrenOf:item usingParent:nil] copy];
		
		dataSet1 = YES;
		
		data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shop" ofType:@"xml"]];
		document = [SMXMLDocument documentWithData:data error:&error];
		item = document.root;
		rootElements2 = [[self getChildrenOf:item usingParent:nil] copy];
	
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			[self loadPicsFor:rootElements1];
			[self loadPicsFor:rootElements2];
			dispatch_async(dispatch_get_main_queue(), ^{
				
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cache"
																message:@"Alle Bilder geladen"
															   delegate:nil
													  cancelButtonTitle:@"OK"
													  otherButtonTitles:nil];
				[alert show];
				
			});
		});
	}
	return self;
}

- (void)loadPicsFor:(NSArray*)items
{
	for (MenuItem *item in items)
	{
		[item getImg];
		[self loadPicsFor:[item getChildren]];
	}
}


- (NSMutableArray *) getChildrenOf:(SMXMLElement *)node usingParent:(MenuItem *)parent {
	
	NSMutableArray *menuItems = [[NSMutableArray alloc] init];
	
	for (SMXMLElement *item in [node childrenNamed:@"item"]) {
		
		NSString *title = [item attributeNamed:@"name"];
		NSString *imgUrl = [item attributeNamed:@"img"];
		
		MenuItem *mItem =[[MenuItem alloc] initWithTitle:title imgUrl:imgUrl usingChildren:nil andParent:parent];
		
		NSMutableArray *children = [self getChildrenOf:item usingParent:mItem];

		[mItem setChildren:children];

		[menuItems addObject:mItem];
	}
	
	return [menuItems count] > 0 ? menuItems : nil;
}



- (NSArray *) getRootLevelElements {
	return dataSet1 ? rootElements1 : rootElements2;
}

- (MenuItem *)getRootMenuItem {
    
    NSArray *rootLevelElements = [self getRootLevelElements];
    MenuItem *rootItem = [[MenuItem alloc] initWithTitle:@"Menu" imgUrl:@"" usingChildren:rootLevelElements andParent:nil];
    
//	[rootItem setParent:rootItem];
	
    for (MenuItem *item in rootLevelElements) {
        [item setParent:rootItem];
    }
    
    return rootItem;
}

- (void) useDataset:(NSInteger)x
{
	dataSet1 = x == 0;
}

@end
