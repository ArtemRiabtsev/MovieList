//
//  PresentDataProtocol.h
//  MovieList
//
//  Created by Артем Рябцев on 15.05.2018.
//  Copyright © 2018 Артем Рябцев. All rights reserved.
//

#import <Foundation/Foundation.h>

//This protocol declares required methods for processing data from the server
@protocol PresentDataProtocol <NSObject>
@required

//кeturns an array with the compilers that contain brief information for the movie list
-(NSMutableArray*)moviesList:(NSData*)data;

//return conteiner with detail info about movie
-(id)movieByID:(NSData*)data;

    /*
     return NSArray<NSDictionary*> two pairs key/value = "id":NSNumber, "name":NSString
     */
-(NSArray*)genresList:(NSData*)data;
@end
