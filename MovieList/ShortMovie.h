//
//  ShortMovie.h
//  MovieList
//
//  Created by Артем Рябцев on 15.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShortMovie : NSObject<NSCopying>

@property (strong, nonatomic)NSString *title;
@property ( nonatomic, nullable,strong)NSURL *posterUrl;
@property (strong, nonatomic)NSArray *genresIDs;
@property (strong, nonatomic)NSString *overview;
@property (strong, nonatomic)NSString *releaseDate;
@property (weak, nonatomic)NSNumber *movieID;
@property (strong, nonatomic)NSNumber *popularity;
@property (strong,nonatomic)NSNumber *voteAvereng;

-(instancetype)initWithInfo:(NSString*)title
                     Poster:(NSURL*)poster
                     Genres:(NSArray*)genres
                   Overview:(NSString*)oView
                      Release:(NSString*)date
                         ID:(NSNumber*)mID
                        Pop:(NSNumber*)pop
                     VoteAv:(NSNumber*)vote;
@end
