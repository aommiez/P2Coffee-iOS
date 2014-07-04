//
//  PFContactViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/13/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFContactViewController.h"
#import "PagedImageScrollView.h"

#define FONT_SIZE 15.0f

@interface PFContactViewController ()

@end

@implementation PFContactViewController

BOOL loadContact;
BOOL noDataContact;
BOOL refreshDataContact;

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
    
    [self.view addSubview:self.waitView];
    
    CALayer *popup = [self.popupwaitView layer];
    [popup setMasksToBounds:YES];
    [popup setCornerRadius:7.0f];
    
    // Navbar setup
    [[self.navController navigationBar] setBarTintColor:[UIColor colorWithRed:247.0f/255.0f green:148.0f/255.0f blue:30.0f/255.0f alpha:1.0f]];
    
    [[self.navController navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                 [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
    
    [[self.navController navigationBar] setTranslucent:YES];
    [self.view addSubview:self.navController.view];
    
    //map
    CALayer *mapimg = [self.mapImage layer];
    [mapimg setMasksToBounds:YES];
    [mapimg setCornerRadius:7.0f];
    
    CALayer *mapview = [self.mapView layer];
    [mapview setMasksToBounds:YES];
    [mapview setCornerRadius:7.0f];
    
    loadContact = NO;
    noDataContact = NO;
    refreshDataContact = NO;
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    self.arrObj = [[NSMutableArray alloc] init];
    
    [self.Demoapi getContactByAppKey:@""];
    
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
    int sum;
    sum = [self.current intValue]/32;
    NSString *num = [NSString stringWithFormat:@"%d",sum];
    [self.delegate PFGalleryViewController:self sum:self.arrcontactimg current:num];
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
    NSLog(@"contact %@",response);
    
    [self.waitView removeFromSuperview];
    
    //image
    self.arrcontactimg = [[NSMutableArray alloc] init];
    for (int i=0; i<[[response objectForKey:@"pictures"] count]; ++i) {
        [self.arrcontactimg addObject:[[[[response objectForKey:@"pictures"] objectAtIndex:i] objectForKey:@"picture"] objectForKey:@"link"]];
    }
    
    PagedImageScrollView *pageScrollView = [[PagedImageScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    pageScrollView.delegate = self;
    [pageScrollView setScrollViewContents:[self imageToArray:response]];
    pageScrollView.pageControlPos = PageControlPositionCenterBottom;
    [self.imgscrollview addSubview:pageScrollView];
    
    //Content Label
    self.content.text = [self.obj objectForKey:@"content"];
    CGRect frame = self.content.frame;
    frame.size = [self.content sizeOfMultiLineLabel];
    [self.content sizeOfMultiLineLabel];
    [self.content setFrame:frame];
    int lines = self.content.frame.size.height/15;
    
    if (lines > 3) {
        self.content.numberOfLines = 3;
        UILabel *descText = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 8.0f, 300.0f, 63.0f)];
        descText.text = self.content.text;
        descText.numberOfLines = 3;
        [descText setFont:[UIFont systemFontOfSize:15]];
        descText.textColor = [UIColor colorWithRed:104.0/255.0 green:71.0/255.0 blue:56.0/255.0 alpha:1.0];
        self.content.alpha = 0;
        [self.contentView addSubview:descText];
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, 80);
        
    } else {
        self.content.numberOfLines = lines;
        UILabel *descText = [[UILabel alloc] initWithFrame:frame];
        descText.text = self.content.text;
        descText.numberOfLines = lines;
        [descText setFont:[UIFont systemFontOfSize:15]];
                descText.textColor = [UIColor colorWithRed:104.0/255.0 green:71.0/255.0 blue:56.0/255.0 alpha:1.0];
        self.content.alpha = 0;
        [self.contentView addSubview:descText];
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, descText.frame.size.height+18);
    }
    
    //
    
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
    
    if (!refreshDataContact) {
        for (int i=0; i<[[response objectForKey:@"locations"] count]; ++i) {
            [self.arrObj addObject:[[response objectForKey:@"locations"] objectAtIndex:i]];
        }
    } else {
        [self.arrObj removeAllObjects];
        for (int i=0; i<[[response objectForKey:@"locations"] count]; ++i) {
            [self.arrObj addObject:[[response objectForKey:@"locations"] objectAtIndex:i]];
        }
    }
    
    [self reloadData:YES];
    
    //map image
    
    self.mapView.frame = CGRectMake(self.mapView.frame.origin.x, self.contentView.frame.origin.y+self.contentView.frame.size.height+10, self.mapView.frame.size.width, self.mapView.frame.size.height);
    
    //location
    
    self.location.text = [response objectForKey:@"location_info"];
    
    //hederview
    
    self.headerView.frame = CGRectMake(self.headerView.frame.origin.x, self.headerView.frame.origin.y, self.headerView.frame.size.width, self.headerView.frame.size.height+self.contentView.frame.size.height-37);
    
    //footer
    
    self.phone.text = [response objectForKey:@"phone"];
    self.website.text = [response objectForKey:@"website"];
    self.email.text = [response objectForKey:@"email"];
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
}

- (void)DCManager:(id)sender getContactByAppKeyErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrObj count];
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
    
    if (indexPath.row == 0) {
        cell.bgimg.image = [UIImage imageNamed:@"chapter_branch_01.png"];
    } else if (indexPath.row == [self.arrObj count]-1) {
        cell.bgimg.image = [UIImage imageNamed:@"chapter_branch_03.png"];
    } else {
        cell.bgimg.image = [UIImage imageNamed:@"chapter_branch_02.png"];
    }
    
    NSString *img = [[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"thumb"] objectForKey:@"link"];
    NSString *urlimg = [[NSString alloc] initWithFormat:@"%@%@",img,@"?width=100&height=100"];
    cell.imgbranch.imageURL = [[NSURL alloc] initWithString:urlimg];
    cell.branch.text = [[NSString alloc] initWithString:[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"name"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate HideTabbar];
    
    if ([[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"picture_length"] intValue] <= 1) {
        
        PFBranch1ViewController *branch1 = [[PFBranch1ViewController alloc] init];
        
        if(IS_WIDESCREEN){
            branch1 = [[PFBranch1ViewController alloc] initWithNibName:@"PFBranch1ViewController_Wide" bundle:nil];
        } else {
            branch1 = [[PFBranch1ViewController alloc] initWithNibName:@"PFBranch1ViewController" bundle:nil];
        }
        branch1.objContact = [self.arrObj objectAtIndex:indexPath.row];
        branch1.delegate = self;
        [self.navController pushViewController:branch1 animated:YES];
    
    } else {
        
        PFBranchViewController *branch = [[PFBranchViewController alloc] init];
        
        if(IS_WIDESCREEN){
            branch = [[PFBranchViewController alloc] initWithNibName:@"PFBranchViewController_Wide" bundle:nil];
        } else {
            branch = [[PFBranchViewController alloc] initWithNibName:@"PFBranchViewController" bundle:nil];
        }
        branch.objContact = [self.arrObj objectAtIndex:indexPath.row];
        branch.delegate = self;
        [self.navController pushViewController:branch animated:YES];

    }

}

- (void)reloadData:(BOOL)animated
{
    [self.tableView reloadData];
    if (!noDataContact){
        self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width,self.tableView.contentSize.height);
    } else {
        self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width,self.tableView.contentSize.height);
    }
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
    NSString *phone = [[NSString alloc] initWithFormat:@"telprompt://%@",[self.obj objectForKey:@"phone"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
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

- (void)PFImageViewController:(id)sender viewPicture:(NSString *)link{
    [self.delegate PFImageViewController:self viewPicture:link];
}

- (void)PFGalleryViewController:(id)sender sum:(NSMutableArray *)sum current:(NSString *)current{
    [self.delegate PFGalleryViewController:self sum:sum current:current];
}

- (void)PFBranchViewControllerBack {
    [self.delegate ShowTabbar];
}

- (void)PFBranch1ViewControllerBack {
    [self.delegate ShowTabbar];
}

- (void) PFMapAllViewControllerBack {
    [self.delegate ShowTabbar];
}

- (void) PFWebViewControllerBack {
    [self.delegate ShowTabbar];
}

@end
