//
//  FullMovie.h
//  MovieList
//
//  Created by Артем Рябцев on 15.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface FullMovie : NSObject

@property (strong,nonatomic)NSNumber *runTime;
@property (strong, nonatomic)NSNumber *budget;
@property (strong, nonatomic)NSArray *genresArray;
@property (strong, nonatomic)NSArray *prodactCompaniesArray;
@property (strong, nonatomic)NSArray *prodactCountriesArray;

-(instancetype)initWithFullInfo:(NSNumber*)runT
                         Budget:(NSNumber*)sum
                         Genres:(NSArray*)genres
                  ProdCompanies:(NSArray*)prodComp
                  ProdCountries:(NSArray*)prodCountries;
@end
