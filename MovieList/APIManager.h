//
//  APIManager.h
//  MovieList
//
//  Created by Артем Рябцев on 15.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APIManager : NSObject

@property (weak, nonatomic) NSString *apiKey;
@property NSInteger pagesCount;

+(APIManager*)sharedManager;
-(void)getMovieList:(void (^)(NSArray *, NSError *))completion;
-(void)getMovieByID:(NSNumber*)ID completionBlock:(void (^)(id))completion;
@end
