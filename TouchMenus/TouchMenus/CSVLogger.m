//
//  CSVLogger.m
//  TouchMenus
//
//  Created by Steffen Bauereiss on 26.02.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import "CSVLogger.h"

@interface CSVLogger(){
}

@property NSFileHandle *file;

@end

@implementation CSVLogger

@synthesize file = _file;

static CSVLogger *_sharedMySingleton = nil;

+ (CSVLogger *) sharedInstance
{
	@synchronized([CSVLogger class])
	{
		if (!_sharedMySingleton)
			return [[self alloc] init];
		return _sharedMySingleton;
	}
	return nil;
}

+ (id) alloc
{
	@synchronized([CSVLogger class])
	{
		NSAssert(_sharedMySingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedMySingleton = [super alloc];
		return _sharedMySingleton;
	}
	return nil;
}

- (id) init
{
	self = [super init];
	if (self != nil) {
		
		//Get the file path
		NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		NSString *fileName = [documentsDirectory stringByAppendingPathComponent:@"logfile.csv"];
		
		//create file if it doesn't exist
		if(![[NSFileManager defaultManager] fileExistsAtPath:fileName])
		{
			[[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil];
		}
		
		self.file = [NSFileHandle fileHandleForUpdatingAtPath:fileName];
		
	}
	return self;
}

- (void) logToFileAt:(double)timestamp mesage:(NSString *)msg itemTitle:(NSString *)title {

	NSString *line = [NSString stringWithFormat:@"%f;%@;%@;\n",timestamp,msg,title];
	
	[self.file seekToEndOfFile];
	[self.file writeData:[line dataUsingEncoding:NSUTF8StringEncoding]];
	
}

- (void) dealloc
{
	[self.file closeFile];
}

@end
