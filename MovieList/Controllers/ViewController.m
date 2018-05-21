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
#import "MenuTableViewController.h"
#import "SearchResultTableViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *movieSearchBar;
@property (strong, nonatomic) IBOutlet UIImageView *placeholderImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//class for loading and caching images (https://github.com/MihaelIsaev/ImagesCache)
@property (strong, nonatomic) ImagesCache *imagesCache;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.movieSearchBar.delegate = self;
    
    
    self.imagesCache = [[ImagesCache alloc] init];

    self.dataArrayForTable = [[NSMutableArray alloc] init];
    
    [APIManager sharedManager].pagesCount = 0;//at the first appearance we load the first page of popular films
    if (self.dataArrayForTable.count > 0) {
        [self.dataArrayForTable removeAllObjects];
    }
    //request the most popular films
    [[APIManager sharedManager] getMovieList:^(NSArray *array, NSError *error) {
       
        [self.dataArrayForTable addObjectsFromArray:array];
        
        [self.view sendSubviewToBack:self.placeholderImageView];
        [self.tableView reloadData];
        
    }];
     
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (self.dataArrayForTable.count > 0) {
        [self.view sendSubviewToBack:self.placeholderImageView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    [tableView setRowHeight:150.0];
    
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
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
    //when the movies from the first loaded page have run out
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
    if (!((MovieTableViewCell*)cell).posterImageView.image) {
        [((MovieTableViewCell*)cell).posterImageView setImage:[UIImage imageNamed:@"icons8-image_file"]];
    }
    [((MovieTableViewCell*)cell).titleMovieLabel setText:movie.title];
    [((MovieTableViewCell*)cell).ratingView setRating:(5 * movie.voteAvereng.floatValue)/10];
    [((MovieTableViewCell*)cell).viewsLabel setText:[NSString stringWithFormat:@"%3f",movie.popularity.floatValue]];
    [((MovieTableViewCell*)cell).releaseDateLabel setText:movie.releaseDate];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //go to detail movie view
    DetailViewController *detailViewController = [[UIStoryboard storyboardWithName:@"Detail" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];    
    detailViewController.shortMovie = [[self.dataArrayForTable objectAtIndex:indexPath.row] copy];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Actions for Menu

- (void)didTapAnyButtonFromMenu:(UIButton *)sender {
    
    MenuTableViewController *menuTableViewController = [[UIStoryboard storyboardWithName:@"Menu" bundle:nil] instantiateViewControllerWithIdentifier:@"MenuTableViewController"];
    //the search by genre was selected
    [[APIManager sharedManager] getAllGenres:^(NSArray *array) {
        
        menuTableViewController.dataArrayForTable = [NSArray arrayWithArray:array];
        [menuTableViewController.tableView reloadData];
    }];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController pushViewController:menuTableViewController animated:YES ];
}
#pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"menuForSearch"]) {
        //popover presentation (menu)
        UIViewController *popoverViewController = segue.destinationViewController;
        [popoverViewController setModalPresentationStyle:UIModalPresentationPopover];
        
        for(UIButton *obj in popoverViewController.view.subviews){//add action for choice buttons from popover view
            
            [obj addTarget:self action:@selector(didTapAnyButtonFromMenu:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        popoverViewController.popoverPresentationController.delegate = self;
        
    }
}
#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

#pragma mark - Search bar Delegate

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text = nil;
    [searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if (searchBar.text != nil && [searchBar.text isEqualToString:@""] == NO) {
        SearchResultTableViewController *resultViewController = [[SearchResultTableViewController alloc] init];
        
        //remove spaces from the string
        NSArray* words = [searchBar.text componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        resultViewController.searchString = [words componentsJoinedByString:@"&"];
        
        resultViewController.pageCount = [NSNumber numberWithInteger:1];
        //search request to the server
        [[APIManager sharedManager] searchMoviesByString:resultViewController.searchString
                                                    Page:resultViewController.pageCount.integerValue
                                         completionBlock:^(NSArray *array, NSError *error) {
                                             
            if (!error) {
                resultViewController.dataArrayForTable = [NSMutableArray arrayWithArray:array];
                [resultViewController.tableView reloadData];
            }
            else{
                NSLog(@"ERROR %@",error.localizedDescription);
            }
            
        }];
        //go to results
        [self.navigationController pushViewController:resultViewController animated:YES];
        [searchBar resignFirstResponder];
    }
    
}














@end

