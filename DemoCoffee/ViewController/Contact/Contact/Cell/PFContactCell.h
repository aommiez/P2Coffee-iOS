//
//  PFContactCell.h
//  DemoCoffee
//
//  Created by Pariwat on 6/17/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface PFContactCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *branch;
@property (weak, nonatomic) IBOutlet AsyncImageView *imgbranch;
@property (weak, nonatomic) IBOutlet UIImageView *bgimg;

@end
