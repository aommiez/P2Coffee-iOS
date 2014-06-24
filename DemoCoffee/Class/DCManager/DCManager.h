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
/*
 Protocal Delegate request app key from server
 */
- (void)DCManager:(id)sender appRequestResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender appRequestErrorResponse:(NSString *)errorResponse;
/*
 Protocal Delegate getPictureById
 */
- (void)DCManager:(id)sender getPictureByIdResponse:(UIImage *)response;
- (void)DCManager:(id)sender getPictureByIdErrorResponse:(NSString *)errorResponse;
/*
 Protocal Delegate login facebook token
 */
- (void)DCManager:(id)sender loginWithFacebookTokenResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender loginWithFacebookTokenErrorResponse:(NSString *)errorResponse;
/*
 Protocal Delegate get contact by app key
 */
- (void)DCManager:(id)sender getContactByAppKeyResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getContactByAppKeyErrorResponse:(NSString *)errorResponse;
/*
 Protocal Delegate get user profile by id
 */
- (void)DCManager:(id)sender getUserByIdResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getUserByIdErrorResponse:(NSString *)errorResponse;
/*
 Protocal Delegate request get user profile me
 */
- (void)DCManager:(id)sender meResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender meErrorResponse:(NSString *)errorResponse;
/*
 Protocal Delegate login with username password
 */
- (void)DCManager:(id)sender loginWithPasswordResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender loginWithPasswordErrorResponse:(NSString *)errorResponse;
/*
 Protocal Delegate update user profile
 */
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
/*
 request app key from server
 */
- (void)appRequest;
/*
 save app key to NSUserDefaults
 */
- (void)saveAppKey:(NSString *)app_key;
/*
 get app key from NSUserDefaults
 */
- (NSString *)getAppKey;
/*
 remove app key from NSUserDefaults
 */
- (void)removeAppKey;
/*
 get picture by id 
 picture_id : id picture 
 with : Config width image ( 0 = img defaults )
 height : config height image ( 0 = img defaults )
 blur : 0
 */
- (void)getPictureById:(NSInteger *)picture_id width:(NSInteger *)width height:(NSInteger *)height blur:(NSInteger *)blur;
/*
 login facebook token
 fb_token : facebook token
 ios_device_token : device token Notify
 */
- (void)loginWithFacebookToken:(NSString *)fb_token ios_device_token:(NSString *)ios_device_token;
/*
 save access token to NSUserDefaults
 */
- (void)saveAccessToken:(NSString *)access_token;
/*
 get access token from NSUserDefaults
 */
- (NSString *)getAccessToken;
/*
 get contact by app key
 */
- (void)getContactByAppKey:(NSInteger *)app_key;
/*
 get user profile me
 */
- (void)me;
/*
 save user id to NSUserDefaults
 */
- (void)saveUserId:(NSString *)user_id;
/*
 get user id from NSUserDefaults
 */
- (NSString *)getUserId;
/*
 get user profile by id
 */
- (void)getUserById:(NSInteger )user_id;
/*
 login with username password
 */
- (void)loginWithPassword:(NSString *)username password:(NSString *)password;
/*
 update user profile
 birth_date : Date for mat (Y-m-d) example: 1990-01-20
 gender : String(male, female)
 picture : (Base64 image string)
 */
- (void)userUpdate:(NSString *)display_name birth_date:(NSString *)birth_date gender:(NSString *)gender mobile_phone:(NSString *)mobile_phone website:(NSString *)website ;























@end
