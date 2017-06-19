//
//  S&TNode.m
//  PSHTreeGraph
//
//  Created by Rohit Mahto on 16/06/17.
//  Copyright © 2017 Preston Software. All rights reserved.
//

#import "S&TNode.h"

@implementation S_TNode

-(id)initWithData:(NSDictionary*)data{
    if(data){
        self.title = data[@"Caption"];
        self.number = data[@"Number"];
        self.status = data[@"Status"];
        self.comment = data[@"Comments"];
        self.groupId = data[@"GroupId"];
        self.isDeleted = data[@"IsDeleted"];
        self.NodeDetailsTO = data[@"NodeDetailsTO"];
        self.Id = data[@"Id"];
    }
    return self;
}

-(NSDictionary*)jsonData{
    NSMutableDictionary * data = [[NSMutableDictionary alloc] init];
    [data setObject:self.title forKey:@"Caption"];
    [data setObject:self.number forKey:@"Number"];
    [data setObject:self.status forKey:@"Status"];
    [data setObject:self.comment forKey:@"Comments"];
    [data setObject:self.groupId forKey:@"GroupId"];
    [data setObject:self.isDeleted forKey:@"IsDeleted"];
    [data setObject:self.NodeDetailsTO forKey:@"NodeDetailsTO"];
    return data;
}

@end
