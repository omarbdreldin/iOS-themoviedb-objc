//
//  DatabaseManeger.h
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Movie.h"
#import "Review.h"
#import "DatabaseConfirmationProtocol.h"

@interface DatabaseManeger : NSObject

@property (strong , nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
@property id<DatabaseConfirmationProtocol> confirmationProtocol;

+ (DatabaseManeger *) sharedInstance;

- (void) initiateDatabase;
- (void) insertMovie:(Movie *) movie inList:(int) whichList;
- (NSMutableArray *) retreiveAllPopularMovies;
- (NSMutableArray *) retreiveAllTopRatedMovies;
- (void) deleteMovie:(Movie *) movie;
- (void) setMovieAsFavourite:(Movie *) movie;
- (NSMutableArray *) retreiveFavouriteMovies;

@end
