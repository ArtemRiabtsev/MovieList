//
//  MovieTableViewCell.m
//  MovieList
//
//  Created by Артем Рябцев on 15.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.ratingView = [RateView rateViewWithRating:1.0f];
    [self.ratingView setStarSize:15];
    [self.ratingView setStarBorderColor:[UIColor whiteColor]];
    [self.ratingView setStarFillColor:[UIColor yellowColor]];
    [self.ratingView setStarNormalColor:[UIColor clearColor]];
    [self.ratingView setFrame:CGRectMake(CGRectGetMaxX(self.frame) - 80, CGRectGetMaxY(self.frame) - 30, 75, 30)];
    [self.ratingView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    [self addSubview:self.ratingView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
