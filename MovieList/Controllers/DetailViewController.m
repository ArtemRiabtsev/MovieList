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
@property (strong,nonatomic)FullMovie *fullMovie;
@property (strong,nonatomic)RateView *ratingView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"DetailViewController");
    float rating = (5 * self.shortMovie.voteAvereng.floatValue) / 10;
    self.ratingView = [RateView rateViewWithRating:rating];
    [self.ratingView setFrame:CGRectMake(CGRectGetMaxX(self.view.frame) - 180, CGRectGetMaxY(self.view.frame) - 110, 150, 40)];
    [self.ratingView setStarSize:30];
    [self.ratingView setStarBorderColor:[UIColor whiteColor]];
    [self.ratingView setStarFillColor:[UIColor yellowColor]];
    [self.ratingView setStarNormalColor:[UIColor clearColor]];
    [self.ratingView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
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
    
    [self.view addSubview:self.ratingView];
    [self.view bringSubviewToFront:self.ratingView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSLog(@"RATING VIEW %@ Rating %f",self.ratingView.description, self.ratingView.rating);
    [[APIManager sharedManager] getMovieByID:self.shortMovie.movieID
                             completionBlock:^(FullMovie *movie) {
                                 
                                 self.fullMovie = movie;
                                 [self.budgetLabel setText:self.fullMovie.budget.stringValue];
                                 [self.durationLabel setText:self.fullMovie.runTime.stringValue];
                             }];
    
   
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"WARNING didReceiveMemoryWarning");
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
