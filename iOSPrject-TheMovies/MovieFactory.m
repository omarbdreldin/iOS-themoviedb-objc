//
//  MovieFactory.m
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import "MovieFactory.h"

@implementation MovieFactory

static NSString const *posterBaseUrl = @"http://image.tmdb.org/t/p/w185";

+(Movie *)initWithIdentifier:(NSString *)identifier andTitle:(NSString *)title andPosterUrl:(NSString *)posterUrl andOverview:(NSString *)overview andVoteAverrage:(NSNumber *)voteAverage andPopularity:(NSNumber *)popularity andReleaseDate:(NSNumber *) releaseDate{

    Movie *movie = [Movie new];
//    NSLog(title);
    movie.identifier = identifier;
    movie.title = title;
    movie.posterUrl = [NSString stringWithFormat:@"%@%@", posterBaseUrl, posterUrl];
    movie.overview = overview;
    movie.voteAverage = voteAverage;
    movie.popularity = popularity;
    movie.releaseYear = releaseDate;
    movie.isFavourite = [NSNumber numberWithInt:0];
    
    return movie;
}

+(NSMutableArray *)initListWithData:(id) data {
    
    NSMutableArray *moviesList = [NSMutableArray new];
    NSDictionary *dictionary = data;
    
    // Parse data here..
    NSArray *jsonMoviesArray = dictionary[@"results"];
    
    for (NSDictionary * movieDictionary in jsonMoviesArray) {
        NSString *releaseYearString = movieDictionary[@"release_date"];
        releaseYearString = [releaseYearString substringToIndex:4];
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *releaseYear = [formatter numberFromString:releaseYearString];
        Movie *movie = [MovieFactory initWithIdentifier:movieDictionary[@"id"] andTitle:movieDictionary[@"title"] andPosterUrl:movieDictionary[@"poster_path"] andOverview:movieDictionary[@"overview"] andVoteAverrage:movieDictionary[@"vote_average"] andPopularity:movieDictionary[@"popularity"] andReleaseDate:releaseYear];
        
        [moviesList addObject:movie];
    }
    
    return moviesList;
}

@end
