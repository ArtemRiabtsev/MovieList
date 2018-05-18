//
//  SearchResultTableViewController.h
//  MovieList
//
//  Created by Артем Рябцев on 17.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultTableViewController : UITableViewController
@property (strong, nonatomic)NSMutableArray *dataArrayForTable;
@property (strong, nonatomic)NSNumber *pageCount;
@property (strong,nonatomic)NSString *searchString;
@property (strong, nonatomic)NSNumber *genreID;

@end
