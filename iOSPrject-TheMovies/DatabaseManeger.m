//
//  DatabaseManeger.m
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import "DatabaseManeger.h"

@implementation DatabaseManeger


# pragma mark - Singelton implementation

static DatabaseManeger *sharedInstance;

+ (DatabaseManeger *) sharedInstance {
    
    return [[DatabaseManeger alloc] init];
}

-(instancetype)init {
    if (sharedInstance) {
        return sharedInstance;
    }
    return sharedInstance = [super init];
}

# pragma mark - Initiate the dabase and create tables

- (void) initiateDatabase {
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"movies.db"]];
    
    
    const char *dbpath = [_databasePath UTF8String];
    
    // Create the movies table
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        char *errMsg;                    // (identifier, title, posterUrl, overview, voteAverage, popularity, releaseYear, isFavourite, whichList)
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS movies (identifier TEXT PRIMARY KEY, title TEXT, posterUrl TEXT, overview TEXT, voteAverage REAL, popularity REAL, releaseYear REAL, isFavourite REAL, whichList INTEGER)";
        
        if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            // failed to create
        }
        sqlite3_close(_contactDB);
        [_confirmationProtocol databaseDidInitiate];
        
    } else {
        // failed to open or create
    }
    
    // Create the reviews table
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS reviews (identifier TEXT, author TEXT, content TEXT)";
        
        if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            // failed to create
        }
        sqlite3_close(_contactDB);
        
    } else {
        // failed to open or create
    }
    
    // Create the videos table
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS videos (identifier TEXT, videoUrl TEXT)";
        
        if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            // failed to create
//            NSLog(@"failed to create");
        }
        sqlite3_close(_contactDB);
        
    } else {
        // failed to open or create
//        NSLog(@"failed to open or create");
    }
}

# pragma mark - Movie CRUD operatiosns

- (void) insertMovie:(Movie *)movie inList:(int)whichList{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO movies (identifier, title, posterUrl, overview, voteAverage, popularity, releaseYear, isFavourite, whichList) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",
                               movie.identifier, movie.title, movie.posterUrl, movie.overview, movie.voteAverage, movie.popularity, movie.releaseYear, movie.isFavourite, [NSNumber numberWithInt:whichList]];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
//            NSLog(@"done saving");
            [_confirmationProtocol managerDidSave];
        } else {
//            NSLog(@"failed saving");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    
    
}

- (NSMutableArray *) retreiveAllPopularMovies {
    
    NSMutableArray *moviesList;
    Movie *movie;
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = @"SELECT * FROM movies WHERE whichList == 0 ORDER BY popularity desc";
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            moviesList = [NSMutableArray new];
            
            while (sqlite3_step(statement) != SQLITE_DONE)
            {
                
                movie = [Movie new];
                
                movie.identifier = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                movie.title = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                movie.posterUrl = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                movie.overview = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                
                movie.voteAverage = [NSNumber numberWithDouble: sqlite3_column_double(statement, 4)];
                
                movie.popularity = [NSNumber numberWithDouble: sqlite3_column_double(statement, 5)];
                
                movie.releaseYear = [NSNumber numberWithDouble: sqlite3_column_double(statement, 6)];
                
                movie.isFavourite = [NSNumber numberWithDouble: sqlite3_column_double(statement, 7)];
                
                [moviesList addObject:movie];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    
    
    return moviesList;
}

- (NSMutableArray *) retreiveAllTopRatedMovies {
    
    NSMutableArray *moviesList;
    Movie *movie;
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = @"SELECT * FROM movies WHERE whichList == 1 ORDER BY voteAverage desc";
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            moviesList = [NSMutableArray new];
            
            while (sqlite3_step(statement) != SQLITE_DONE)
            {
                
                movie = [Movie new];
                
                movie.identifier = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                movie.title = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                movie.posterUrl = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                movie.overview = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                
                movie.voteAverage = [NSNumber numberWithDouble: sqlite3_column_double(statement, 4)];
                
                movie.popularity = [NSNumber numberWithDouble: sqlite3_column_double(statement, 5)];
                
                movie.releaseYear = [NSNumber numberWithDouble: sqlite3_column_double(statement, 6)];
                
                movie.isFavourite = [NSNumber numberWithDouble: sqlite3_column_double(statement, 7)];
                
                [moviesList addObject:movie];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    
    
    return moviesList;
}

- (void) deleteMovie:(Movie *)movie {
    
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        
        NSString *deleteSQL = [NSString stringWithFormat: @"DELETE FROM movies WHERE identifier = \"%@\"", movie.identifier];
        
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, delete_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
//            NSLog(@"deleted");
        } else {
//            NSLog(@"failed deleting");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }

}

-(void)setMovieAsFavourite:(Movie *)movie{

    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        
        NSString *deleteSQL = [NSString stringWithFormat: @"UPDATE movies SET isFavourite = \"%@\" WHERE identifier = \"%@\"", movie.isFavourite, movie.identifier];
//        NSLog(@"%@", movie.isFavourite);
        
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, delete_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
//            NSLog(@"updated");
        } else {
//            NSLog(@"failed updating");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
}

- (NSMutableArray *) retreiveFavouriteMovies {
    
    NSMutableArray *moviesList;
    Movie *movie;
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = @"SELECT * FROM movies WHERE isFavourite = 1";
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            moviesList = [NSMutableArray new];
            
            while (sqlite3_step(statement) != SQLITE_DONE)
            {
                
                movie = [Movie new];
                
                movie.identifier = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                movie.title = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                movie.posterUrl = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                movie.overview = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                
                movie.voteAverage = [NSNumber numberWithDouble: sqlite3_column_double(statement, 4)];
                
                movie.popularity = [NSNumber numberWithDouble: sqlite3_column_double(statement, 5)];
                
                movie.releaseYear = [NSNumber numberWithDouble: sqlite3_column_double(statement, 6)];
                
                movie.isFavourite = [NSNumber numberWithDouble: sqlite3_column_double(statement, 7)];
                
                [moviesList addObject:movie];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    
    
    return moviesList;
}

@end
