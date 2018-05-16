//
//  ShortMovie.m
//  MovieList
//
//  Created by Артем Рябцев on 15.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import "ShortMovie.h"

@implementation ShortMovie

-(instancetype)initWithInfo:(NSString*)title
                     Poster:(NSURL*)poster
                     Genres:(NSArray*)genres
                   Overview:(NSString*)oView
                      Release:(NSString*)date
                         ID:(NSNumber*)mID
                        Pop:(NSNumber*)pop
                     VoteAv:(NSNumber*)vote{
    self = [super init];
    if (self != nil) {
        _title = [title copy];
        _posterUrl = [poster copy];
        _genresIDs = [[NSArray alloc] initWithArray:genres];
        _overview = [NSString stringWithString:oView];
        _releaseDate = [NSString stringWithString:date];
        _movieID = mID;
        _popularity = pop;
        _voteAvereng = vote;
    }
    return self;
}
-(NSString*)description{
    
    return [NSString stringWithFormat:@"title: %@\nposter: %@\ngenres: %@\noverview: %@\ndate: %@\nID: %@\n%@\n",self.title,self.posterUrl,self.genresIDs,self.overview,self.releaseDate,self.movieID,self.popularity];
}

- (id)copyWithZone:(nullable NSZone *)zone{
    
    id copy = [[[self class] alloc] init];
    
    [copy setTitle:[self.title copyWithZone:zone]];
    [copy setPosterUrl:[self.posterUrl copyWithZone:zone]];
    [copy setGenresIDs:[self.genresIDs copyWithZone:zone]];
    [copy setOverview:[self.overview copyWithZone:zone]];
    [copy setReleaseDate:[self.releaseDate copyWithZone:zone]];
    [copy setMovieID:[self.movieID copyWithZone:zone]];
    [copy setPopularity:[self.popularity copyWithZone:zone]];
    [copy setVoteAvereng:[self.voteAvereng copyWithZone:zone]];
    
    
    return copy;
}
@end
