//
//  PFEditAccountViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFEditAccountViewController.h"

@interface PFEditAccountViewController ()

@end

@implementation PFEditAccountViewController

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
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(SaveProfile)];
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:@"Helvetica" size:17.0],NSFontAttributeName,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.scrollView.contentSize = CGSizeMake(self.formView.frame.size.width, self.formView.frame.size.height+20);
    self.formView.frame = CGRectMake(0, 0, self.formView.frame.size.width,self.formView.frame.size.height);
    [self.scrollView addSubview:self.formView];
    
    CALayer *saveButton = [self.saveButton layer];
    [saveButton setMasksToBounds:YES];
    [saveButton setCornerRadius:5.0f];
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    self.display_name.text = [self.objAccount objectForKey:@"display_name"];
    
    NSString *picStr = [[self.objAccount objectForKey:@"picture"] objectForKey:@"link"];
    self.thumUser.layer.masksToBounds = YES;
    self.thumUser.contentMode = UIViewContentModeScaleAspectFill;
    self.thumUser.imageURL = [[NSURL alloc] initWithString:picStr];
    
    self.facebook.text = [self.objAccount objectForKey:@"display_name"];
    self.email.text = [self.objAccount objectForKey:@"email"];
    self.website.text = [self.objAccount objectForKey:@"website"];
    self.tel.text = [self.objAccount objectForKey:@"mobile_phone"];
    self.gender.text = [self.objAccount objectForKey:@"gender"];
    self.birthday.text = [[self.objAccount objectForKey:@"birth_date"] objectForKey:@"date"];
    
    if ([[self.objUsersetting objectForKey:@"show_facebook"] intValue] == 1) {
        [self.facebook_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.facebook_bt setTintColor:RGB(0, 174, 239)];
        self.facebookSetting = @"1";
    } else {
        [self.facebook_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.facebook_bt setTintColor:RGB(167, 169, 172)];
        self.facebookSetting = @"0";
    }
    if ([[self.objUsersetting objectForKey:@"show_email"] intValue] == 1) {
        [self.email_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.email_bt setTintColor:RGB(0, 174, 239)];
            self.emailSetting = @"1";
    } else {
        [self.email_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.email_bt setTintColor:RGB(167, 169, 172)];
        self.emailSetting = @"0";
    }
    if ([[self.objUsersetting objectForKey:@"show_website"] intValue] == 1) {
        [self.website_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.website_bt setTintColor:RGB(0, 174, 239)];
        self.websiteSetting = @"1";
    } else {
        [self.website_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.website_bt setTintColor:RGB(167, 169, 172)];
        self.websiteSetting = @"0";
    }
    if ([[self.objUsersetting objectForKey:@"show_mobile"] intValue] == 1) {
        [self.tel_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.tel_bt setTintColor:RGB(0, 174, 239)];
        self.telSetting = @"1";
    } else {
        [self.tel_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.tel_bt setTintColor:RGB(167, 169, 172)];
        self.telSetting = @"0";
    }
    if ([[self.objUsersetting objectForKey:@"show_gender"] intValue] == 1) {
        [self.gender_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.gender_bt setTintColor:RGB(0, 174, 239)];
        self.genderSetting = @"1";
    } else {
        [self.gender_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.gender_bt setTintColor:RGB(167, 169, 172)];
        self.genderSetting = @"0";
    }
    if ([[self.objUsersetting objectForKey:@"show_birth_date"] intValue] == 1) {
        [self.birthday_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.birthday_bt setTintColor:RGB(0, 174, 239)];
        self.birthdaySetting = @"1";
    } else {
        [self.birthday_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.birthday_bt setTintColor:RGB(167, 169, 172)];
        self.birthdaySetting = @"0";
    }
    
    CALayer *facebook_bt = [self.facebook_bt layer];
    [facebook_bt setMasksToBounds:YES];
    [facebook_bt setCornerRadius:5.0f];
    
    CALayer *email_bt = [self.email_bt layer];
    [email_bt setMasksToBounds:YES];
    [email_bt setCornerRadius:5.0f];
    
    CALayer *website_bt = [self.website_bt layer];
    [website_bt setMasksToBounds:YES];
    [website_bt setCornerRadius:5.0f];
    
    CALayer *tel_bt = [self.tel_bt layer];
    [tel_bt setMasksToBounds:YES];
    [tel_bt setCornerRadius:5.0f];
    
    CALayer *gender_bt = [self.gender_bt layer];
    [gender_bt setMasksToBounds:YES];
    [gender_bt setCornerRadius:5.0f];
    
    CALayer *birthday_bt = [self.birthday_bt layer];
    [birthday_bt setMasksToBounds:YES];
    [birthday_bt setCornerRadius:5.0f];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)selectgenderTapped:(id)sender {
    [self hideKeyboard];
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                                      message:@"Select gender."
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Male", @"Female", nil];
    [message show];
}
- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        self.gender.text = @"Male";
    } else if (buttonIndex == 2) {
        self.gender.text = @"Female";
    }
}

- (void)SaveProfile {
    [self.Demoapi settingUser:self.facebookSetting email:self.emailSetting website:self.websiteSetting tel:self.telSetting gender:self.genderSetting birthday:self.birthdaySetting];
    
    [self.Demoapi updateSetting:self.display_name.text facebook:self.facebook.text email:self.email.text website:self.website.text tel:self.tel.text gender:self.gender.text birthday:self.birthday.text];
    
    [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                message:@"Update profile complete."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (IBAction)changepasswordTapped:(id)sender {
    [self.view addSubview:self.blurView];
    [self.changepasswordView.layer setCornerRadius:4.0f];
    self.changepasswordView.frame = CGRectMake(10, 161, self.changepasswordView.frame.size.width, self.changepasswordView.frame.size.height);
    [self.view addSubview:self.changepasswordView];
}

- (IBAction)bgTapped:(id)sender {
    [self.blurView removeFromSuperview];
    [self.changepasswordView removeFromSuperview];
}

- (IBAction)facebookTapped:(id)sender {
    if ([self.facebook_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.facebook_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.facebook_bt setTintColor:RGB(167, 169, 172)];
        self.facebookSetting = @"0";
    } else {
        [self.facebook_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.facebook_bt setTintColor:RGB(0, 174, 239)];
        self.facebookSetting = @"1";
    }
}

- (IBAction)emailTapped:(id)sender {
    if ([self.email_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.email_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.email_bt setTintColor:RGB(167, 169, 172)];
        self.emailSetting = @"0";
    } else {
        [self.email_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.email_bt setTintColor:RGB(0, 174, 239)];
        self.emailSetting = @"1";
    }
}

- (IBAction)websiteTapped:(id)sender {
    if ([self.website_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.website_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.website_bt setTintColor:RGB(167, 169, 172)];
        self.websiteSetting = @"0";
    } else {
        [self.website_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.website_bt setTintColor:RGB(0, 174, 239)];
        self.websiteSetting = @"1";
    }
}

- (IBAction)telTapped:(id)sender {
    if ([self.tel_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.tel_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.tel_bt setTintColor:RGB(167, 169, 172)];
        self.telSetting = @"0";
    } else {
        [self.tel_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.tel_bt setTintColor:RGB(0, 174, 239)];
        self.telSetting = @"1";
    }
}

- (IBAction)genderTapped:(id)sender {
    if ([self.gender_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.gender_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.gender_bt setTintColor:RGB(167, 169, 172)];
        self.genderSetting = @"0";
    } else {
        [self.gender_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.gender_bt setTintColor:RGB(0, 174, 239)];
        self.genderSetting = @"1";
    }
}

- (IBAction)birthdayTapped:(id)sender {
    if ([self.birthday_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.birthday_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.birthday_bt setTintColor:RGB(167, 169, 172)];
        self.birthdaySetting = @"0";
    } else {
        [self.birthday_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.birthday_bt setTintColor:RGB(0, 174, 239)];
        self.birthdaySetting = @"1";
    }
}

- (IBAction)saveTapped:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                message:@"Save password coming soon."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
    [self.blurView removeFromSuperview];
    [self.changepasswordView removeFromSuperview];
}

- (void)DCManager:(id)sender getUserSettingResponse:(NSDictionary *)response {
    NSLog(@"settingUser %@",response);
}

- (void)DCManager:(id)sender getUserSettingErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    image = [self squareImageWithImage:image scaledToSize:CGSizeMake(640, 640)];
    //NSData *imageData = UIImageJPEGRepresentation(image, 75);
    
    NSData * data = [UIImageJPEGRepresentation(image, 75) base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *strEncoded = [NSString stringWithUTF8String:[data bytes]];
    
    NSLog(@"%@",strEncoded);
    
    [self.Demoapi userPictureUpload:strEncoded];
    [picker dismissViewControllerAnimated:YES completion:^{
        self.thumUser.image = image;
        
        SDImageCache *imageCache = [SDImageCache sharedImageCache];
        [imageCache clearMemory];
        [imageCache clearDisk];
        [imageCache cleanDisk];
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
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

- (void)hideKeyboard {
    [self.display_name resignFirstResponder];
    [self.facebook resignFirstResponder];
    [self.email resignFirstResponder];
    [self.website resignFirstResponder];
    [self.tel resignFirstResponder];
    [self.gender resignFirstResponder];
    [self.birthday resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField  {
    
    [self.display_name resignFirstResponder];
    [self.facebook resignFirstResponder];
    [self.email resignFirstResponder];
    [self.website resignFirstResponder];
    [self.tel resignFirstResponder];
    [self.gender resignFirstResponder];
    [self.birthday resignFirstResponder];
    
    return YES;
}

- (void)DCManager:(id)sender userPictureUploadResponse:(NSDictionary *)response {
    NSLog(@"userPictureUpload %@",response);
}

- (void)DCManager:(id)sender userPictureUploadErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFEditAccountViewControllerBack)]){
            [self.delegate PFEditAccountViewControllerBack];
        }
    }
    
}

@end
