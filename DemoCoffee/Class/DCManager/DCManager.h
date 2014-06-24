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
- (void)DCManager:(id)sender appRequestResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender appRequestErrorResponse:(NSString *)errorResponse;

- (void)DCManager:(id)sender getPictureByIdResponse:(UIImage *)response;
- (void)DCManager:(id)sender getPictureByIdErrorResponse:(NSString *)errorResponse;

- (void)DCManager:(id)sender loginWithFacebookTokenResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender loginWithFacebookTokenErrorResponse:(NSString *)errorResponse;

- (void)DCManager:(id)sender getContactByAppKeyResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getContactByAppKeyErrorResponse:(NSString *)errorResponse;

@end

@interface DCManager : NSObject

#pragma mark - Property
@property PFHelper *hp;
@property AFHTTPRequestOperationManager *manager;
@property NSUserDefaults *userDefaults;
@property (assign, nonatomic) id delegate;
@property NSString *urlStr;
#pragma mark - function
- (void)appRequest;
- (void)saveAppKey:(NSString *)app_key;
- (NSString *)getAppKey;
- (void)getPictureById:(NSInteger *)picture_id width:(NSInteger *)width height:(NSInteger *)height blur:(NSInteger *)blur;
- (void)loginWithFacebookToken:(NSString *)fb_token ios_device_token:(NSString *)ios_device_token;
- (void)saveAccessToken:(NSString *)access_token;
- (NSString *)getAccessToken;
- (void)getContactByAppKey:(NSInteger *)app_key;
- (void)me;
@end
