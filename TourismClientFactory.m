/*
 * COPYRIGHT NOTICE:
 *
 * This file is part of CitySDK WP5 Tourism Objective-C Library.
 *
 * CitySDK WP5 Tourism Objective-C Library is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * CitySDK WP5 Tourism Objective-C Library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with CitySDK WP5 Tourism Objective-C Library. If not, see <http://www.gnu.org/licenses/>.
 *
 * Copyright 2013, IST
 */

#import "TourismClientFactory.h"

@interface TourismClientFactory()
@property (nonatomic, retain) NSMutableDictionary *loadedUrls;
@property (readonly, retain) JsonParser *parser;

- (TourismClient *) initializeClient:(NSString *)homeUrl :(NSError **)err;
@end

/**
 * \brief Factory class allowing the creation of a {@link TourismClient}. For each link, it makes
 * only one HTTP call, fills a {@link TourismClient}, returns it and saves it. In future creations,
 * it verifies if it was already called and if positive returns the result without making
 * a new HTTP call.
 *
 * @author Pedro Cruz
 *
 */
@implementation TourismClientFactory
@synthesize parser = _parser;
@synthesize loadedUrls = _loadedUrls;

- (JsonParser *) parser
{
    if(!_parser)
        _parser = [[JsonParser alloc] init];
    
    return _parser;
}

- (NSMutableDictionary *) loadedUrls
{
    if(!_loadedUrls)
        _loadedUrls = [[NSMutableDictionary alloc] init];
    
    return _loadedUrls;
}

/**
 * \brief Gets the instance of this factory.
 * @return the singleton instance of {@link TourismClientFactory}.
 */
+ (TourismClientFactory*)getInstance
{
    static TourismClientFactory *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TourismClientFactory alloc] init];
    });
    return instance;
}

/**
 * \brief Gets a new {@link TourismClient} stub.
 * @param homeUrl the entrypoint of the home URL to query.
 * @param err set when one of the following errors occur:
 * <ul>
 * <li>in case of socket errors;</li>
 * <li>in case of unforeseen errors;</li>
 * <li>if the server returns a code different from HTTP 200 OK.</li>
 */
- (TourismClient *) getClient:(NSString *)homeUrl :(NSError **)err;
{
    TourismClient *client;
    if([self.loadedUrls objectForKey:homeUrl] == nil) {
        client = [self initializeClient:homeUrl :err];
        [self.loadedUrls setValue:client forKey:homeUrl];
    } else {
        client = [[self.loadedUrls objectForKey:homeUrl] copy];
    }
    
    return client;
}

- (TourismClient *) initializeClient:(NSString *)homeUrl :(NSError **)err
{
    NSError *error;
    self.parser.json = [Request getResponse:homeUrl :&error];
    if([[error domain] isEqual: @"HTTP error"]) {
        *err = [NSError errorWithDomain:[error domain] code:error.code userInfo:error.userInfo];
        return nil;
    }
    
    Resources *resources = [self.parser parseJsonAsResources:&error];
    return [[TourismClient alloc] initWithResources:resources andHomeUrl:homeUrl];
}

@end
