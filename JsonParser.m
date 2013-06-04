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

#import "JsonParser.h"

@interface JsonParser()
- (NSError *) makeError:(NSString *)domain :(NSString *)errorValue :(int)code;
@end

/**
 \brief Parses a given JSON message.
 * <p>It allows the deserialization of:</p>
 * <ul>
 * <li>{@link PointOfInterest}, {@link Event}, {@link Route} and their listings;</li>
 * <li>{@link Resources}, {@link Category}, {@link Tag}.</li>
 * </ul>
 * @author pedrocruz
 *
 */
@implementation JsonParser
@synthesize deserializer = _deserializer;

- (POIDeserializer *) deserializer
{
    if(!_deserializer)
        _deserializer = [[POIDeserializer alloc] init];
    
    return _deserializer;
}

- (NSError *) makeError:(NSString *)domain :(NSString *)errorValue :(int)code;
{
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:errorValue forKey:NSLocalizedDescriptionKey];
    return [NSError errorWithDomain:domain code:code userInfo:details];
}

/**
 * \brief Parses the JSON as a {@link PointOfInterest}.
 * @param error contains information about any unforeseen errors.
 * @return a {@link PointOfInterest} containing the content of the JSON message.
 */
- (PointOfInterest *) parseJsonAsPointOfInterest:(NSError**)error
{
    NSError *err = nil;
    NSData *data = [self.json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &err];
    
    if(err != nil) {
        *error = [self makeError:@"malformed" :[err description] :1];
        return nil;
    } else {
        PointOfInterest *poi = [[PointOfInterest alloc] init];
        [self.deserializer parseJson:json :&poi];
        return poi;
    }
}

/**
 * \brief Parses the JSON as a {@link Event}.
 * @param error contains information about any unforeseen errors.
 * @return a {@link Event} containing the content of the JSON message.
 */
- (Event *) parseJsonAsEvent:(NSError**)error
{
    NSError *err = nil;
    NSData *data = [self.json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &err];
    
    if(err != nil) {
        *error = [self makeError:@"malformed" :[err description] :1];
        return nil;
    } else {
        Event *event = [[Event alloc] init];
        [self.deserializer parseJson:json: &event];
        return event;
    }
}

/**
 * \brief Parses the JSON as a {@link Route}.
 * @param error contains information about any unforeseen errors.
 * @return a {@link Route} containing the content of the JSON message.
 */
- (Route *) parseJsonAsRoute:(NSError**)error
{
    NSError *err = nil;
    NSData *data = [self.json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &err];
    
    if(err != nil) {
        *error = [self makeError:@"malformed" :[err description] :1];
        return nil;
    } else {
        Route *route = [[Route alloc] init];
        [self.deserializer parseJson:json: &route];
        return route;
    }
}

/**
 * \brief Parses the JSON as a {@link ListPointOfInterest}.
 * @param error contains information about any unforeseen errors.
 * @return a {@link ListPointOfInterest} containing the content of the JSON message.
 */
- (ListPointOfInterest *) parseJsonAsListOfPois:(NSError**)error
{
    NSError *err = nil;
    NSData *data = [self.json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &err];
    
    if(err != nil) {
        *error = [self makeError:@"malformed" :[err description] :1];
        return nil;
    } else {
        if(![json objectForKey:@"poi"]){
            *error = [self makeError:@"malformed" :@"Not a valid List of POIs Object" :2];
            return nil;
        } else {
            ListPointOfInterest *list = [[ListPointOfInterest alloc] init];
            [self.deserializer parseJson:json: &list];
            return list;
        }
    }
}

/**
 * \brief Parses the JSON as a {@link ListEvent}.
 * @param error contains information about any unforeseen errors.
 * @return a {@link ListEvent} containing the content of the JSON message.
 */
- (ListEvent *) parseJsonAsListOfEvents:(NSError**)error
{
    NSError *err = nil;
    NSData *data = [self.json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &err];
    
    if(err != nil) {
        *error = [self makeError:@"malformed" :[err description] :1];
        return nil;
    } else {
        if(![json objectForKey:@"event"]){
            *error = [self makeError:@"malformed" :@"Not a valid List of Events Object" :2];
            return nil;
        } else {
            ListEvent *list = [[ListEvent alloc] init];
            [self.deserializer parseJson:json: &list];
            return list;
        }
    }
}

/**
 * \brief Parses the JSON as a {@link ListRoute}.
 * @param error contains information about any unforeseen errors.
 * @return a {@link ListRoute} containing the content of the JSON message.
 */
- (ListRoute *) parseJsonAsListOfRoutes:(NSError**)error
{
    NSError *err = nil;
    NSData *data = [self.json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &err];
    
    if(err != nil) {
        *error = [self makeError:@"malformed" :[err description] :1];
        return nil;
    } else {
        if(![json objectForKey:@"routes"]){
            *error = [self makeError:@"malformed" :@"Not a valid List of Routes Object" :2];
            return nil;
        } else {
            ListRoute *list = [[ListRoute alloc] init];
            [self.deserializer parseJson:json: &list];
            return list;
        }
    }
}

/**
 * \brief Parses the JSON as {@link Resources}.
 * @param error contains information about any unforeseen errors.
 * @return a {@link Resources} containing the content of the JSON message.
 */
- (Resources *) parseJsonAsResources:(NSError**)error
{
    NSError *err = nil;
    NSData *data = [self.json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &err];

    if(err != nil) {
        *error = [self makeError:@"malformed" :[err description] :1];
        return nil;
    } else {
        if(![json objectForKey:@"citysdk-tourism"]){
            *error = [self makeError:@"malformed" :@"Not a valid Resources Object" :2];
            return nil;
        } else {
            Resources *resources = [[Resources alloc] init];
            [self.deserializer parseJson:json :&resources];
            return resources;
        }
    }
}

/**
 * \brief Parses the JSON as a {@link Category}.
 * @param error contains information about any unforeseen errors.
 * @return a {@link Category} containing the content of the JSON message.
 */
- (Category *) parseJsonAsCategory:(NSError**)error
{
    NSError *err = nil;
    NSData *data = [self.json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &err];
    
    if(err != nil) {
        *error = [self makeError:@"malformed" :[err description] :1];
        return nil;
    } else {
        if(![json objectForKey:@"categories"]){
            *error = [self makeError:@"malformed" :@"Not a valid Category Object" :2];
            return nil;
        } else {
            Category *category = [[Category alloc] init];
            [self.deserializer parseJson:json :&category];
            return category;
        }
    }
}

/**
 * \brief Parses the JSON as a {@link ListTag}.
 * @param error contains information about any unforeseen errors.
 * @return a {@link ListTag} containing the content of the JSON message.
 */
- (ListTag *) parseJsonAsTags:(NSError**)error
{
    NSError *err = nil;
    NSData *data = [self.json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &err];
    
    if(err != nil) {
        *error = [self makeError:@"malformed" :[err description] :1];
        return nil;
    } else {
        if(![json objectForKey:@"tags"]){
            *error = [self makeError:@"malformed" :@"Not a valid Tags Object" :2];
            return nil;
        } else {
            ListTag *list = [[ListTag alloc] init];
            [self.deserializer parseJson:json :&list];
            return list;
        }
    }
}

/**
 * \brief Parses the JSON as a generic {@link POI}.
 * @param error contains information about any unforeseen errors.
 * @return a {@link POI} containing the content of the JSON message.
 */
- (POI *) parseJsonAsGeneric:(NSError**)error
{
    NSError *err = nil;
    NSData *data = [self.json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &err];
    
    if(err != nil) {
        *error = [self makeError:@"malformed" :[err description] :1];
        return nil;
    } else {
        POI *poi = [[POI alloc] init];
        [self.deserializer parseJson:json :&poi];
        return poi;
    }
}

@end
