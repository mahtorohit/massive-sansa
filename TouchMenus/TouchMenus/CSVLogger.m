//
//  CSVLogger.m
//  TouchMenus
//
//  Created by Steffen Bauereiss on 26.02.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import "CSVLogger.h"
#import "IDPAppDelegate.h"

@interface CSVLogger(){
}

@property NSFileHandle *file;
@property UIViewController *controller;
@property NSString *fileName;

@end

@implementation CSVLogger

@synthesize file = _file;
@synthesize controller = _controller;
@synthesize fileName = _fileName;

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
		
		NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"countingNumber"];
		if (number == nil)
		{
			number = [NSNumber numberWithInt:0];
			[[NSUserDefaults standardUserDefaults] setObject:number forKey:@"countingNumber"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		} else {
			number = [NSNumber numberWithInt:[number intValue]+1];
			[[NSUserDefaults standardUserDefaults] setObject:number forKey:@"countingNumber"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
		
		self.fileName = [NSString stringWithFormat:@"logfile%i.csv", [number intValue]];
		
		//Get the file path
		NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		NSString *fileName = [documentsDirectory stringByAppendingPathComponent:self.fileName];
		
		[[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil];
		
		self.file = [NSFileHandle fileHandleForUpdatingAtPath:fileName];
		
	}
	return self;
}

- (void) logToFileAt:(double)timestamp message:(NSString *)msg itemTitle:(NSString *)title {
	
	NSString *line = [NSString stringWithFormat:@"%f;%@;%@;;;;;;\n",timestamp,msg,title];
	
	[self.file seekToEndOfFile];
	[self.file writeData:[line dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void) logToFileAt:(double)timestamp swipeFrom:(CGPoint)from to:(CGPoint)to direction:(UISwipeGestureRecognizerDirection)dir {
	
	NSString *line;

	line = [NSString stringWithFormat:@"%f;SWIPE;;%f;%f;%f;%f;%i;\n",timestamp,from.x, from.y, to.x, to.y, dir];
	
	[self.file seekToEndOfFile];
	[self.file writeData:[line dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void)closeFileHandle:(UIViewController *)ctr;
{
	[self.file closeFile];
	
	self.controller = ctr;
	
	[NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(mail) userInfo:nil repeats:NO];
	
}

- (void)mail
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"Logfile Probandenversuch"];
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObjects:@"nadja.sahinagic@gmail.com", @"mahmuzicamel@gmail.com", @"steffen.bauereiss@gmail.com",nil];
    
    [picker setToRecipients:toRecipients];
    
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    // Build the path to the database file
    NSString *databasePath = [docsDir stringByAppendingPathComponent:self.fileName];
	
    NSData *myData = [NSData dataWithContentsOfFile:databasePath];
    
    [picker addAttachmentData:myData mimeType:@"application/binary" fileName:self.fileName];
    
    // Fill out the email body text
    NSString *emailBody = @"CSV-File";
    [picker setMessageBody:emailBody isHTML:NO];
    
	[self.controller presentViewController:picker animated:YES completion:nil];
}

- (void) dealloc
{
	[self.file closeFile];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
            break;
        default:
            break;
    }
	[self.controller dismissViewControllerAnimated:YES completion:nil];
}

@end
