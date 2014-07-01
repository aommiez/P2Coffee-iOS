//
//  PFEditDetailViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/30/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCManager.h"

@protocol PFEditDetailViewControllerDelegate <NSObject>

- (void)PFEditDetailViewControllerBack;

@end

@interface PFEditDetailViewController : UIViewController

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) DCManager *Demoapi;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *displaynameView;
@property (strong, nonatomic) IBOutlet UIView *passwordView;
@property (strong, nonatomic) IBOutlet UIView *emailView;
@property (strong, nonatomic) IBOutlet UIView *websiteView;
@property (strong, nonatomic) IBOutlet UIView *phoneView;

@property (weak, nonatomic) IBOutlet UITextField *displayname;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *website;
@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UIButton *displayname_bt;
@property (weak, nonatomic) IBOutlet UIButton *email_bt;
@property (weak, nonatomic) IBOutlet UIButton *website_bt;
@property (weak, nonatomic) IBOutlet UIButton *phone_bt;

@property (strong, nonatomic) NSDictionary *obj;
@property (strong, nonatomic) NSString *checkstatus;

- (IBAction)displaynameTapped:(id)sender;
- (IBAction)passwordTapped:(id)sender;
- (IBAction)emailTapped:(id)sender;
- (IBAction)websiteTapped:(id)sender;
- (IBAction)phoneTapped:(id)sender;

@end
