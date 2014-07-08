//
//  PFUpdateCommentCell.h
//  MingMitr
//
//  Created by Pariwat on 6/11/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@protocol PFUpdateCommentCellDelegate <NSObject>

- (void)profile:(NSString *)userId;

@end

@interface PFUpdateCommentCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userImg;
@property (strong, nonatomic) IBOutlet UIButton *imgBut;
@property (assign, nonatomic) id <PFUpdateCommentCellDelegate> delegate;
@property (nonatomic, weak) IBOutlet AsyncImageView *myImageView;
@property (strong, nonatomic) IBOutlet UIImageView *bgComment;
@property (strong, nonatomic) IBOutlet UIImageView *lineImg;

@property (strong, nonatomic) IBOutlet UIImageView *headImg;

@property (strong, nonatomic) IBOutlet UILabel *timeComment;

- (IBAction)userImgTapped:(id)sender;

@end
