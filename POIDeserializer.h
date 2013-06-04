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
#import "POI.h"
#import "POIS.h"
#import "Route.h"
#import "Category.h"
#import "ListTag.h"
#import "Resources.h"
#import "Deserializable.h"

typedef enum JsonTerms
{
    SPOI,
    EVENT,
    ROUTE,
    TOURISM,
    _LINKS,
    CATEGORIES,
    TAGS,
    TAG
} JsonTerms;

typedef enum POIBaseTerms
{
    ID,
    VALUE,
    HREF,
    TYPE,
    LANG,
    BASE,
    CREATED,
    UPDATED,
    DELETED,
    AUTHOR,
    LICENSE
} POIBaseTerms;

typedef enum POITermTypeTerms
{
    TERM,
    SCHEME
} POITermTypeTerms;

typedef enum POITypeTerms
{
    LABEL,
    DESCRIPTION,
    CATEGORY,
    TIME,
    LINK,
    LOCATION 
} POITypeTerms;

typedef enum LocationTerms
{
    POINT,
    POINT_P,
    LINE,
    LINE_STRING,
    POLYGON,
    SIMPLE_POLYGON,
    POS_LIST,
    ADDRESS,
    RELATIONSHIP,
    TARGET_POI,
    TARGET_EVENT
} LocationTerms;

@interface POIDeserializer : NSObject
- (void) parseJson:(NSDictionary *)json :(NSObject<Deserializable> **)POI;
@end
