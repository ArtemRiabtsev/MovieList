//
//  MenuTableViewController.m
//  MovieList
//
//  Created by Артем Рябцев on 17.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import "MenuTableViewController.h"
#import "APIManager.h"
#import "SearchResultTableViewController.h"

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
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
    [tableView setRowHeight:66.0f];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellId"];
    }

    [cell.textLabel setText:[[self.dataArrayForTable objectAtIndex:indexPath.row] objectForKey:@"name"]];
    
    return cell;
}

#pragma mark Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchResultTableViewController *searchViewController = [[UIStoryboard storyboardWithName:@"SearchResult" bundle:nil] instantiateViewControllerWithIdentifier:@"SearchResultTableViewController"];
    
    searchViewController.genreID = [[self.dataArrayForTable objectAtIndex:indexPath.row] objectForKey:@"id"];
    
    searchViewController.pageCount = [NSNumber numberWithInteger:1];
    
    [[APIManager sharedManager] getMovieListByGenre:searchViewController.genreID
                                               Page:searchViewController.pageCount.integerValue
                                    completionBlock:^(NSArray *array, NSError *error) {
                                        
        if (!error) {
            searchViewController.dataArrayForTable = [NSMutableArray arrayWithArray:array];
        }
        else{
            NSLog(@"%@",error.localizedDescription);
        }
        [self.navigationController pushViewController:searchViewController animated:YES];
        [searchViewController.tableView reloadData];
    }];
    
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
