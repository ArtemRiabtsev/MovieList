//
//  ViewController.h
//  MovieList
//
//  Created by Артем Рябцев on 15.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,
                                            UITableViewDataSource,
                                            UIPopoverPresentationControllerDelegate,
                                            UISearchBarDelegate>

@property (strong,nonatomic)NSMutableArray *dataArrayForTable;// data for table
@end


