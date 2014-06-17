//
//  PFWebViewController.h
//  P2Coffee
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
@property (retain, nonatomic) IBOutlet UIView *waitView;
@property (retain, nonatomic) IBOutlet UIView *popupwaitView;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property NSString *url;

@end
