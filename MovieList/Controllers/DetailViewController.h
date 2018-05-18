//
//  DetailViewController.h
//  MovieList
//
//  Created by Артем Рябцев on 16.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShortMovie.h"

@interface DetailViewController : UIViewController
@property (strong, nonatomic)ShortMovie *shortMovie;

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *budgetLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *popularityLabel;
@property (weak, nonatomic) IBOutlet UITextView *overviewTextView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *genresLabel;
@property (weak, nonatomic) IBOutlet UILabel *countriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *companiesLabel;
@end
