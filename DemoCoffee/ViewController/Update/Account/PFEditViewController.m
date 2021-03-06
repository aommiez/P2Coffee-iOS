//
//  PFEditViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/30/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFEditViewController.h"

@interface PFEditViewController ()

@end

@implementation PFEditViewController

BOOL newMedia;

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
    
    self.navItem.title = @"";
    
    // Navbar setup
    [[self.navController navigationBar] setBarTintColor:[UIColor colorWithRed:247.0f/255.0f green:148.0f/255.0f blue:30.0f/255.0f alpha:1.0f]];
    
    [[self.navController navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                 [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
    
    [[self.navController navigationBar] setTranslucent:YES];
    [self.view addSubview:self.navController.view];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIFont fontWithName:@"Helvetica" size:17.0],NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    self.navItem.rightBarButtonItem = rightButton;
    
    self.tableView.tableHeaderView = self.headerView;
    
    self.bgprofileView.layer.shadowOffset = CGSizeMake(0.5, -0.5);
    self.bgprofileView.layer.shadowRadius = 2;
    self.bgprofileView.layer.shadowOpacity = 0.1;
    
    self.displaynameView.layer.shadowOffset = CGSizeMake(0.5, -0.5);
    self.displaynameView.layer.shadowRadius = 2;
    self.displaynameView.layer.shadowOpacity = 0.1;
    
    self.passwordView.layer.shadowOffset = CGSizeMake(0.5, -0.5);
    self.passwordView.layer.shadowRadius = 2;
    self.passwordView.layer.shadowOpacity = 0.1;
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    self.objEdit = [[NSDictionary alloc] init];
    
    [self.Demoapi me];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)close {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)DCManager:(id)sender meResponse:(NSDictionary *)response {
    self.objEdit = response;
    NSLog(@"Me %@",response);
    
    [self.waitView removeFromSuperview];
    
    self.display_name.text = [response objectForKey:@"display_name"];
    
    NSString *picStr = [[response objectForKey:@"picture"] objectForKey:@"link"];
    self.thumUser.layer.masksToBounds = YES;
    self.thumUser.contentMode = UIViewContentModeScaleAspectFill;
    self.thumUser.imageURL = [[NSURL alloc] initWithString:picStr];
    
    self.email.text = [response objectForKey:@"email"];
    self.website.text = [response objectForKey:@"website"];
    self.tel.text = [response objectForKey:@"mobile_phone"];
    self.gender.text = [response objectForKey:@"gender"];
    
    NSString *myString = [[response objectForKey:@"birth_date"] objectForKey:@"date"];
    NSString *mySmallerString = [myString substringToIndex:10];
    
    self.birthday.text = mySmallerString;
    
    if (![[response objectForKey:@"facebook_id"] isEqualToString:@""]) {
        self.password.hidden = YES;
    }
}

- (void)DCManager:(id)sender meErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)DCManager:(id)sender getUserSettingResponse:(NSDictionary *)response {
    NSLog(@"settingUser %@",response);
}

- (void)DCManager:(id)sender getUserSettingErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (IBAction)displaynameTapped:(id)sender{
    PFEditDetailViewController *editdetail = [[PFEditDetailViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController_Wide" bundle:nil];
    } else {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController" bundle:nil];
    }
    editdetail.delegate = self;
    editdetail.obj = self.objEdit;
    editdetail.checkstatus = @"displayname";
    [self.navController pushViewController:editdetail animated:YES];
}

- (IBAction)passwordTapped:(id)sender {
    if ([[self.objEdit objectForKey:@"facebook_id"] isEqualToString:@""]) {
        PFEditDetailViewController *editdetail = [[PFEditDetailViewController alloc] init];
    
        if(IS_WIDESCREEN) {
            editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController_Wide" bundle:nil];
        } else {
            editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController" bundle:nil];
        }
        editdetail.delegate = self;
        editdetail.obj = self.objEdit;
        editdetail.checkstatus = @"password";
        [self.navController pushViewController:editdetail animated:YES];
    }
}

- (IBAction)emailTapped:(id)sender {
    PFEditDetailViewController *editdetail = [[PFEditDetailViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController_Wide" bundle:nil];
    } else {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController" bundle:nil];
    }
    editdetail.delegate = self;
    editdetail.obj = self.objEdit;
    editdetail.checkstatus = @"email";
    [self.navController pushViewController:editdetail animated:YES];
}

- (IBAction)websiteTapped:(id)sender {
    PFEditDetailViewController *editdetail = [[PFEditDetailViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController_Wide" bundle:nil];
    } else {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController" bundle:nil];
    }
    editdetail.delegate = self;
    editdetail.obj = self.objEdit;
    editdetail.checkstatus = @"website";
    [self.navController pushViewController:editdetail animated:YES];
}

- (IBAction)telTapped:(id)sender {
    PFEditDetailViewController *editdetail = [[PFEditDetailViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController_Wide" bundle:nil];
    } else {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController" bundle:nil];
    }
    editdetail.delegate = self;
    editdetail.obj = self.objEdit;
    editdetail.checkstatus = @"phone";
    [self.navController pushViewController:editdetail animated:YES];
}

- (IBAction)genderTapped:(id)sender {
    PFEditDetailViewController *editdetail = [[PFEditDetailViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController_Wide" bundle:nil];
    } else {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController" bundle:nil];
    }
    editdetail.delegate = self;
    editdetail.obj = self.objEdit;
    editdetail.checkstatus = @"gender";
    [self.navController pushViewController:editdetail animated:YES];
}

- (IBAction)birthdayTapped:(id)sender {
    PFEditDetailViewController *editdetail = [[PFEditDetailViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController_Wide" bundle:nil];
    } else {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController" bundle:nil];
    }
    editdetail.delegate = self;
    editdetail.obj = self.objEdit;
    editdetail.checkstatus = @"birthday";
    [self.navController pushViewController:editdetail animated:YES];
}

- (void) PFEditDetailViewControllerBack {
    [self viewDidLoad];
}

- (IBAction)uploadPictureTapped:(id)sender {
    [self alertUpload];
}

- (void)alertUpload {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Select Profile Picture"
                                  delegate:self
                                  cancelButtonTitle:@"cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Camera", @"Camera Roll", nil];
    [actionSheet showInView:[[[[UIApplication sharedApplication] keyWindow] subviews] lastObject]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ( buttonIndex == 0 ) {
        [self useCamera];
    } else if ( buttonIndex == 1 ) {
        [self useCameraRoll];
        
    }
}

- (void) useCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:   UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =   [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
        imagePicker.allowsEditing = YES;
        imagePicker.editing = YES;
        imagePicker.navigationBarHidden = YES;
        imagePicker.view.userInteractionEnabled = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        newMedia = YES;
    }
}

- (void) useCameraRoll
{
    [self.view addSubview:self.waitView];
    
    CALayer *popup = [self.popupwaitView layer];
    [popup setMasksToBounds:YES];
    [popup setCornerRadius:7.0f];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:247.0f/255.0f green:148.0f/255.0f blue:30.0f/255.0f alpha:1.0f]];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =   [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =   UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
        imagePicker.allowsEditing = YES;
        imagePicker.editing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        newMedia = NO;
    }
}

- (NSString*)base64forData:(NSData*)theData {
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *base64String = [self base64forData:imageData];
    [self.Demoapi userPictureUpload:base64String];

    [picker dismissViewControllerAnimated:YES completion:^{
        self.thumUser.image = image;
        
        SDImageCache *imageCache = [SDImageCache sharedImageCache];
        [imageCache clearMemory];
        [imageCache clearDisk];
        [imageCache cleanDisk];
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.waitView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    double ratio;
    double delta;
    CGPoint offset;
    
    //make a new square size, that is the resized imaged width
    CGSize sz = CGSizeMake(newSize.width, newSize.width);
    
    //figure out if the picture is landscape or portrait, then
    //calculate scale factor and offset
    if (image.size.width > image.size.height) {
        ratio = newSize.width / image.size.width;
        delta = (ratio*image.size.width - ratio*image.size.height);
        offset = CGPointMake(delta/2, 0);
    } else {
        ratio = newSize.width / image.size.height;
        delta = (ratio*image.size.height - ratio*image.size.width);
        offset = CGPointMake(0, delta/2);
    }
    
    //make the final clipping rect based on the calculated values
    CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                 (ratio * image.size.width) + delta,
                                 (ratio * image.size.height) + delta);
    
    
    //start a new context, with scale factor 0.0 so retina displays get
    //high quality image
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(sz, YES, 0.0);
    } else {
        UIGraphicsBeginImageContext(sz);
    }
    UIRectClip(clipRect);
    [image drawInRect:clipRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] != NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFEditViewControllerBack)]){
            [self.delegate PFEditViewControllerBack];
        }
    }
    
}

@end
