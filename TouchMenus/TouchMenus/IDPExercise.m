//
//  IDPExercise.m
//  TouchMenus
//
//  Created by Steffen Bauereiss on 21.02.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import "IDPExercise.h"

@implementation IDPExercise

@synthesize menuIdentifier = _menuIdentifier;
@synthesize tasksForMenu = _tasksForMenu;


//HorizList
//2DCoverflow
//GridMenu
//GridMenuBC
//Dropdown
//FastActionTreeView
//UnfoldingList
//FastActionTree

//MyCollectionViewController

+ (NSMutableArray *) exerciseSet:(NSInteger)number
{
	NSMutableArray *array = [[NSMutableArray alloc] init];
    
	IDPExercise *ex;
	NSString *menuIdentifier;
	
	NSLog(@"It's a %i",number);
	
	NSArray *permuts =
	[[NSArray alloc] initWithObjects:
	 
	[[NSArray alloc] initWithObjects:@"UnfoldingList", @"HorizList", @"Dropdown", @"GridMenuBC", @"2DCoverflow", @"FastActionTreeView",nil],
	[[NSArray alloc] initWithObjects:@"HorizList", @"2DCoverflow", @"UnfoldingList", @"GridMenuBC", @"Dropdown", @"FastActionTreeView",nil],
	[[NSArray alloc] initWithObjects:@"FastActionTreeView", @"Dropdown", @"HorizList", @"2DCoverflow", @"UnfoldingList", @"GridMenuBC",nil],
	
	[[NSArray alloc] initWithObjects:@"FastActionTreeView", @"2DCoverflow", @"UnfoldingList", @"HorizList", @"Dropdown", @"GridMenuBC",nil],
	[[NSArray alloc] initWithObjects:@"Dropdown", @"FastActionTreeView", @"GridMenuBC", @"UnfoldingList", @"HorizList", @"2DCoverflow",nil],
	[[NSArray alloc] initWithObjects:@"GridMenuBC", @"Dropdown", @"HorizList", @"2DCoverflow", @"UnfoldingList", @"FastActionTreeView",nil],
	[[NSArray alloc] initWithObjects:@"FastActionTreeView", @"GridMenuBC", @"2DCoverflow", @"UnfoldingList", @"HorizList", @"Dropdown",nil],
	[[NSArray alloc] initWithObjects:@"UnfoldingList", @"Dropdown", @"HorizList", @"2DCoverflow", @"FastActionTreeView", @"GridMenuBC",nil],
	[[NSArray alloc] initWithObjects:@"Dropdown", @"HorizList", @"UnfoldingList", @"2DCoverflow", @"FastActionTreeView", @"GridMenuBC",nil],
	[[NSArray alloc] initWithObjects:@"Dropdown", @"UnfoldingList", @"2DCoverflow", @"FastActionTreeView", @"GridMenuBC", @"HorizList",nil],
	[[NSArray alloc] initWithObjects:@"UnfoldingList", @"GridMenuBC", @"2DCoverflow", @"FastActionTreeView", @"Dropdown", @"HorizList",nil],
	[[NSArray alloc] initWithObjects:@"UnfoldingList", @"FastActionTreeView", @"GridMenuBC", @"Dropdown", @"HorizList", @"2DCoverflow",nil],
	[[NSArray alloc] initWithObjects:@"2DCoverflow", @"HorizList", @"UnfoldingList", @"FastActionTreeView", @"GridMenuBC", @"Dropdown",nil],
	[[NSArray alloc] initWithObjects:@"2DCoverflow", @"UnfoldingList", @"Dropdown", @"HorizList", @"FastActionTreeView", @"GridMenuBC",nil],
	[[NSArray alloc] initWithObjects:@"HorizList", @"UnfoldingList", @"GridMenuBC", @"FastActionTreeView", @"2DCoverflow", @"Dropdown",nil],
	[[NSArray alloc] initWithObjects:@"FastActionTreeView", @"HorizList", @"Dropdown", @"GridMenuBC", @"2DCoverflow", @"UnfoldingList",nil],
	[[NSArray alloc] initWithObjects:@"FastActionTreeView", @"UnfoldingList", @"GridMenuBC", @"Dropdown", @"2DCoverflow", @"HorizList",nil],
	[[NSArray alloc] initWithObjects:@"HorizList", @"GridMenuBC", @"FastActionTreeView", @"Dropdown", @"UnfoldingList", @"2DCoverflow",nil],
	[[NSArray alloc] initWithObjects:@"HorizList", @"FastActionTreeView", @"2DCoverflow", @"UnfoldingList", @"Dropdown", @"GridMenuBC",nil],
	[[NSArray alloc] initWithObjects:@"Dropdown", @"2DCoverflow", @"HorizList", @"GridMenuBC", @"UnfoldingList", @"FastActionTreeView",nil],
	[[NSArray alloc] initWithObjects:@"Dropdown", @"GridMenuBC", @"FastActionTreeView", @"HorizList", @"2DCoverflow", @"UnfoldingList",nil],
	[[NSArray alloc] initWithObjects:@"GridMenuBC", @"2DCoverflow", @"UnfoldingList", @"HorizList", @"FastActionTreeView", @"Dropdown",nil],
	[[NSArray alloc] initWithObjects:@"GridMenuBC", @"HorizList", @"Dropdown", @"FastActionTreeView", @"2DCoverflow", @"UnfoldingList",nil],
	[[NSArray alloc] initWithObjects:@"UnfoldingList", @"2DCoverflow", @"FastActionTreeView", @"HorizList", @"GridMenuBC", @"Dropdown",nil],
	[[NSArray alloc] initWithObjects:@"GridMenuBC", @"UnfoldingList", @"FastActionTreeView", @"Dropdown", @"HorizList", @"2DCoverflow",nil],
	[[NSArray alloc] initWithObjects:@"HorizList", @"Dropdown", @"UnfoldingList", @"2DCoverflow", @"GridMenuBC", @"FastActionTreeView",nil],
	[[NSArray alloc] initWithObjects:@"GridMenuBC", @"FastActionTreeView", @"2DCoverflow", @"UnfoldingList", @"Dropdown", @"HorizList",nil],
	[[NSArray alloc] initWithObjects:@"2DCoverflow", @"Dropdown", @"HorizList", @"GridMenuBC", @"UnfoldingList", @"FastActionTreeView",nil],
	[[NSArray alloc] initWithObjects:@"2DCoverflow", @"GridMenuBC", @"FastActionTreeView", @"UnfoldingList", @"Dropdown", @"HorizList",nil],
	[[NSArray alloc] initWithObjects:@"2DCoverflow", @"FastActionTreeView", @"GridMenuBC", @"Dropdown", @"HorizList", @"UnfoldingList",nil], nil];
	
	NSArray *menuIdentifiers = [permuts objectAtIndex:number%[permuts count]];
	
	menuIdentifier = [menuIdentifiers objectAtIndex:5];
	
    ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:0];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects: @"Weizen",@"Kiwi",@"Süßkirsche",@"Chips",@"Studentenfutter", nil];
	[array addObject:ex];
    ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:1];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"Fotodrucker", @"MacBook", @"MP3-Player",@"Eierkocher",@"Fritteuse", nil];
	[array addObject:ex];
	//dummyEx
	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:2];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:nil];
	[array addObject:ex];
	
	
	menuIdentifier = [menuIdentifiers objectAtIndex:4];

	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:0];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"Broccoli",@"Kürbis", @"Buttermilch",@"Fruchtriegel",@"Milchschokolade",nil];
	[array addObject:ex];
    ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:1];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"Prozessor",@"Interne Festplatte",@"Uhrenradio",@"Taschenlampe",@"Reisebügeleisen",nil];
	[array addObject:ex];
	//dummyEx
	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:2];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:nil];
	[array addObject:ex];
    
	
	menuIdentifier = [menuIdentifiers objectAtIndex:3];

	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:0];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"Croissants", @"Fettarme Milch", @"Gouda",@"Haselnuss",@"Nektarine", nil];
	[array addObject:ex];
    ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:1];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"Webcam", @"Nintendo 3DS", @"PDA und Organizer", @"Anrufbeantworter",@"Kochfeld", nil];
	[array addObject:ex];
	//dummyEx
	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:2];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:nil];
	[array addObject:ex];
	
	
	menuIdentifier = [menuIdentifiers objectAtIndex:2];

	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:0];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"Sesambrötchen", @"Roggenvollkornbrot",@"Weißkohl",@"Birne",@"Zwetschge", nil];
	[array addObject:ex];
    ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:1];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"DVDs", @"Akustischer Bass" ,@"OLED TV",@"Freistehende Spüler",@"Stabmixer", nil];
	[array addObject:ex];
	//dummyEx
	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:2];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:nil];
	[array addObject:ex];
	
	
	menuIdentifier = [menuIdentifiers objectAtIndex:1];
	
	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:0];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"Kaisersemmel", @"Breze", @"Rucola", @"Papaya", @"Himbeere", nil];
	[array addObject:ex];
    ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:1];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"TV-Serien", @"Klavier", @"Projektor", @"Blu-Ray Heimkinosystem", @"Waschtrockner", nil];
	[array addObject:ex];
	//dummyEx
	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:2];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:nil];
	[array addObject:ex];

	
	menuIdentifier = [menuIdentifiers objectAtIndex:0];
	
	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:0];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"Lauch",@"Radieschen",@"Aprikose",@"Limette",@"Hustenbonbons", nil];
	[array addObject:ex];
    ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:1];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"Tablet",@"Gaming-PC",@"Center-Lautsprecher",@"Handrührer",@"Nachttischlampe", nil];
	[array addObject:ex];
	//dummyEx
	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = menuIdentifier;
	ex.dataSet = [NSNumber numberWithInt:2];
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:nil];
	[array addObject:ex];
	
	return array;
	
}


@end