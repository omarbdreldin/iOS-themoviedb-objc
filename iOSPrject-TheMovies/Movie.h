//
//  Movie.h
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property NSString *identifier;
@property NSString *title;
@property NSString *posterUrl;
@property NSString *overview;
@property NSMutableArray *videosList;
@property NSMutableArray *reviewsList;
@property NSNumber *voteAverage;
@property NSNumber *popularity;
@property NSNumber *releaseYear;
@property NSNumber *isFavourite;

@end
