//
//  PFUpdateDetailViewController.h
//  MingMitr
//
//  Created by Pariwat on 6/11/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+UILabelDynamicHeight.h"
#import "AsyncImageView.h"
#import <Social/Social.h>

#import "DCManager.h"

#import "PFUpdateCommentCell.h"
#import "PFLoginViewController.h"
#import "PFSeeprofileViewController.h"

@protocol PFUpdateDetailViewControllerDelegate <NSObject>

- (void)PFUpdateDetailViewControllerBack;
- (void)PFUpdateDetailViewController:(id)sender viewPicture:(NSString *)link;

@end

@interface PFUpdateDetailViewController : UIViewController < UITableViewDelegate,UITableViewDataSource,UITextViewDelegate >

@property (assign, nonatomic) id <PFUpdateDetailViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *textCommentView;

@property (strong, nonatomic) PFLoginViewController *loginView;

@property (strong, nonatomic) IBOutlet UILabel *titlenews;
@property (strong, nonatomic) IBOutlet UILabel_UILabelDynamicHeight *detailnews;
@property (strong, nonatomic) IBOutlet AsyncImageView *detailthumb;

@property (strong, nonatomic) DCManager *Demoapi;
@property (strong, nonatomic) NSDictionary *obj;
@property (strong, nonatomic) NSMutableArray *arrObj;
@property (strong, nonatomic) NSString *prevString;
@property (strong, nonatomic) NSString *paging;

@property (strong, nonatomic) IBOutlet UIButton *postBut;
@property (strong, nonatomic) IBOutlet UITextView *textComment;

- (IBAction)postCommentTapped:(id)sender;

@end
