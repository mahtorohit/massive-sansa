//
//  Created by Steffen Bauereiss on 24.12.12.
//  Copyright (c) 2012 Steffen Bauereiss. All rights reserved.
//

#import "DataProvider.h"
#import "SMXMLDocument.h"

@implementation DataProvider

NSArray* rootElements;

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
		
		NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sample2" ofType:@"xml"]];
		
		NSError *error;
		SMXMLDocument *document = [SMXMLDocument documentWithData:data error:&error];

		SMXMLElement *item = document.root;

		rootElements = [[self getChildrenOf:item usingParent:nil] copy];
		NSLog(@"--> %i ", [rootElements count]);
		
	}
	return self;
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
	return rootElements;
}

- (MenuItem *)getRootMenuItem {
    
    NSArray *rootLevelElements = [self getRootLevelElements];
    MenuItem *rootItem = [[MenuItem alloc] initWithTitle:@"Root" imgUrl:@"" usingChildren:rootLevelElements andParent:nil];
    
    for (MenuItem *item in rootLevelElements) {
        [item setParent:rootItem];
    }
    
    return rootItem;
}

@end
