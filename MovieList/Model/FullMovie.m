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
        _runTime = runT;
        _budget = sum;
        _genresArray = [genres copy];
        _prodactCompaniesArray = [prodComp copy];
        _prodactCountriesArray = [prodCountries copy];
    }
    return self;
}
-(NSString*)description{
    
    return [NSString stringWithFormat:@"RunT: %@\nBudget: %@\nGenres: %@\nCompanies: %@\nCountries: %@\n",self.runTime,self.budget,self.genresArray,self.prodactCompaniesArray,self.prodactCountriesArray];
}

@end
