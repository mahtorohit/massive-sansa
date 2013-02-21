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

//MyCollectionViewController

+ (NSMutableArray *) exerciseSet
{
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	IDPExercise *ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = @"UnfoldingList";
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"Käse", nil];
	
	[array addObject:ex];

	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = @"2DCoverflow";
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"Brote", nil];
	
	[array addObject:ex];

	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = @"GridMenu";
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"Gemüse", nil];
	
	[array addObject:ex];

	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = @"GridMenuBC";
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"Obst", nil];
	
	[array addObject:ex];

	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = @"Dropdown";
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"Gurke", @"Birne", nil];
	
	[array addObject:ex];

	ex = [[IDPExercise alloc] init];
	ex.menuIdentifier = @"HorizList";
	ex.tasksForMenu = [[NSMutableArray alloc] initWithObjects:@"Feldsalat", @"Erbsen", @"Apfel", @"Limette", nil];

	[array addObject:ex];
	
	return array;
	
}


@end
