//
//  ViewDataPresenter.m
//  MovieList
//
//  Created by Артем Рябцев on 15.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import "ViewDataPresenter.h"
#import "ShortMovie.h"
#import "FullMovie.h"

@implementation ViewDataPresenter
-(NSArray*)genresList:(NSData *)data{
    
    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[resultDict objectForKey:@"genres"]];
    
    return array;
}
- (NSMutableArray *)moviesList:(NSData *)data {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    for(NSDictionary *obj in [resultDict objectForKey:@"results"]){
        NSURL *posterUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/original%@",[obj objectForKey:@"poster_path"]]];
  
        ShortMovie *movie = [[ShortMovie alloc] initWithInfo:[obj objectForKey:@"title"]
                                                      Poster:posterUrl
                                                      Genres:[NSArray arrayWithArray:[obj objectForKey:@"genre_ids"]]
                                                    Overview:[obj objectForKey:@"overview"]
                                                       Release:[obj objectForKey:@"release_date"]
                                                          ID:[obj objectForKey:@"id"]
                                                         Pop:[obj objectForKey:@"popularity"]
                                                      VoteAv:[obj objectForKey:@"vote_average"]];
        [array addObject:movie];
    }
    return array;
}

- (id)movieByID:(NSData *)data {
    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    FullMovie *fullMovie = [[FullMovie alloc] initWithFullInfo:[resultDict objectForKey:@"runtime"]
                                                       Budget:[resultDict objectForKey:@"budget"]
                                                       Genres:[resultDict objectForKey:@"genres"]
                                                ProdCompanies:[resultDict objectForKey:@"production_companies"]
                                                 ProdCountries:[resultDict objectForKey:@"production_countries"]];
    
    return fullMovie;
}


@end

