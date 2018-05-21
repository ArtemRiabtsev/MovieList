//
//  FullMovie.m
//  MovieList
//
//  Created by Артем Рябцев on 15.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import "FullMovie.h"

@implementation FullMovie
-(instancetype)initWithFullInfo:(NSNumber*)runT
                         Budget:(NSNumber*)sum
                         Genres:(NSArray*)genres
                  ProdCompanies:(NSArray*)prodComp
                  ProdCountries:(NSArray*)prodCountries{
    self = [super init];
    if (self != nil) {
        self.runTime = runT;
        self.budget = sum;
        self.genresArray = [genres copy];
        self.prodactCompaniesArray = [prodComp copy];
        self.prodactCountriesArray = [prodCountries copy];
    }
    return self;
}
-(NSString*)description{
    
    return [NSString stringWithFormat:@"RunT: %@\nBudget: %@\nGenres: %@\nCompanies: %@\nCountries: %@\n",self.runTime,self.budget,self.genresArray,self.prodactCompaniesArray,self.prodactCountriesArray];
}
// if the response from the server NSNull
-(NSNumber*)runTime{
    if (_runTime == nil || [_runTime isKindOfClass:[NSNull class]]) {
        return [NSNumber numberWithInteger:0];
    }
    else return _runTime;
}

@end
