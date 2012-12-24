//
//  Created by Steffen Bauereiss on 24.12.12.
//  Copyright (c) 2012 Steffen Bauereiss. All rights reserved.
//

#import "DataProvider.h"

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
		
		NSMutableArray *array = [[NSMutableArray alloc] init];
		for (int i = 0; i < 7; i++) {
			[array addObject:[[MenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Cat %i",i] imgUrl:nil usingChildren:nil andParent:nil]];
		}
		rootElements = [array copy];
		
		for (MenuItem *m in rootElements) {
			array = [[NSMutableArray alloc] init];
			for (int i = 0; i < 12; i++) {
				[array addObject:[[MenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Item %i",i] imgUrl:nil usingChildren:nil andParent:m]];
			}
			[m setChildren:[array copy]];
			for (MenuItem *mm in [m getChildren]) {
				array = [[NSMutableArray alloc] init];
				for (int i = 0; i < 4; i++) {
					[array addObject:[[MenuItem alloc] initWithTitle:[NSString stringWithFormat:@"SubItem %i",i] imgUrl:nil usingChildren:nil andParent:mm]];
				}
				[mm setChildren:[array copy]];
			}
		}
		
	}
	
	return self;
}

- (NSArray *) getRootLevelElements {
	return rootElements;
}

@end
