//
//  PFAccountViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFAccountViewController.h"

@interface PFAccountViewController ()

@end

@implementation PFAccountViewController

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
    
    self.navigationItem.title = @"Profile Setting";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(editProfileTapped)];
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:@"Helvetica" size:17.0],NSFontAttributeName,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    
    CALayer *logoutButton = [self.logoutButton layer];
    [logoutButton setMasksToBounds:YES];
    [logoutButton setCornerRadius:5.0f];
    
    CALayer *tutorialButton = [self.tutorialButton layer];
    [tutorialButton setMasksToBounds:YES];
    [tutorialButton setCornerRadius:5.0f];
    
    CALayer *settingView = [self.settingView layer];
    [settingView setMasksToBounds:YES];
    [settingView setCornerRadius:5.0f];
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    self.obj = [[NSDictionary alloc] init];
   
    self.rowCount = [[NSString alloc] init];
    
    [self.Demoapi me];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)DCManager:(id)sender meResponse:(NSDictionary *)response {
    self.obj = response;
    NSLog(@"Me %@",response);
    
    [self.waitView removeFromSuperview];
    
    self.display_name.text = [response objectForKey:@"display_name"];
    
    NSString *picStr = [[response objectForKey:@"picture"] objectForKey:@"link"];
    self.thumUser.layer.masksToBounds = YES;
    self.thumUser.contentMode = UIViewContentModeScaleAspectFill;
    self.thumUser.imageURL = [[NSURL alloc] initWithString:picStr];
    
    [self.Demoapi getUserSetting];
    
}

- (void)DCManager:(id)sender meErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)DCManager:(id)sender getUserSettingResponse:(NSDictionary *)response {
    self.objUsersetting = response;
    NSLog(@"getUserSetting %@",response);
    
    if ([[response objectForKey:@"show_facebook"] intValue] == 1) {
        self.facebook.text = [self.obj objectForKey:@"facebook_name"];
    } else {
        self.facebook.text = @"";
    }
    if ([[response objectForKey:@"show_email"] intValue] == 1) {
        self.email.text = [self.obj objectForKey:@"email"];
    } else {
        self.email.text = @"";
    }
    if ([[response objectForKey:@"show_website"] intValue] == 1) {
        self.website.text = [self.obj objectForKey:@"website"];
    } else {
        self.website.text = @"";
    }
    if ([[response objectForKey:@"show_mobile"] intValue] == 1) {
        self.tel.text = [self.obj objectForKey:@"mobile_phone"];
    } else {
        self.tel.text = @"";
    }
    if ([[response objectForKey:@"show_gender"] intValue] == 1) {
        self.gender.text = [self.obj objectForKey:@"gender"];
    } else {
        self.gender.text = @"";
    }
    if ([[response objectForKey:@"show_birth_date"] intValue] == 1) {
        self.birthday.text = [[self.obj objectForKey:@"birth_date"] objectForKey:@"date"];
    } else {
        self.birthday.text = @"";
    }
    
    int count = [[response objectForKey:@"show_facebook"] intValue]+[[response objectForKey:@"show_email"] intValue]+[[response objectForKey:@"show_website"] intValue]+[[response objectForKey:@"show_mobile"] intValue]+[[response objectForKey:@"show_gender"] intValue]+[[response objectForKey:@"show_birth_date"] intValue];
    self.rowCount = [NSString stringWithFormat:@"%d",count];
    [self.tableView reloadData];
    
    //switch
    
    if ([[response objectForKey:@"notify_news"] intValue] == 1) {
        self.switchNews.on = YES;
    } else {
        self.switchNews.on = NO;
    }
    
    if ([[response objectForKey:@"notify_message"] intValue] == 1) {
        self.switchMessage.on = YES;
    } else {
        self.switchMessage.on = NO;
    }
    
}

- (void)DCManager:(id)sender getUserSettingErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (IBAction)switchNewsonoff:(id)sender{
    
    if(self.switchNews.on) {
        NSLog(@"NewsOn");
        [self.Demoapi settingNews:@"1"];
    } else {
        NSLog(@"NewsOff");
        [self.Demoapi settingNews:@"0"];
    }
    
}

- (IBAction)switchMessageonoff:(id)sender{
    
    if(self.switchMessage.on) {
        NSLog(@"MessageOn");
        [self.Demoapi settingMessage:@"1"];
    } else {
        NSLog(@"MessageOff");
        [self.Demoapi settingMessage:@"0"];
    }
    
}

- (void)DCManager:(id)sender settingNewsResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
}

- (void)DCManager:(id)sender settingNewsErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.rowCount intValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFAccountCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFAccountCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    CALayer *bgView = [cell.bgView layer];
    [bgView setMasksToBounds:YES];
    [bgView setCornerRadius:5.0f];
    
    if (indexPath.row == 0) {
        if ([[self.objUsersetting objectForKey:@"show_facebook"] intValue] == 1) {
            cell.imgrow.image = [UIImage imageNamed:@"ic_fb.png"];
            cell.detailrow.text = [self.obj objectForKey:@"facebook_name"];
        } else {
            if ([[self.objUsersetting objectForKey:@"show_email"] intValue] == 1 && [[self.objUsersetting objectForKey:@"show_facebook"] intValue] == 0) {
                cell.imgrow.image = [UIImage imageNamed:@"ic_mail.png"];
                cell.detailrow.text = [self.obj objectForKey:@"email"];
            } else {
                if ([[self.objUsersetting objectForKey:@"show_website"] intValue] == 1 && [[self.objUsersetting objectForKey:@"show_facebook"] intValue] == 0 && [[self.objUsersetting objectForKey:@"show_email"] intValue] == 0) {
                    cell.imgrow.image = [UIImage imageNamed:@"ic_web.png"];
                    cell.detailrow.text = [self.obj objectForKey:@"website"];
                } else {
                    if ([[self.objUsersetting objectForKey:@"show_mobile"] intValue] == 1 && [[self.objUsersetting objectForKey:@"show_facebook"] intValue] == 0 && [[self.objUsersetting objectForKey:@"show_email"] intValue] == 0  && [[self.objUsersetting objectForKey:@"show_website"] intValue] == 0) {
                        cell.imgrow.image = [UIImage imageNamed:@"ic_iphone.png"];
                        cell.detailrow.text = [self.obj objectForKey:@"mobile_phone"];
                    } else {
                        if ([[self.objUsersetting objectForKey:@"show_gender"] intValue] == 1 && [[self.objUsersetting objectForKey:@"show_facebook"] intValue] == 0 && [[self.objUsersetting objectForKey:@"show_email"] intValue] == 0  && [[self.objUsersetting objectForKey:@"show_website"] intValue] == 0 && [[self.objUsersetting objectForKey:@"show_mobile"] intValue] == 0) {
                            cell.imgrow.image = [UIImage imageNamed:@"ic_gender.png"];
                            cell.detailrow.text = [self.obj objectForKey:@"gender"];
                        } else {
                            if ([[self.objUsersetting objectForKey:@"show_birth_date"] intValue] == 1 && [[self.objUsersetting objectForKey:@"show_facebook"] intValue] == 0 && [[self.objUsersetting objectForKey:@"show_email"] intValue] == 0  && [[self.objUsersetting objectForKey:@"show_website"] intValue] == 0 && [[self.objUsersetting objectForKey:@"show_mobile"] intValue] == 0 && [[self.objUsersetting objectForKey:@"show_gender"] intValue] == 0) {
                                    cell.imgrow.image = [UIImage imageNamed:@"ic_birthday.png"];
                                    cell.detailrow.text = [[self.obj objectForKey:@"birth_date"] objectForKey:@"date"];
                            }
                        }
                    }
                }
            }
        }
    } else if (indexPath.row == 1) {
        if ([[self.objUsersetting objectForKey:@"show_email"] intValue] == 1) {
            if ([[self.objUsersetting objectForKey:@"show_facebook"] intValue] == 1) {
                cell.imgrow.image = [UIImage imageNamed:@"ic_mail.png"];
                cell.detailrow.text = [self.obj objectForKey:@"email"];
            }
        }
        if ([[self.objUsersetting objectForKey:@"show_website"] intValue] == 1) {
            if ([[self.objUsersetting objectForKey:@"show_email"] intValue] + [[self.objUsersetting objectForKey:@"show_facebook"] intValue] == 1) {
                cell.imgrow.image = [UIImage imageNamed:@"ic_web.png"];
                cell.detailrow.text = [self.obj objectForKey:@"website"];
            }
        }
        if ([[self.objUsersetting objectForKey:@"show_mobile"] intValue] == 1) {
            if ([[self.objUsersetting objectForKey:@"show_email"] intValue] + [[self.objUsersetting objectForKey:@"show_facebook"] intValue] + [[self.objUsersetting objectForKey:@"show_website"] intValue] == 1) {
                cell.imgrow.image = [UIImage imageNamed:@"ic_iphone.png"];
                cell.detailrow.text = [self.obj objectForKey:@"mobile_phone"];
            }
        }
        if ([[self.objUsersetting objectForKey:@"show_gender"] intValue] == 1) {
            if ([[self.objUsersetting objectForKey:@"show_email"] intValue] + [[self.objUsersetting objectForKey:@"show_facebook"] intValue] + [[self.objUsersetting objectForKey:@"show_website"] intValue] + [[self.objUsersetting objectForKey:@"show_mobile"] intValue] == 1) {
                cell.imgrow.image = [UIImage imageNamed:@"ic_gender.png"];
                cell.detailrow.text = [self.obj objectForKey:@"gender"];
            }
        }
        if ([[self.objUsersetting objectForKey:@"show_birth_date"] intValue] == 1) {
            if ([[self.objUsersetting objectForKey:@"show_email"] intValue] + [[self.objUsersetting objectForKey:@"show_facebook"] intValue] + [[self.objUsersetting objectForKey:@"show_website"] intValue] + [[self.objUsersetting objectForKey:@"show_gender"] intValue] + [[self.objUsersetting objectForKey:@"show_mobile"] intValue] == 1) {
                cell.imgrow.image = [UIImage imageNamed:@"ic_birthday.png"];
                cell.detailrow.text = [[self.obj objectForKey:@"birth_date"] objectForKey:@"date"];
            }
        }
    } else if (indexPath.row == 2) {
        if ([[self.objUsersetting objectForKey:@"show_website"] intValue] == 1) {
            if ([[self.objUsersetting objectForKey:@"show_email"] intValue] + [[self.objUsersetting objectForKey:@"show_facebook"] intValue] == 2) {
                cell.imgrow.image = [UIImage imageNamed:@"ic_web.png"];
                cell.detailrow.text = [self.obj objectForKey:@"website"];
            }
        }
        if ([[self.objUsersetting objectForKey:@"show_mobile"] intValue] == 1) {
            if ([[self.objUsersetting objectForKey:@"show_email"] intValue] + [[self.objUsersetting objectForKey:@"show_facebook"] intValue] + [[self.objUsersetting objectForKey:@"show_website"] intValue] == 2) {
                cell.imgrow.image = [UIImage imageNamed:@"ic_iphone.png"];
                cell.detailrow.text = [self.obj objectForKey:@"mobile_phone"];
            }
        }
        if ([[self.objUsersetting objectForKey:@"show_gender"] intValue] == 1) {
            if ([[self.objUsersetting objectForKey:@"show_email"] intValue] + [[self.objUsersetting objectForKey:@"show_facebook"] intValue] + [[self.objUsersetting objectForKey:@"show_website"] intValue] + [[self.objUsersetting objectForKey:@"show_mobile"] intValue] == 2) {
                cell.imgrow.image = [UIImage imageNamed:@"ic_gender.png"];
                cell.detailrow.text = [self.obj objectForKey:@"gender"];
            }
        }
        if ([[self.objUsersetting objectForKey:@"show_birth_date"] intValue] == 1) {
            if ([[self.objUsersetting objectForKey:@"show_email"] intValue] + [[self.objUsersetting objectForKey:@"show_facebook"] intValue] + [[self.objUsersetting objectForKey:@"show_website"] intValue] + [[self.objUsersetting objectForKey:@"show_gender"] intValue] + [[self.objUsersetting objectForKey:@"show_mobile"] intValue] == 2) {
                cell.imgrow.image = [UIImage imageNamed:@"ic_birthday.png"];
                cell.detailrow.text = [[self.obj objectForKey:@"birth_date"] objectForKey:@"date"];
            }
        }
    } else if (indexPath.row == 3) {
        if ([[self.objUsersetting objectForKey:@"show_mobile"] intValue] == 1) {
            if ([[self.objUsersetting objectForKey:@"show_email"] intValue] + [[self.objUsersetting objectForKey:@"show_facebook"] intValue] + [[self.objUsersetting objectForKey:@"show_website"] intValue] == 3) {
                cell.imgrow.image = [UIImage imageNamed:@"ic_iphone.png"];
                cell.detailrow.text = [self.obj objectForKey:@"mobile_phone"];
            }
        }
        if ([[self.objUsersetting objectForKey:@"show_gender"] intValue] == 1) {
            if ([[self.objUsersetting objectForKey:@"show_email"] intValue] + [[self.objUsersetting objectForKey:@"show_facebook"] intValue] + [[self.objUsersetting objectForKey:@"show_website"] intValue] + [[self.objUsersetting objectForKey:@"show_mobile"] intValue] == 3) {
                cell.imgrow.image = [UIImage imageNamed:@"ic_gender.png"];
                cell.detailrow.text = [self.obj objectForKey:@"gender"];
            }
        }
        if ([[self.objUsersetting objectForKey:@"show_birth_date"] intValue] == 1) {
            if ([[self.objUsersetting objectForKey:@"show_email"] intValue] + [[self.objUsersetting objectForKey:@"show_facebook"] intValue] + [[self.objUsersetting objectForKey:@"show_website"] intValue] + [[self.objUsersetting objectForKey:@"show_gender"] intValue] + [[self.objUsersetting objectForKey:@"show_mobile"] intValue] == 3) {
                cell.imgrow.image = [UIImage imageNamed:@"ic_birthday.png"];
                cell.detailrow.text = [[self.obj objectForKey:@"birth_date"] objectForKey:@"date"];
            }
        }
    } else if (indexPath.row == 4) {
        if ([[self.objUsersetting objectForKey:@"show_gender"] intValue] == 1) {
            if ([[self.objUsersetting objectForKey:@"show_email"] intValue] + [[self.objUsersetting objectForKey:@"show_facebook"] intValue] + [[self.objUsersetting objectForKey:@"show_website"] intValue] + [[self.objUsersetting objectForKey:@"show_mobile"] intValue] == 4) {
                cell.imgrow.image = [UIImage imageNamed:@"ic_gender.png"];
                cell.detailrow.text = [self.obj objectForKey:@"gender"];
            }
        }
        if ([[self.objUsersetting objectForKey:@"show_birth_date"] intValue] == 1) {
            if ([[self.objUsersetting objectForKey:@"show_email"] intValue] + [[self.objUsersetting objectForKey:@"show_facebook"] intValue] + [[self.objUsersetting objectForKey:@"show_website"] intValue] + [[self.objUsersetting objectForKey:@"show_gender"] intValue] + [[self.objUsersetting objectForKey:@"show_mobile"] intValue] == 4) {
                cell.imgrow.image = [UIImage imageNamed:@"ic_birthday.png"];
                cell.detailrow.text = [[self.obj objectForKey:@"birth_date"] objectForKey:@"date"];
            }
        }
    } else if (indexPath.row == 5) {
        if ([[self.objUsersetting objectForKey:@"show_birth_date"] intValue] == 1) {
            cell.imgrow.image = [UIImage imageNamed:@"ic_birthday.png"];
            cell.detailrow.text = [[self.obj objectForKey:@"birth_date"] objectForKey:@"date"];
        }
    }
    
    return cell;
}

- (void)editProfileTapped {
    PFEditAccountViewController *editView = [[PFEditAccountViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editView = [[PFEditAccountViewController alloc] initWithNibName:@"PFEditAccountViewController_Wide" bundle:nil];
    } else {
        editView = [[PFEditAccountViewController alloc] initWithNibName:@"PFEditAccountViewController" bundle:nil];
    }
    
    editView.delegate = self;
    editView.objAccount = self.obj;
    editView.objUsersetting = self.objUsersetting;
    [self.navigationController pushViewController:editView animated:YES];
}

- (IBAction)fullimgTapped:(id)sender {
    
    NSString *picStr = [[NSString alloc] initWithString:[[self.obj objectForKey:@"picture"] objectForKey:@"link"]];
    [self.delegate PFAccountViewController:self viewPicture:picStr];
    
}

- (IBAction)logoutTapped:(id)sender {
    
    [FBSession.activeSession closeAndClearTokenInformation];
    [self.Demoapi logOut];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)tutorialTapped:(id)sender {
    PFTutorialViewController *editView = [[PFTutorialViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editView = [[PFTutorialViewController alloc] initWithNibName:@"PFTutorialViewController_Wide" bundle:nil];
    } else {
        editView = [[PFTutorialViewController alloc] initWithNibName:@"PFTutorialViewController" bundle:nil];
    }
    [self.navigationController pushViewController:editView animated:NO];
}

- (void) PFEditAccountViewControllerBack {
    [self viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFAccountViewControllerBack)]){
            [self.delegate PFAccountViewControllerBack];
        }
    }
    
}

@end
