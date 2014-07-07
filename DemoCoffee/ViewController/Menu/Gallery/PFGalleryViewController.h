//
//  PFGalleryViewController.h
//  MingMitr
//
//  Created by Pariwat on 6/11/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollView.h"
#import "AMBlurView.h"
#import "AsyncImageView.h"
#import "UILabel+UILabelDynamicHeight.h"
#import <Social/Social.h>

#import "DCManager.h"

#import "PFOrderViewController.h"

@protocol PFGalleryViewControllerDelegate <NSObject>

- (void)PFGalleryViewController:(id)sender sum:(NSMutableArray *)sum current:(NSString *)current;

@end

@interface PFGalleryViewController : UIViewController < UIScrollViewDelegate > {
    
    IBOutlet ScrollView *scrollView;
    IBOutlet AsyncImageView *imageView;
    NSMutableArray *images;
    NSArray *imagesName;
    
}

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) NSString *titlename;
@property (strong, nonatomic) NSString *parent_id;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *product_id;
@property (strong, nonatomic) NSString *urlimg;
@property (strong, nonatomic) NSString *shareimg;
@property (strong, nonatomic) NSString *current;

@property (strong, nonatomic) DCManager *Demoapi;
@property (strong, nonatomic) NSMutableArray *arrObj;
@property (strong, nonatomic) NSDictionary *obj;
@property (strong, nonatomic) NSDictionary *objdetail;

@property (strong, nonatomic) NSMutableArray *arrgalleryimg;

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *baht;
@property (strong, nonatomic) IBOutlet UILabel_UILabelDynamicHeight *productdetail;

@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *waitView;
@property (strong, nonatomic) IBOutlet UIView *popupwaitView;

-(void)ShowDetailView:(UIImageView *)imgView;

@property (strong, nonatomic) IBOutlet UIButton *orderButton;

- (IBAction)fullimgalbumTapped:(id)sender;
- (IBAction)orderGalleryTapped:(id)sender;

@end