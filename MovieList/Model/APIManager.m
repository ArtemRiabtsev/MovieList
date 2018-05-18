//
//  APIManager.m
//  MovieList
//
//  Created by Артем Рябцев on 15.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import "APIManager.h"
#import "ViewDataPresenter.h"
#import "FullMovie.h"
@interface APIManager()

@property (strong,nonatomic) ViewDataPresenter *viewPresenter;
@property(weak,nonatomic) NSURLSession *session;
@property(weak,nonatomic) NSURLSessionDataTask *dataTask;

@end

@implementation APIManager
-(instancetype)init{
    self = [super init];
    if (self != nil) {
        _apiKey = @"4cd32c21d9ad65dbd45e6b0ddbcdfbbf";
        self.viewPresenter = [[ViewDataPresenter alloc] init];
        _session = [NSURLSession sharedSession];
    }
    return self;
}

+(APIManager*)sharedManager{
    static APIManager *object = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object = [[self alloc] init];
    });
    return object;
}
-(void)searchMoviesByString:(NSString*)string Page:(NSInteger)page completionBlock:(void(^)(NSArray*, NSError*))completion{
    [_dataTask cancel];
    self.pagesCount += 1;
    //https://api.themoviedb.org/3/search/movie?api_key=4cd32c21d9ad65dbd45e6b0ddbcdfbbf&language=en-US&query=str&page=1&include_adult=false
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/search/movie?api_key=%@&language=en-US&query=%@&page=%li&include_adult=false",self.apiKey,string,page];
    _dataTask = [_session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,error);
            });
            NSLog(@"%@", error);
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *array = [NSArray arrayWithArray:[self.viewPresenter moviesList:data]];
                completion(array,nil);
            });
            return;
            
        }
    }];
    [_dataTask resume];
}
-(void)getMovieListByGenre:(NSNumber *)genreID Page:(NSInteger)page completionBlock:(void (^)(NSArray *, NSError *))completion{
    [_dataTask cancel];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/discover/movie?api_key=%@&language=en-US&sort_by=popularity.asc&include_adult=false&include_video=false&page=%li&with_genres=%@",self.apiKey,page,genreID.stringValue];
    
    _dataTask = [_session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            NSLog(@"%@", error);
        } else {
            NSLog(@"API respons %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *objects = [self.viewPresenter moviesList:data];
                completion(objects,nil);
            });
            return;
            
        }
    }];
    [_dataTask resume];
}
-(void)getAllGenres:(void (^)(NSArray*))completion{
    [_dataTask cancel];

    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/genre/movie/list?api_key=%@&language=en-US",self.apiKey];
    _dataTask = [_session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            
            NSLog(@"%@", error);
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *array = [NSArray arrayWithArray:[self.viewPresenter genresList:data]];
                completion(array);
            });
            return;
            
        }
    }];
    [_dataTask resume];
}

-(void)getMovieByID:(NSNumber*)ID completionBlock:(void (^)(id))completion{
    [_dataTask cancel];

    NSString *str = [ID.stringValue copy];
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=%@&language=en-US",str,self.apiKey];
    _dataTask = [_session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            
            NSLog(@"%@", error);
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                FullMovie *fullMovie = [self.viewPresenter movieByID:data];
                completion(fullMovie);
            });
            return;
            
        }
    }];
    
    [_dataTask resume];
}
-(void)getMovieList:(void (^)(NSArray *, NSError *))completion{
    [_dataTask cancel];

    self.pagesCount += 1;
    NSDictionary *headers = @{ @"content-type": @"application/json;charset=utf-8",
                               @"authorization": @"Bearer <<access_token>>" };
    NSDictionary *parameters = @{  };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/popular?page=%li&language=en-US&api_key=%@",(long)self.pagesCount,self.apiKey];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    _dataTask = [_session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if (error) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            completion(nil, error);
                                                        });
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                             NSArray *objects = [self.viewPresenter moviesList:data];
                                                            completion(objects,nil);
                                                        });
                                                        return;
                                                      
                                                    }
                                                }];
    [_dataTask resume];
}

@end
