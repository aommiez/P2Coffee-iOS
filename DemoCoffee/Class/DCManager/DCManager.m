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
- (void)removeAppKey {
    [self.userDefaults removeObjectForKey:@"app_key"];
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
    self.urlStr = [[NSString alloc] initWithFormat:@"%@contact?app_key=%ld",API_URL,(unsigned long)app_key];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate DCManager:self getContactByAppKeyResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self getContactByAppKeyErrorResponse:[error localizedDescription]];
    }];
}

- (void)getBranchById:(NSString *)branch_id {
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@location/pictures?location_id=%@",API_URL,branch_id];
    [self.manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate DCManager:self getBranchByIdResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self getBranchByIdErrorResponse:[error localizedDescription]];
    }];
}

- (void)me {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@me?access_token=%@",API_URL,[self getAccessToken]];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate DCManager:self meResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self meErrorResponse:[error localizedDescription]];
    }];
}


- (void)saveUserId:(NSString *)user_id {
    [self.userDefaults setObject:user_id forKey:@"user_id"];
}

- (NSString *)getUserId {
    return [self.userDefaults objectForKey:@"user_id"];
}

- (void)getUserById:(NSInteger )user_id {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@user/%ld",API_URL,(unsigned long)user_id];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate DCManager:self getUserByIdResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self getUserByIdErrorResponse:[error localizedDescription]];
    }];
}

- (void)loginWithPassword:(NSString *)username password:(NSString *)password {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@oauth/password?username=%@&password=%@",API_URL,username,password];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate DCManager:self loginWithPasswordResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self loginWithPasswordErrorResponse:[error localizedDescription]];
    }];
}

- (void)userUpdate:(NSString *)display_name birth_date:(NSString *)birth_date gender:(NSString *)gender mobile_phone:(NSString *)mobile_phone website:(NSString *)website  {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@user/update/%@?display_name=%@&birth_date=%@&gender=%@&mobile_phone=%@&website=%@&access_token=%@",API_URL,[self getUserId],display_name,birth_date,gender,mobile_phone,website,[self getAccessToken]];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate DCManager:self userUpdateResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self userUpdateErrorResponse:[error localizedDescription]];
    }];
    
}

- (void)getNewsByAppKey:(NSString *)limit next:(NSString *)next app_key:(NSString *)app_key{
    if (![limit isEqualToString:@"NO"]) {
        self.urlStr = [[NSString alloc] initWithFormat:@"%@news?app_key=%@&limit=%@",API_URL,[self getAppKey],limit];
    } else if (![next isEqualToString:@"NO"]) {
        self.urlStr = [[NSString alloc] initWithFormat:@"%@",next];
    } else {
        self.urlStr = [[NSString alloc] initWithFormat:@"%@news?app_key=%@",API_URL,[self getAppKey]];
    }
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate DCManager:self getNewsByAppKeyResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self getNewsByAppKeyErrorResponse:[error localizedDescription]];
    }];
}
- (void)getNewsById:(NSString *)news_id {
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@news/%@",API_URL,news_id];
    [self.manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate DCManager:self getNewsByIdResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self getNewsByIdErrorResponse:[error localizedDescription]];
    }];
}
- (void)getCommentObjId:(NSString *)obj_id padding:(NSString *)padding{
    NSString *urlStr = [[NSString alloc] init];
    if ([padding isEqualToString:@"NO"]) {
        urlStr = [[NSString alloc] initWithFormat:@"%@news/comment?object_id=%@&order_type=asc&limit=5",API_URL,obj_id];
    } else {
        urlStr = [[NSString alloc] initWithFormat:@"%@",padding];
    }
    
    [self.manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate DCManager:self getCommentObjIdResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self getCommentObjIdErrorResponse:[error localizedDescription]];
    }];
}
- (void)commentObjId:(NSString *)obj_id content:(NSString *)content {
    NSDictionary *parameters = @{@"object_id":obj_id , @"content":content  , @"access_token":[self getAccessToken]};
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@news/comment/create",API_URL];
    [self.manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate DCManager:self commentObjIdResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self commentObjIdErrorResponse:[error localizedDescription]];
    }];
}

#pragma mark - Stamp
- (void)getStamp {
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@reward",API_URL];
    [self.manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate DCManager:self getStampResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self getStampErrorResponse:[error localizedDescription]];
    }];
}

- (void)getStampStyle {
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@stamp/style",API_URL];
    [self.manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate DCManager:self getStampStyleResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate DCManager:self getStampStyleErrorResponse:[error localizedDescription]];
    }];
}








@end
