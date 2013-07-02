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
#import "Request.h"
#import "JsonParser.h"
#import "ParameterTerms.h"
#import "ParameterList.h"
#import "ListPointOfInterest.h"
#import "ListEvent.h"
#import "ListRoute.h"
#import "PointOfInterest.h"
#import "Event.h"
#import "Route.h"
#import "Category.h"
#import "ListTag.h"
#import "POI.h"
#import "Resources.h"
#import "ResourceTerms.h"
#import "UriTemplate.h"

@interface TourismClient : NSObject <NSCopying>
- (id) initWithResources:(Resources *) resources andHomeUrl:(NSString *)homeUrl;
- (void) setResources:(Resources *) resources andHomeUrl:(NSString *)homeUrl;
- (void) setVersion:(NSString *) version;

- (NSArray *) getAvailableResources:(NSError **) err;
- (BOOL) hasResource:(ResourceTerm) term :(NSError **) err;
- (BOOL) hasAnyResourcesOf:(ResourceType) type :(NSError **) err;
- (BOOL) hasResource:(ResourceTerm) term withParameter:(ParameterTerm) parameter :(NSError **) err;

- (ListPointOfInterest *) getPois:(ParameterList *)list :(NSError **) err;
- (ListEvent *) getEvents:(ParameterList *)list :(NSError **) err;
- (ListRoute *) getRoutes:(ParameterList *)list :(NSError **) err;
- (Category *) getCategories:(ParameterList *)list :(NSError **) err;
- (ListTag *) getTags:(ParameterList *)list :(NSError **) err;

- (PointOfInterest *) getPoi:(NSString *) poiBase withId:(NSString *) poiID :(NSError **) err;
- (Event *) getEvent:(NSString *) eventBase withID:(NSString *) eventID :(NSError **) err;
- (Route *) getRoute:(NSString *) routeBase withID:(NSString *) routeID :(NSError **) err;
- (POI *) getGeneric:(NSString *) base withID:(NSString *) baseID :(NSError **) err;

@end
