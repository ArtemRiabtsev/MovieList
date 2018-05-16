//
//  DetailViewController.m
//  MovieList
//
//  Created by Артем Рябцев on 16.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import "DetailViewController.h"
#import "FullMovie.h"
#import "APIManager.h"
#import "RateView.h"
#import "ImagesCache.h"

@interface DetailViewController ()
@property (weak,nonatomic)FullMovie *fullMovie;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"DetailViewController");
    RateView *ratingView = [RateView rateViewWithRating:(5 * self.shortMovie.voteAvereng.floatValue) / 10];
    [ratingView setStarSize:30];
    [ratingView setStarBorderColor:[UIColor whiteColor]];
    [ratingView setStarFillColor:[UIColor yellowColor]];
    [ratingView setStarNormalColor:[UIColor clearColor]];
    [ratingView setFrame:CGRectMake(CGRectGetMaxX(self.view.frame) - 120, CGRectGetMaxY(self.view.frame) - 50, 150, 40)];
    [ratingView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    //- image
    ImagesCache *imgCashe = [[ImagesCache alloc] init];
    self.posterView.image = [imgCashe getImageWithURL:self.shortMovie.posterUrl.absoluteString
                                                 prefix:@"catalog_big"
                                                   size:CGSizeMake(170.0f, 230.0f)
                                         forUIImageView:self.posterView];
    [self.releaseDateLabel setText:self.shortMovie.releaseDate];
    [self.popularityLabel setText:self.shortMovie.popularity.stringValue];
    [self.titleLabel setText:self.shortMovie.title];
    [self.overviewTextView setText:self.shortMovie.overview];
    
    [self.view addSubview:ratingView];
    [[APIManager sharedManager] getMovieByID:self.shortMovie.movieID completionBlock:^(FullMovie *movie) {
        self.fullMovie = movie;
       
        [self.budgetLabel setText:self.fullMovie.budget.stringValue];
        [self.durationLabel setText:self.fullMovie.runTime.stringValue];
    }];
}
/*
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
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
