//
//  PFWebViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/17/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PFWebViewControllerDelegate <NSObject>

- (void) PFWebViewControllerBack;

@end

@interface PFWebViewController : UIViewController <UIWebViewDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) IBOutlet UIView *waitView;
@property (strong, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property NSString *url;

@end
