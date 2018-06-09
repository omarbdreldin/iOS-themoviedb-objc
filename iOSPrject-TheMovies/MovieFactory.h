//
//  MovieFactory.h
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@interface MovieFactory : NSObject

+ (Movie *) initWithIdentifier:(NSString *) identifier andTitle:(NSString *) title andPosterUrl:(NSString *) posterUrl andOverview:(NSString *) overview andVoteAverrage:(NSNumber *) voteAverage andPopularity:(NSNumber *) popularity andReleaseDate:(NSNumber *) releaseDate;

+ (NSMutableArray *) initListWithData:(id) data;

@end
