//
//  DCManager.h
//  DemoCoffee
//
//  Created by MRG on 6/20/2557 BE.
//  Copyright (c) 2557 Platwo fusion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "PFHelper.h"


@protocol DCManagerDelegate <NSObject>

#pragma mark - Core Protocal Delegate
- (void)DCManager:(id)sender getLinkResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getLinkErrorResponse:(NSString *)errorResponse;

@end

@interface DCManager : NSObject

#pragma mark - Property
@property PFHelper *hp;
@property AFHTTPRequestOperationManager *manager;
@property NSUserDefaults *userDefaults;
@property (assign, nonatomic) id delegate;




@end
