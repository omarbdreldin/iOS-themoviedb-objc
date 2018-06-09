//
//  DownloadManeger.m
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import "DownloadManeger.h"

@implementation DownloadManeger

static NSString const *apiKey = @"d9b901caade882efe1041a7e4c910460";

-(instancetype)init {
    if (!_maneger) {
        _maneger = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return  self;
}

- (void)downloadPopularMoviesListWithPage:(NSNumber *)pageNumber {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/popular?page=%@&api_key=%@", pageNumber, apiKey]];
    NSLog(@"%@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    DownloadMoviesHandler handler = ^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            [_downloadMoviesProtocol downloadManagerDidFail];
        } else {
            NSMutableArray *moviesList = [MovieFactory initListWithData:responseObject];
            [_downloadMoviesProtocol popularMoviesListIsDownloaded:moviesList];
        }
    };

    NSURLSessionDataTask *dataTask = [_maneger dataTaskWithRequest:request completionHandler:handler];
    
    [dataTask resume];
}

- (void)downloadTopRatedMoviesListWithPage:(NSNumber *)pageNumber {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/top_rated?page=%@&api_key=%@", pageNumber, apiKey]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    DownloadMoviesHandler handler = ^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSMutableArray *moviesList = [MovieFactory initListWithData:responseObject];
            [_downloadMoviesProtocol topRatedMoviesListIsDownloaded:moviesList];
        }
    };
    
    NSURLSessionDataTask *dataTask = [_maneger dataTaskWithRequest:request completionHandler:handler];
    
    [dataTask resume];
}

- (void) downloadReviewsForMovie:(Movie *) movie {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/reviews?api_key=%@", movie.identifier, apiKey]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    DownloadMoviesHandler handler = ^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSMutableArray *reviwesList = [ReviewFactory initListWithData:responseObject];
            [_downloadReviewsProtocol reviewsListIsDownLoaded:reviwesList];
        }
    };
    
    
    NSURLSessionDataTask *dataTask = [_maneger dataTaskWithRequest:request completionHandler:handler];
    
    [dataTask resume];
}

- (void) getVideosUrlsForMovie:(Movie *) movie {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/videos?api_key=%@", movie.identifier, apiKey]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    DownloadMoviesHandler handler = ^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSMutableArray *videosList = [VideoFactory initListWithData:responseObject];
            [_downloadVideosProtocol videosListIsDownLoaded:videosList];
        }
    };
    
    
    NSURLSessionDataTask *dataTask = [_maneger dataTaskWithRequest:request completionHandler:handler];
    
    [dataTask resume];
}


@end
