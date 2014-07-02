//
//  PFSeeprofileViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 7/2/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFSeeprofileViewController.h"

@interface PFSeeprofileViewController ()

@end

@implementation PFSeeprofileViewController

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
    
    self.navigationItem.title = @"Profile";
    
    self.tableView.tableHeaderView = self.headerView;
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    self.obj = [[NSDictionary alloc] init];
    
    self.rowCount = [[NSString alloc] init];
    
    [self.Demoapi profile:self.user_id];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)DCManager:(id)sender getUserByIdResponse:(NSDictionary *)response {
    self.obj = response;
    NSLog(@"Me %@",response);
    
    [self.waitView removeFromSuperview];
    
    self.display_name.text = [response objectForKey:@"display_name"];
    
    NSString *picStr = [[response objectForKey:@"picture"] objectForKey:@"link"];
    self.thumUser.layer.masksToBounds = YES;
    self.thumUser.contentMode = UIViewContentModeScaleAspectFill;
    self.thumUser.imageURL = [[NSURL alloc] initWithString:picStr];
    
    [self.Demoapi getUserSettingById:self.user_id];
}

- (void)DCManager:(id)sender getUserByIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)DCManager:(id)sender getUserSettingResponse:(NSDictionary *)response {
    self.objUsersetting = response;
    NSLog(@"getUserSetting %@",response);
    
    int count = [[response objectForKey:@"show_facebook"] intValue]+[[response objectForKey:@"show_email"] intValue]+[[response objectForKey:@"show_website"] intValue]+[[response objectForKey:@"show_mobile"] intValue]+[[response objectForKey:@"show_gender"] intValue]+[[response objectForKey:@"show_birth_date"] intValue];
    self.rowCount = [NSString stringWithFormat:@"%d",count];
    [self.tableView reloadData];
}

- (void)DCManager:(id)sender getUserSettingErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.rowCount intValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 46;
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
                        
                        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
                        [cell addGestureRecognizer:singleTap];
                        
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
                
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
                [cell addGestureRecognizer:singleTap];
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
                
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
                [cell addGestureRecognizer:singleTap];
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
                
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
                [cell addGestureRecognizer:singleTap];
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

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    NSString *phone = [[NSString alloc] initWithFormat:@"telprompt://%@",[self.obj objectForKey:@"mobile_phone"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}

- (IBAction)fullimgTapped:(id)sender {
    NSString *picStr = [[NSString alloc] initWithString:[[self.obj objectForKey:@"picture"] objectForKey:@"link"]];
    [self.delegate PFSeeprofileViewController:self viewPicture:picStr];
    
}

@end
