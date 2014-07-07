//
//  PFDetailViewController.h
//  MingMitr
//
//  Created by Pariwat on 6/11/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMBlurView.h"
#import "UILabel+UILabelDynamicHeight.h"
#import "AsyncImageView.h"
#import "SDImageCache.h"
#import <Social/Social.h>

#import "DCManager.h"

#import "PFOrderViewController.h"

@protocol PFDetailViewControllerDelegate <NSObject>

- (void)PFImageViewController:(id)sender viewPicture:(NSString *)link;

@end

@interface PFDetailViewController : UIViewController

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) NSString *titlename;
@property (strong, nonatomic) NSString *parent_id;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *product_id;
@property (strong, nonatomic) NSString *urlimg;
@property (strong, nonatomic) NSString *shareimg;

@property (strong, nonatomic) DCManager *Demoapi;
@property (strong, nonatomic) NSMutableArray *arrObj;
@property (strong, nonatomic) NSDictionary *obj;
@property (strong, nonatomic) NSDictionary *objdetail;

@property (strong, nonatomic) IBOutlet AsyncImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *baht;
@property (strong, nonatomic) IBOutlet UILabel_UILabelDynamicHeight *productdetail;

@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *waitView;
@property (strong, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) IBOutlet UIButton *orderButton;

- (IBAction)fullimgTapped:(id)sender;
- (IBAction)orderTapped:(id)sender;

@end
