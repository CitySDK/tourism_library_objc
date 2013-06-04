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

#import <Foundation/Foundation.h>

#import "PointOfInterest.h"
#import "Event.h"
#import "Route.h"
#import "ListPointOfInterest.h"
#import "ListEvent.h"
#import "ListRoute.h"
#import "ListTag.h"
#import "Category.h"
#import "POI.h"
#import "POIDeserializer.h"

@interface JsonParser : NSObject
/**
 * \brief The JSON to parse
 */
@property (nonatomic, copy) NSString *json;
/**
 * \brief JSON deserializer
 */
@property (readonly, retain) POIDeserializer *deserializer;

- (Resources *) parseJsonAsResources:(NSError**)error;
- (PointOfInterest *) parseJsonAsPointOfInterest:(NSError**)error;
- (Event *) parseJsonAsEvent:(NSError**)error;
- (Route *) parseJsonAsRoute:(NSError**)error;
- (ListPointOfInterest *) parseJsonAsListOfPois:(NSError**)error;
- (ListEvent *) parseJsonAsListOfEvents:(NSError**)error;
- (ListRoute *) parseJsonAsListOfRoutes:(NSError**)error;
- (Category *) parseJsonAsCategory:(NSError**)error;
- (ListTag *) parseJsonAsTags:(NSError**)error;
- (POI *) parseJsonAsGeneric:(NSError**)error;

@end
