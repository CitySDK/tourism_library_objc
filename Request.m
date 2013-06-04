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

#import "Request.h"

@implementation Request

+ (NSString *) getResponse:(NSString *)URL :(NSError **) err;
{
    NSString *responseString = nil;
    NSHTTPURLResponse *resp = nil;
    NSError *error = nil;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URL]];
    
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSData *response = [NSURLConnection sendSynchronousRequest: request returningResponse: &resp error: &error];
    
    if([resp statusCode] == 200) {
        responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    } else {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        NSString *value = [NSString stringWithFormat:@"Server returned with error: %d", [resp statusCode]];
        [details setValue:value forKey:NSLocalizedDescriptionKey];
        *err = [NSError errorWithDomain:@"HTTP error" code:3 userInfo:details];
    }
    
    return responseString;
}

@end
