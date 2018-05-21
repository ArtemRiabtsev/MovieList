//
//  APIManager.h
//  MovieList
//
//  Created by Артем Рябцев on 15.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresentDataProtocol.h"

@interface APIManager : NSObject

@property (weak, nonatomic) NSString *apiKey;// key for server access
@property NSInteger pagesCount;//property for the counter of popular movie pages
@property (strong,nonatomic) id<PresentDataProtocol>viewPresenter;//object that supports the protocol PresentDataProtocol

+(APIManager*)sharedManager;

//request for a list of popular films
-(void)getMovieList:(void (^)(NSArray *, NSError *))completion;

//method that performs a movie request by ID
-(void)getMovieByID:(NSNumber*)ID completionBlock:(void (^)(id))completion;

//get a list of available genres
-(void)getAllGenres:(void (^)(NSArray*))completion;

//get a list of movies for the selected genre
-(void)getMovieListByGenre:(NSNumber*)genreID Page:(NSInteger)page completionBlock:(void(^)(NSArray*, NSError*))completion;

//  method does a string search takes a string and page number 
-(void)searchMoviesByString:(NSString*)string Page:(NSInteger)page completionBlock:(void(^)(NSArray*, NSError*))completion;
@end
