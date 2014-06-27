//
//  PFRewardViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/17/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCManager.h"

@protocol PFRewardViewControllerDelegate <NSObject>

- (void) PFRewardViewControllerBack;

@end

@interface PFRewardViewController : UIViewController

@property (strong, nonatomic) DCManager *Demoapi;
@property (assign, nonatomic) id <PFRewardViewControllerDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIView *waitView;
@property (retain, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) NSDictionary *objStamp;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *reward_id;

@end
