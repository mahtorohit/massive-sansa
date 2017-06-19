//
//  Created by Steffen Bauereiss on 24.12.12.
//  Copyright (c) 2012 Steffen Bauereiss. All rights reserved.
//

#import "TreeDataProvider.h"

@implementation TreeDataProvider

NSArray* rootElements;

static TreeDataProvider *_sharedMySingleton = nil;
TreeMenuItem * root;
+ (TreeDataProvider *) sharedInstance {
    @synchronized([TreeDataProvider class])
    {
        if (!_sharedMySingleton)
            return [[self alloc] init];
        return _sharedMySingleton;
    }
    
    return nil;
}

+ (id) alloc {
    @synchronized([TreeDataProvider class])
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
        for (int i = 0; i < 2; i++) {
            [array addObject:[[TreeMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Cat %i",i] imgUrl:nil usingChildren:nil andParent:nil]];
        }
        rootElements = [array copy];
        
        for (TreeMenuItem *m in rootElements) {
            array = [[NSMutableArray alloc] init];
            for (int i = 0; i < 2; i++) {
                [array addObject:[[TreeMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Item %i",i] imgUrl:nil usingChildren:nil andParent:m]];
            }
            [m setChildren:[array copy]];
            for (TreeMenuItem *mm in [m getChildren]) {
                array = [[NSMutableArray alloc] init];
                for (int i = 0; i < 2; i++) {
                    [array addObject:[[TreeMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"SubItem %i",i] imgUrl:nil usingChildren:nil andParent:mm]];
                }
                [mm setChildren:[array copy]];
            }
        }
        
    }
    
    return self;
}

- (id) initWithData:(NSDictionary*)data
{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSError * error=nil;
    NSString *jsonString = [NSString stringWithContentsOfFile:filePath encoding:nil error:&error];
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    parsedData = parsedData[@"RootNode"];
    TreeMenuItem * node = [[TreeMenuItem alloc] initWithTitle:@"ROOT" imgUrl:nil usingChildren:nil andParent:nil];
    
    [self getNode1:parsedData paranet:node];
    
    rootElements = @[node];
    
    
    return self;
}

-(void)repeat:(NSDictionary*)data parent: (TreeMenuItem*)parent{
    
}

-(NSArray*)getNode1:(NSDictionary*)data paranet:(TreeMenuItem*)parent{
    TreeMenuItem * node ;
    NSMutableArray * retData = [[NSMutableArray alloc] init];
    NSArray * childNodes = (NSArray*) data[@"ChildNodes"] ;
    for(int i = 0; i < childNodes.count; i++){
        [retData addObject: [self getNode:childNodes[i] paranet:parent]];
    }
    return retData;
}

-(TreeMenuItem*)getNode:(NSDictionary*)data paranet:(TreeMenuItem*)parent
{
    S_TNode * node = [[S_TNode alloc] initWithData:data];
    if(parent == nil){
        parent = [[TreeMenuItem alloc] initWithTitle:node.title imgUrl:nil usingChildren:nil andParent:nil];
        parent.s_tNode = node;
    }else{
        TreeMenuItem * item = [[TreeMenuItem alloc] initWithTitle:node.title imgUrl:nil usingChildren:nil andParent:parent];
        [parent addChildren:item];
    }
    
    return parent;
}

-(NSArray*)getChilds: (NSDictionary*)data{
    
    
    if(data == nil || data[@"ChildNodes"] == nil){
        return nil;
    }
    
    //    NSMutableArray *array = [[NSMutableArray alloc] init];
    //    for (NSDictionary * node in data[@"ChildNodes"]) {
    //        [array addObject:[[TreeMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Cat %i",i] imgUrl:nil usingChildren:nil andParent:nil]];
    //    }
    
    
}

- (NSArray *) getRootLevelElements {
    return rootElements;
}

- (TreeMenuItem *)getRootMenuItem {
    
    NSArray *rootLevelElements = [self getRootLevelElements];
    TreeMenuItem *rootItem = [[TreeMenuItem alloc] initWithTitle:@"Root" imgUrl:@"" usingChildren:rootLevelElements andParent:nil];
    
    for (TreeMenuItem *item in rootLevelElements) {
        [item setParent:rootItem];
    }
    
    return rootItem;
}

@end
