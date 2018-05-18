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
-(void)getAllGenres:(void (^)(NSArray*))completion;
-(void)getMovieListByGenre:(NSNumber*)genreID Page:(NSInteger)page completionBlock:(void(^)(NSArray*, NSError*))completion;
-(void)searchMoviesByString:(NSString*)string Page:(NSInteger)page completionBlock:(void(^)(NSArray*, NSError*))completion;
@end
