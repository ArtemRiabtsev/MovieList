//
//  MovieTableViewCell.h
//  MovieList
//
//  Created by Артем Рябцев on 15.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"

@interface MovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleMovieLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (strong,nonatomic) RateView *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;

@end
