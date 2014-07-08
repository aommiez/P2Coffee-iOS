//
//  PFUpdateCell.h
//  DemoCoffee
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface PFUpdateCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *detailNewsView;
@property (strong, nonatomic) IBOutlet UILabel *titleNews;
@property (strong, nonatomic) IBOutlet UILabel *detailNews;

@property (strong, nonatomic) IBOutlet AsyncImageView *thumbnails;

@end
