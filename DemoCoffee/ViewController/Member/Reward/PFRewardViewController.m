//
//  PFRewardViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/17/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFRewardViewController.h"

@interface PFRewardViewController ()

@end

@implementation PFRewardViewController

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
    
    self.navigationItem.title = @"Reward";
    
    CALayer *popup = [self.popupwaitView layer];
    [popup setMasksToBounds:YES];
    [popup setCornerRadius:7.0f];
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    self.token = [self.Demoapi getAccessToken];
    self.user_id = [self.Demoapi getUserId];
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@%@%@%@%@",@"http://apps.pla2.com/webview/stamp/page2.php?id=",self.reward_id,@"&user=",self.user_id,@"&domain=coffee&token=",self.token];
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
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFRewardViewControllerBack)]){
            [self.delegate PFRewardViewControllerBack];
        }
    }
}

@end
