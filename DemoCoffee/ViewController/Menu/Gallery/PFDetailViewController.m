//
//  PFDetailViewController.m
//  MingMitr
//
//  Created by Pariwat on 6/11/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFDetailViewController.h"

@interface PFDetailViewController ()

@end

@implementation PFDetailViewController

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
    
    self.navigationItem.title = self.titlename;
    
    [self.view addSubview:self.waitView];
    
    CALayer *popup = [self.popupwaitView layer];
    [popup setMasksToBounds:YES];
    [popup setCornerRadius:7.0f];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_share"] style:UIBarButtonItemStyleDone target:self action:@selector(shareupdatedetail)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    self.arrObj = [[NSMutableArray alloc] init];
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    NSString *productid = [NSString stringWithFormat:@"pictures?product_id=%@",self.product_id];
    [self.Demoapi getProductId:productid];
    
    
    self.name.text = [self.objdetail objectForKey:@"name"];
    
    if ([self.parent_id isEqualToString:@"20"]) {
        self.price.hidden = YES;
        self.baht.hidden = YES;
    } else {
        self.price.text = [NSString stringWithFormat:@"%@",[self.objdetail objectForKey:@"price"]];
    }
    
    //nproduct detail
    
    self.productdetail.text = [self.objdetail objectForKey:@"description"];
    CGRect frame = self.productdetail.frame;
    frame.size = [self.productdetail sizeOfMultiLineLabel];
    [self.productdetail sizeOfMultiLineLabel];
    
    [self.productdetail setFrame:frame];
    int lines = self.productdetail.frame.size.height/15;
    self.productdetail.numberOfLines = lines;
    
    UILabel *descText = [[UILabel alloc] initWithFrame:frame];
    descText.text = self.productdetail.text;
    descText.numberOfLines = lines;
    [descText setFont:[UIFont systemFontOfSize:15]];
    self.productdetail.alpha = 0;
    [self.detailView addSubview:descText];
    
    self.detailView.frame = CGRectMake(self.detailView.frame.origin.x, self.detailView.frame.origin.y, self.detailView.frame.size.width, self.productdetail.frame.size.height + self.productdetail.frame.origin.y+10);
    
    self.tableView.tableHeaderView = self.detailView;
    self.tableView.tableFooterView = self.footerView;
    
    CALayer *orderButton = [self.orderButton layer];
    [orderButton setMasksToBounds:YES];
    [orderButton setCornerRadius:7.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)shareupdatedetail {
    
    [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                message:@"Share coming soon."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
    
//    NSString *urlString = [[NSString alloc]init];
//    urlString = [[NSString alloc] initWithFormat:@"http://pla2app.com/mingmitr/webview/share/product.php?id=%@",self.product_id];
//    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
//        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//        [controller addURL:[NSURL URLWithString:urlString]];
//        [self presentViewController:controller animated:YES completion:Nil];
//    } else {
//        [[[UIAlertView alloc] initWithTitle:@"Mingmitr"
//                                    message:@"Please login facebook on Settings."
//                                   delegate:nil
//                          cancelButtonTitle:@"OK"
//                          otherButtonTitles:nil] show];
//    }
    
}

- (void)DCManager:(id)sender getProductIdResponse:(NSDictionary *)response {
    self.obj = response;
    NSLog(@"%@",response);
    
    [self.waitView removeFromSuperview];
    
    if ([[response objectForKey:@"length"] intValue] == 0) {
        
        
    } else {
        
        self.link = [[[[response objectForKey:@"data"] objectAtIndex:0] objectForKey:@"picture"] objectForKey:@"link"];
        
        NSString *thumbid = [[[response objectForKey:@"data"] objectForKey:@"picture"] objectForKey:@"id"];
        NSString *urlimg = [[NSString alloc] initWithFormat:@"%@%@%@",@"http://coffee-api.pla2app.com/picture/",thumbid,@"?width=800&height=600"];
        self.image.imageURL = [[NSURL alloc] initWithString:urlimg];
        
        self.image.layer.masksToBounds = YES;
        self.image.contentMode = UIViewContentModeScaleAspectFill;
    }
    
}

- (void)DCManager:(id)sender getProductIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (IBAction)fullimgTapped:(id)sender {
    [self.delegate PFDetailViewController:self viewPicture:self.link];
}

- (IBAction)orderTapped:(id)sender {
    
    PFOrderViewController *order =[[PFOrderViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        order =[[PFOrderViewController alloc] initWithNibName:@"PFOrderViewController_Wide" bundle:nil];
    } else {
        order =[[PFOrderViewController alloc] initWithNibName:@"PFOrderViewController" bundle:nil];
    }
    [self.navigationController pushViewController:order animated:YES];

}

@end
