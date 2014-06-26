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
 Protocal Delegate get branch gallery by id
*/
- (void)DCManager:(id)sender getBranchByIdResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getBranchByIdErrorResponse:(NSString *)errorResponse;
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
/*
 Protocal Delegate get news from server by app key
 */
- (void)DCManager:(id)sender getNewsByAppKeyResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getNewsByAppKeyErrorResponse:(NSString *)errorResponse;
/*
 Protocal Delegate get news by id
 */
- (void)DCManager:(id)sender getNewsByIdResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getNewsByIdErrorResponse:(NSString *)errorResponse;
/*
  Protocal Delegate get comment by obj id
 */
- (void)DCManager:(id)sender getCommentObjIdResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getCommentObjIdErrorResponse:(NSString *)errorResponse;
/*
 Protocal Delegate comment obj id
 */
- (void)DCManager:(id)sender commentObjIdResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender commentObjIdErrorResponse:(NSString *)errorResponse;

#pragma mark - Product Folder Protocal Delegate
- (void)DCManager:(id)sender getFolderListResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getFolderListErrorResponse:(NSString *)errorResponse;
- (void)DCManager:(id)sender getFolderByIdResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getFolderByIdErrorResponse:(NSString *)errorResponse;
- (void)DCManager:(id)sender getProductListByParentIdResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getProductListByParentIdErrorResponse:(NSString *)errorResponse;
- (void)DCManager:(id)sender getProductIdResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getProductIdErrorResponse:(NSString *)errorResponse;

- (void)DCManager:(id)sender getDrinkListResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getDrinkListErrorResponse:(NSString *)errorResponse;
- (void)DCManager:(id)sender getDessertListResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getDessertListErrorResponse:(NSString *)errorResponse;
- (void)DCManager:(id)sender getDrinkListByAppKeyResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getDrinkListByAppKeyErrorResponse:(NSString *)errorResponse;
- (void)DCManager:(id)sender getDessertListByAppKeyResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getDessertListByAppKeyErrorResponse:(NSString *)errorResponse;

#pragma mark - Stamp Protocal Delegate
- (void)DCManager:(id)sender getStampStyleResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getStampStyleErrorResponse:(NSString *)errorResponse;
- (void)DCManager:(id)sender getStampResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getStampErrorResponse:(NSString *)errorResponse;
- (void)DCManager:(id)sender getRewardResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getRewardErrorResponse:(NSString *)errorResponse;
- (void)DCManager:(id)sender addPointResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender addPointErrorResponse:(NSString *)errorResponse;

#pragma mark - user
- (void)DCManager:(id)sender getUserSettingResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender getUserSettingErrorResponse:(NSString *)errorResponse;
- (void)DCManager:(id)sender registerWithUsernameResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender registerWithUsernameErrorResponse:(NSString *)errorResponse;
- (void)DCManager:(id)sender userPictureUploadResponse:(NSDictionary *)response;
- (void)DCManager:(id)sender userPictureUploadErrorResponse:(NSString *)errorResponse;

@end

@interface DCManager : NSObject

#pragma mark - Property
@property PFHelper *hp;
@property AFHTTPRequestOperationManager *manager;
@property NSUserDefaults *userDefaults;
@property (assign, nonatomic) id delegate;
@property NSString *urlStr;


#pragma mark - function
- (BOOL)checkLogin;
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
 get contact branch by id
*/
- (void)getBranchById:(NSString *)branch_id;
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
/*
 get news from server by app key
 */
- (void)getNewsByAppKey:(NSString *)limit next:(NSString *)next app_key:(NSString *)app_key;
/*
 get news by id
 */
- (void)getNewsById:(NSString *)news_id;
/*
 get comment by obj id
 */
- (void)getCommentObjId:(NSString *)obj_id padding:(NSString *)padding;
/*
 comment obj id
 */
- (void)commentObjId:(NSString *)obj_id content:(NSString *)content;

//menu
- (void)getFolderList:(NSString *)limit padding:(NSString *)padding;
- (void)getFolderById:(NSString *)folder_id;
- (void)getProductListByParentId:(NSString *)limit parent_id:(NSString *)parent_id;
- (void)getProductId:(NSString *)product_id;
- (void)getDrinkList;
- (void)getDessertList;
- (void)getDrinkListByAppKey:(NSString *)app_key;
- (void)getDessertListByAppKey:(NSString *)app_key;

//reward
- (void)getStampStyle;
- (void)getStamp;
- (void)getReward;
- (void)addPoint:(NSString *)point password:(NSString *)password;
- (void)getLink:(NSString *)link;

#pragma mark - user
- (void)getUserSetting;
- (void)registerWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email birth_date:(NSString *)birth_date gender:(NSString *)gender picture:(NSString *)picture;
- (void)userPictureUpload:(NSString *)picture_base64;






@end
