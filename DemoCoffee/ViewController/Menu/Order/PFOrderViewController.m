//
//  PFOrderViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/23/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFOrderViewController.h"

@interface PFOrderViewController ()

@end

@implementation PFOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Order";
    
    CALayer *popup = [self.popupwaitView layer];
    [popup setMasksToBounds:YES];
    [popup setCornerRadius:7.0f];
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    self.token = [self.Demoapi getAccessToken];
    self.user_id = [self.Demoapi getUserId];
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@%@%@%@%@",@"http://app.pla2.com/webview/preorder/page2.php?product_id=",self.product_id,@"&user=",self.user_id,@"&domain=coffee&token=",self.token];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:req];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.view addSubview:self.waitView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.waitView removeFromSuperview];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

@end
