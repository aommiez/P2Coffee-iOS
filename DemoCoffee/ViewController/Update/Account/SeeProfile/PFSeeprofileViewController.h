//
//  PFSeeprofileViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 7/2/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AsyncImageView.h"

#import "DCManager.h"

#import "PFAccountCell.h"

@protocol PFSeeprofileViewControllerDelegate <NSObject>

- (void)PFSeeprofileViewController:(id)sender viewPicture:(NSString *)link;
- (void)PFSeeprofileViewControllerBack;

@end

@interface PFSeeprofileViewController : UIViewController < MFMailComposeViewControllerDelegate >

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) DCManager *Demoapi;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *bgheaderView;

@property (strong, nonatomic) NSString *user_id;

@property (strong, nonatomic) NSDictionary *obj;
@property (strong, nonatomic) NSDictionary *objUsersetting;

@property (strong, nonatomic) NSString *rowCount;

@property (strong, nonatomic) IBOutlet UIView *waitView;
@property (strong, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) IBOutlet AsyncImageView *thumUser;
@property (strong, nonatomic) IBOutlet UITextField *display_name;

- (IBAction)fullimgTapped:(id)sender;

@end
