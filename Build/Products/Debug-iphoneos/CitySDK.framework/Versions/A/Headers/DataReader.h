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
#import "Terms.h"
#import "Tag.h"
#import "ListTag.h"
#import "ImageContent.h"
#import "PointContent.h"
#import "LineContent.h"
#import "PolygonContent.h"

@interface DataReader : NSObject
typedef enum field {
    FIELD_LABELS,
    FIELD_DESCRIPTIONS
} Field;

+ (void) setDefaultLocale: (NSLocale *) locale;
+ (NSDictionary *) getAvailableLangs: (POI *)poi fromField:(Field) field;
+ (NSString *) getLabel: (POI *)poi withTerm: (Term)term andLocale: (NSLocale *)locale;
+ (NSString *) getDescription: (POI *)poi withLocale: (NSLocale *)locale;
+ (NSString *) getPrice: (POI *)poi withLocale: (NSLocale *)locale;
+ (NSString *) getWaitingTime: (POI *)poi;
+ (NSString *) getOccupation: (POI *)poi;
+ (NSArray *) getThumbnails: (POI *)poi;
+ (NSArray *) getLocationGeometry: (POI *)poi withTerm: (Term)term;
+ (NSArray *) getLocationPoint: (POI *)poi withTerm: (Term)term;
+ (NSArray *) getLocationLine: (POI *)poi withTerm: (Term)term;
+ (NSArray *) getLocationPolygon: (POI *)poi withTerm: (Term)term;
+ (NSString *) getContacts: (POI *)poi;
+ (NSString *) getCalendar: (POI *)poi withTerm: (Term)term;
+ (NSArray *) getImagesUri: (POI *)poi;
+ (NSString *) getRelationshipBase: (POI *)poi withTerm: (Term)term;
+ (NSString *) getRelationshipId: (POI *)poi withTerm: (Term)term;
+ (NSString *) getLink: (POI *)poi withTerm: (Term)term;
+ (NSArray *) getTags: (ListTag *)tags withLocale: (NSLocale *)locale;
@end
