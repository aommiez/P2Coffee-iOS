//
//  PFOrderViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/23/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCManager.h"

@interface PFOrderViewController : UIViewController

@property (strong, nonatomic) DCManager *Demoapi;
@property (strong, nonatomic) IBOutlet UIView *waitView;
@property (strong, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) NSDictionary *objStamp;

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *product_id;

@end
