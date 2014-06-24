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

- (void)DCManager:(id)sender getUserByIdResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getUserByIdErrorResponse:(NSString *)errorResponse;

- (void)DCManager:(id)sender meResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender meErrorResponse:(NSString *)errorResponse;

- (void)DCManager:(id)sender loginWithPasswordResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender loginWithPasswordErrorResponse:(NSString *)errorResponse;

- (void)DCManager:(id)sender userUpdateResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender userUpdateErrorResponse:(NSString *)errorResponse;
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
- (void)removeAppKey;
- (void)getPictureById:(NSInteger *)picture_id width:(NSInteger *)width height:(NSInteger *)height blur:(NSInteger *)blur;
- (void)loginWithFacebookToken:(NSString *)fb_token ios_device_token:(NSString *)ios_device_token;
- (void)saveAccessToken:(NSString *)access_token;
- (NSString *)getAccessToken;
- (void)getContactByAppKey:(NSInteger *)app_key;
- (void)me;
- (void)saveUserId:(NSString *)user_id;
- (NSString *)getUserId;
- (void)getUserById:(NSInteger )user_id;
- (void)loginWithPassword:(NSString *)username password:(NSString *)password;
/*
 birth_date : Date for mat (Y-m-d) example: 1990-01-20
 gender : String(male, female)
 picture : (Base64 image string)
 */
- (void)userUpdate:(NSString *)display_name birth_date:(NSString *)birth_date gender:(NSString *)gender mobile_phone:(NSString *)mobile_phone website:(NSString *)website ;























@end
