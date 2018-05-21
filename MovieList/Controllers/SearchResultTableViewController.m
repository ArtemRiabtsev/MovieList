//
//  SearchResultTableViewController.m
//  MovieList
//
//  Created by Артем Рябцев on 17.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import "SearchResultTableViewController.h"
#import "APIManager.h"
#import "ShortMovie.h"
#import "MovieTableViewCell.h"
#include "RateView.h"
#import "ImagesCache.h"
#import "DetailViewController.h"

@interface SearchResultTableViewController ()
//class for loading and caching images (https://github.com/MihaelIsaev/ImagesCache)
@property (weak, nonatomic) IBOutlet UIImageView *placeholderImageView;
@property (strong, nonatomic) ImagesCache *imagesCache;
@end

@implementation SearchResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagesCache = [[ImagesCache alloc] init];
    self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArrayForTable.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView setRowHeight:150.0];
    
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    if (![cell isMemberOfClass:[MovieTableViewCell class]]) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MovieTableViewCell"owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detailViewController = [[UIStoryboard storyboardWithName:@"Detail" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    detailViewController.shortMovie = [[self.dataArrayForTable objectAtIndex:indexPath.row] copy];
    // go to detail movie view
    [self.navigationController pushViewController:detailViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.dataArrayForTable.count - 1) {//when the movies from the first loaded page have run out
        
        self.pageCount = [NSNumber numberWithInteger:self.pageCount.integerValue + 1];
        if (self.searchString != nil) {
            //Called to search by string
            [[APIManager sharedManager] searchMoviesByString:self.searchString
                                                        Page:self.pageCount.integerValue
                                             completionBlock:^(NSArray *array, NSError *error) {
                if (!error) {
                    [self.dataArrayForTable addObjectsFromArray:array];;
                    [self.tableView reloadData];
                }
                else{
                    NSLog(@"ERROR %@",error.localizedDescription);
                }
                
            }];
        }
        else if (self.genreID != nil){
            //Called to search by genre
            [[APIManager sharedManager] getMovieListByGenre:self.genreID
                                                       Page:self.pageCount.integerValue
                                            completionBlock:^(NSArray *array, NSError *error) {
                if (!error) {
                    [self.dataArrayForTable addObjectsFromArray:array];
                    
                }
                else{
                    NSLog(@"%@",error.localizedDescription);
                }
            }];
        }
    }
    
    ShortMovie *movie = [self.dataArrayForTable objectAtIndex:indexPath.row];
    
    ((MovieTableViewCell*)cell).posterImageView.image = [self.imagesCache getImageWithURL:movie.posterUrl.absoluteString
                                                                                   prefix:@"catalog_big"
                                                                                     size:CGSizeMake(90.0f, 150.0f)
                                                                           forUIImageView:((MovieTableViewCell*)cell).posterImageView];
    if (!((MovieTableViewCell*)cell).posterImageView.image) {
        [((MovieTableViewCell*)cell).posterImageView setImage:[UIImage imageNamed:@"icons8-image_file"]];
    }
    
    if (self.searchString != nil) {
        [((MovieTableViewCell*)cell).titleMovieLabel setAttributedText:[self highlightSearchString:movie.title]];
    }
    
    [((MovieTableViewCell*)cell).titleMovieLabel setText:movie.title];
    [((MovieTableViewCell*)cell).ratingView setRating:(5 * movie.voteAvereng.floatValue)/10];
    [((MovieTableViewCell*)cell).viewsLabel setText:[NSString stringWithFormat:@"%f",movie.popularity.floatValue]];
    [((MovieTableViewCell*)cell).releaseDateLabel setText:movie.releaseDate];
}
-(NSAttributedString*)highlightSearchString:(NSString*)string{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRegularExpression *regularExeption = [NSRegularExpression regularExpressionWithPattern:self.searchString
                                                                                     options:kNilOptions
                                                                                       error:nil];
    NSRange range = NSMakeRange(0, string.length);
    
    [regularExeption enumerateMatchesInString:string
                                      options:kNilOptions
                                        range:range
                                   usingBlock:^(NSTextCheckingResult *result,
                                                NSMatchingFlags flags,
                                                BOOL *stop)
     {
    NSRange subStringRange = [string rangeOfString:self.searchString];
    
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor cyanColor]
                             range:subStringRange];
     }];
    
    return attributedString;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
