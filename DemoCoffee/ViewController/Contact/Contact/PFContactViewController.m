//
//  PFContactViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/13/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFContactViewController.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
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
    
    webView.url = @"http://www.google.com";
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
        //NSArray *toRecipents = [NSArray arrayWithObject:[self.obj objectForKey:@"email"]];
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:247.0f/255.0f green:148.0f/255.0f blue:30.0f/255.0f alpha:1.0f]];
        
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        
        [mc.navigationBar setTintColor:[UIColor whiteColor]];
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        //[mc setToRecipients:toRecipents];
        
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
