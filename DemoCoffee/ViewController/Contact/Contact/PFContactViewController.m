//
//  PFContactViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/13/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFContactViewController.h"
#import "PagedImageScrollView.h"

@interface PFContactViewController ()

@end

@implementation PFContactViewController

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
    
    self.navItem.title = NSLocalizedString(@"DEMO_CONTACT", nil);
    
    // Navbar setup
    [[self.navController navigationBar] setBarTintColor:[UIColor colorWithRed:247.0f/255.0f green:148.0f/255.0f blue:30.0f/255.0f alpha:1.0f]];
    
    [[self.navController navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                 [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
    
    [[self.navController navigationBar] setTranslucent:YES];
    [self.view addSubview:self.navController.view];
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    
    //map
    CALayer *mapimg = [self.mapImage layer];
    [mapimg setMasksToBounds:YES];
    [mapimg setCornerRadius:7.0f];
    
    CALayer *mapbt = [self.mapButton layer];
    [mapbt setMasksToBounds:YES];
    [mapbt setCornerRadius:7.0f];
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    [self.Demoapi getContactByAppKey:0];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self.imgscrollview addGestureRecognizer:singleTap];
    
    self.current = @"0";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)PagedImageScrollView:(id)sender current:(NSString *)current{
    self.current = current;
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
//    int sum;
//    sum = [self.current intValue]/32;
//    NSString *num = [NSString stringWithFormat:@"%d",sum];
//    [self.delegate PFGalleryViewController:self sum:self.arrcontactimg current:num];
    [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                message:@"Full image coming soon."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (NSArray *)imageToArray:(NSDictionary *)images {
    NSMutableArray *ArrImgs = [[NSMutableArray alloc] init];
    int countPicture = [[images objectForKey:@"pictures"] count];
    for (int i = 0; i < countPicture; i++) {
        
        NSString *urlStr = [[NSString alloc] initWithFormat:@"%@%@",[[[[images objectForKey:@"pictures"] objectAtIndex:i] objectForKey:@"picture"] objectForKey:@"link"],@"?width=320&height=180"];
        NSURL *url = [[NSURL alloc] initWithString:urlStr];
        
        NSData *data = [NSData dataWithContentsOfURL : url];
        UIImage *image = [UIImage imageWithData: data];
        [ArrImgs addObject:image];
    }
    return ArrImgs;
}

- (void)DCManager:(id)sender getContactByAppKeyResponse:(NSDictionary *)response {
    self.obj = response;
    NSLog(@"%@",response);
    
    self.arrcontactimg = [[NSMutableArray alloc] init];
    for (int i=0; i<[[response objectForKey:@"pictures"] count]; ++i) {
        [self.arrcontactimg addObject:[[[[response objectForKey:@"pictures"] objectAtIndex:i] objectForKey:@"picture"] objectForKey:@"link"]];
    }
    
    PagedImageScrollView *pageScrollView = [[PagedImageScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    pageScrollView.delegate = self;
    [pageScrollView setScrollViewContents:[self imageToArray:response]];
    pageScrollView.pageControlPos = PageControlPositionCenterBottom;
    [self.imgscrollview addSubview:pageScrollView];
    
    self.content.text = [response objectForKey:@"content"];
    
    NSString *urlmap1 = @"http://maps.googleapis.com/maps/api/staticmap?center=";
    
    NSMutableArray *pointmap = [[NSMutableArray alloc] initWithCapacity:[[response objectForKey:@"locations"] count]];
    for (int i=0; i < [[response objectForKey:@"locations"] count]; i++) {
        NSString *pointchar = [NSString alloc];
        if (i == [[response objectForKey:@"locations"] count]-1) {
            pointchar  = [NSString stringWithFormat:@"%@%@%@", [[[response objectForKey:@"locations"] objectAtIndex:i] objectForKey:@"lat"],@",",[[[response objectForKey:@"locations"] objectAtIndex:i] objectForKey:@"lng"]];
        } else {
            pointchar  = [NSString stringWithFormat:@"%@%@%@%@", [[[response objectForKey:@"locations"] objectAtIndex:i] objectForKey:@"lat"],@",",[[[response objectForKey:@"locations"] objectAtIndex:i] objectForKey:@"lng"],@","];
        }
        [pointmap addObject:pointchar];
    }
    
    NSMutableString * resultpoint = [[NSMutableString alloc] init];
    for (NSObject * obj in pointmap)
    {
        [resultpoint appendString:[obj description]];
    }
    
    NSString *urlmap2 = resultpoint;
    
    NSString *urlmap3 = @"&zoom=13&size=600x300&sensor=false";
    
    NSMutableArray *locationmap = [[NSMutableArray alloc] initWithCapacity:[[response objectForKey:@"locations"] count]];
    for (int i=0; i < [[response objectForKey:@"locations"] count]; i++) {
        NSString *locationchar = [NSString alloc];
        
        locationchar  = [NSString stringWithFormat:@"%@%@%@%@%@%@",@"&markers=color:0x",[[[response objectForKey:@"locations"] objectAtIndex:i] objectForKey:@"color"],@"%7C",[[[response objectForKey:@"locations"] objectAtIndex:i] objectForKey:@"lat"],@",",[[[response objectForKey:@"locations"] objectAtIndex:i] objectForKey:@"lng"]];
        
        [locationmap addObject:locationchar];
    }
    
    NSMutableString * resultlocation = [[NSMutableString alloc] init];
    for (NSObject * obj in locationmap)
    {
        [resultlocation appendString:[obj description]];
    }
    NSString *urlmap4 = resultlocation;
    
    NSString *urlmap = [NSString stringWithFormat:@"%@%@%@%@",urlmap1,urlmap2,urlmap3,urlmap4];
    
    [DLImageLoader loadImageFromURL:urlmap
                          completed:^(NSError *error, NSData *imgData) {
                              self.mapImage.image = [UIImage imageWithData:imgData];
                          }];
    
    self.location.text = [response objectForKey:@"location_info"];
    
    self.phone.text = [response objectForKey:@"phone"];
    self.website.text = [response objectForKey:@"website"];
    self.email.text = [response objectForKey:@"email"];
}

- (void)DCManager:(id)sender getContactByAppKeyErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFContactCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFContactCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate HideTabbar];
    
    PFBranchViewController *branch = [[PFBranchViewController alloc] init];
    
    if(IS_WIDESCREEN){
        branch = [[PFBranchViewController alloc] initWithNibName:@"PFBranchViewController_Wide" bundle:nil];
    } else {
        branch = [[PFBranchViewController alloc] initWithNibName:@"PFBranchViewController" bundle:nil];
    }
    branch.delegate = self;
    [self.navController pushViewController:branch animated:YES];
}

- (IBAction) mapTapped:(id)sender {
    
    [self.delegate HideTabbar];
    
    PFMapAllViewController *mapView = [[PFMapAllViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        mapView = [[PFMapAllViewController alloc] initWithNibName:@"PFMapAllViewController_Wide" bundle:nil];
    } else {
        mapView = [[PFMapAllViewController alloc] initWithNibName:@"PFMapAllViewController" bundle:nil];
    }
    
    mapView.delegate = self;
    [self.navController pushViewController:mapView animated:YES];
}

- (IBAction)callTapped:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                message:@"Contact coming soon."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (IBAction)webTapped:(id)sender {
    
    [self.delegate HideTabbar];
    
    PFWebViewController *webView = [[PFWebViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        webView = [[PFWebViewController alloc] initWithNibName:@"PFWebViewController_Wide" bundle:nil];
    } else {
        webView = [[PFWebViewController alloc] initWithNibName:@"PFWebViewController" bundle:nil];
    }
    
    webView.url = [self.obj objectForKey:@"website"];
    webView.delegate = self;
    [self.navController pushViewController:webView animated:YES];
}

- (IBAction)emailTapped:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Select Menu"
                                  delegate:self
                                  cancelButtonTitle:@"cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Send Email", nil];
    [actionSheet showInView:[[[[UIApplication sharedApplication] keyWindow] subviews] lastObject]];
    //[self.actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //Get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if  ([buttonTitle isEqualToString:@"Send Email"]) {
        [self.delegate HideTabbar];
        NSLog(@"Send Email");
        // Email Subject
        NSString *emailTitle = @"Demo Coffee";
        // Email Content
        NSString *messageBody = @"Demo Coffee!";
        // To address
        NSArray *toRecipents = [NSArray arrayWithObject:[self.obj objectForKey:@"email"]];
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:247.0f/255.0f green:148.0f/255.0f blue:30.0f/255.0f alpha:1.0f]];
        
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        
        [mc.navigationBar setTintColor:[UIColor whiteColor]];
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
        
    }
    if ([buttonTitle isEqualToString:@"Cancel"]) {
        NSLog(@"Cancel");
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //[self reloadView];
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.delegate ShowTabbar];
}

- (IBAction)powerbyTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://pla2fusion.com/"]];
}

- (void)PFBranchViewControllerBack {
    [self.delegate ShowTabbar];
}

- (void) PFMapAllViewControllerBack {
    [self.delegate ShowTabbar];
}

- (void) PFWebViewControllerBack {
    [self.delegate ShowTabbar];
}

@end
