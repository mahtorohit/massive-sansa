//
//  S&TNode.h
//  PSHTreeGraph
//
//  Created by Rohit Mahto on 16/06/17.
//  Copyright © 2017 Preston Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface S_TNode : NSObject

@property (nonatomic,strong) NSDictionary * jsonData;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * uuid;
@property (nonatomic,strong) NSString * caption;
@property (nonatomic,strong) NSString * number;
@property (nonatomic,strong) NSString * status;
@property (nonatomic,strong) NSString * groupId;
@property (nonatomic,strong) NSString * isDeleted;
-(id)initWithData:(NSDictionary*)data;
@end
