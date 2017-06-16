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
@property (nonatomic, strong) NSString * Title;
@property (nonatomic,strong) NSString * uuid;
@end
