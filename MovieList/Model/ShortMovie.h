//
//  ShortMovie.h
//  MovieList
//
//  Created by Артем Рябцев on 15.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import <UIKit/UIKit.h>
//conteiner for short movie info (movie list)
@interface ShortMovie : NSObject<NSCopying>

@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSURL *posterUrl;
@property (strong, nonatomic)NSArray *genresIDs;
@property (strong, nonatomic)NSString *overview;
@property (strong, nonatomic)NSString *releaseDate;
@property (strong, nonatomic)NSNumber *movieID;
@property (strong, nonatomic)NSNumber *popularity;
@property (strong, nonatomic)NSNumber *voteAvereng;

-(instancetype)initWithInfo:(NSString*)title
                     Poster:(NSURL*)poster
                     Genres:(NSArray*)genres
                   Overview:(NSString*)oView
                      Release:(NSString*)date
                         ID:(NSNumber*)mID
                        Pop:(NSNumber*)pop
                     VoteAv:(NSNumber*)vote;
@end
