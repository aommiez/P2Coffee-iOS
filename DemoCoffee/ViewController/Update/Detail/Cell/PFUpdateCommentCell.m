//
//  PFUpdateCommentCell.m
//  MingMitr
//
//  Created by Pariwat on 6/11/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFUpdateCommentCell.h"

@implementation PFUpdateCommentCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)userImgTapped:(id)sender {
    NSString *userId = [[NSString alloc] initWithFormat:@"%ld",(long)self.imgBut.tag];
    [self.delegate profile:userId];
}

@end
