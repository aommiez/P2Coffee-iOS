//
//  DCManager.m
//  DemoCoffee
//
//  Created by MRG on 6/20/2557 BE.
//  Copyright (c) 2557 Platwo fusion. All rights reserved.
//

#import "DCManager.h"

@implementation DCManager


- (id) init
{
    if (self = [super init])
    {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        self.manager = [AFHTTPRequestOperationManager manager];
        self.hp = [[PFHelper alloc] init];
        self.urlStr = [[NSString alloc] init];
    }
    return self;
}

- (void)appRequest {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@app/request",API_URL];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate DCManager:self appRequestResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self appRequestErrorResponse:[error localizedDescription]];
    }];
}
- (void)saveAppKey:(NSString *)app_key {
    [self.userDefaults setObject:app_key forKey:@"app_key"];
}
- (NSString *)getAppKey {
    return [self.userDefaults objectForKey:@"app_key"];
}
- (void)getPictureById:(NSInteger *)picture_id width:(NSInteger *)width height:(NSInteger *)height blur:(NSInteger *)blur {
    
    if ( width != 0 && height != 0 ) {
        self.urlStr = [[NSString alloc] initWithFormat:@"%@picture/%lu&width=%lu&height=%lu",API_URL,(unsigned long)picture_id,(unsigned long)width,(unsigned long)height];
    } else if ( width != 0 && height == 0 ) {
        self.urlStr = [[NSString alloc] initWithFormat:@"%@picture/%lu&width=%lu",API_URL,(unsigned long)picture_id,(unsigned long)width];
    } else if (width == 0 && height != 0 ) {
        self.urlStr = [[NSString alloc] initWithFormat:@"%@picture/%lu&height=%lu",API_URL,(unsigned long)picture_id,(unsigned long)height];
    }
    
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, UIImage *image) {
        [self.delegate DCManager:self getPictureByIdResponse:image];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self getPictureByIdErrorResponse:[error localizedDescription]];
    }];

}

- (void)loginWithFacebookToken:(NSString *)fb_token ios_device_token:(NSString *)ios_device_token {
    
    self.urlStr = [[NSString alloc] initWithFormat:@"%@oauth/facebook?facebook_token=%@&ios_device_token=%@",API_URL,fb_token,ios_device_token];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate DCManager:self loginWithFacebookTokenResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self loginWithFacebookTokenErrorResponse:[error localizedDescription]];
    }];
    
}

- (void)saveAccessToken:(NSString *)access_token {
    [self.userDefaults setObject:access_token forKey:@"access_token"];
}

- (NSString *)getAccessToken {
    return [self.userDefaults objectForKey:@"access_token"];
}

- (void)getContactByAppKey:(NSInteger *)app_key {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@contact?app_key=%@",API_URL,app_key];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate DCManager:self getContactByAppKeyResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self getContactByAppKeyErrorResponse:[error localizedDescription]];
    }];
}



@end
