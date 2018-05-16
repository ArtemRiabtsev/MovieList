//
//  ViewController.m
//  MovieList
//
//  Created by Артем Рябцев on 15.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import "ViewController.h"
#import "APIManager.h"
#import "ShortMovie.h"
#import "MovieTableViewCell.h"
#include "RateView.h"
#import "ImagesCache.h"
#import "DetailViewController.h"


static NSString *reuseIdentifier = @"CellID";

@interface ViewController ()
@property (strong,nonatomic)NSMutableArray *dataArrayForTable;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ImagesCache *imagesCache;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.imagesCache = [[ImagesCache alloc] init];

    self.dataArrayForTable = [[NSMutableArray alloc] init];
    [APIManager sharedManager].pagesCount = 0;
    if (self.dataArrayForTable.count > 0) {
        [self.dataArrayForTable removeAllObjects];
    }
    [[APIManager sharedManager] getMovieList:^(NSArray *array, NSError *error) {
       
        [self.dataArrayForTable addObjectsFromArray:array];
        
        [self.tableView reloadData];
    }];
     
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView setRowHeight:150.0];
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (![cell isMemberOfClass:[MovieTableViewCell class]]) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MovieTableViewCell"owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrayForTable.count;
}
#pragma mark - UITableView Delegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.dataArrayForTable.count - 1) {
        [[APIManager sharedManager] getMovieList:^(NSArray *array, NSError *error) {
            [self.dataArrayForTable addObjectsFromArray:array];
            [tableView reloadData];
        }];
    }
    
    ShortMovie *movie = [self.dataArrayForTable objectAtIndex:indexPath.row];
    ((MovieTableViewCell*)cell).posterImageView.image = [self.imagesCache getImageWithURL:movie.posterUrl.absoluteString
                                                                             prefix:@"catalog_big"
                                                                               size:CGSizeMake(90.0f, 150.0f)
                                                                     forUIImageView:((MovieTableViewCell*)cell).posterImageView];
    [((MovieTableViewCell*)cell).titleMovieLabel setText:movie.title];
    [((MovieTableViewCell*)cell).ratingView setRating:(5 * movie.voteAvereng.floatValue)/10];
    [((MovieTableViewCell*)cell).viewsLabel setText:[NSString stringWithFormat:@"%3f",movie.popularity.floatValue]];
    [((MovieTableViewCell*)cell).releaseDateLabel setText:movie.releaseDate];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detailViewController = [[UIStoryboard storyboardWithName:@"Detail" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    detailViewController.shortMovie = [[self.dataArrayForTable objectAtIndex:indexPath.row] copy];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


















@end

