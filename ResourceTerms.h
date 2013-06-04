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

/**
 * \brief Terms used for each resource.
 *
 * @author Pedro Cruz
 *
 */
@interface ResourceTerms : NSObject
/**
 * \enum ResourceTerm
 */
typedef enum ResourceTerm {
	FIND_POI,/**< The term for the search of a POI */
	FIND_POI_RELATION, /**< The term for the search of a POI through the use of relations */
	FIND_EVENT, /**< The term for the search of an Event */
    FIND_EVENT_RELATION, /**< The term for the search of an Event through the use of relations */
    FIND_ROUTE, /**< The term for the search of Routes */
	FIND_CATEGORIES, /**< The term for the search for the list of categories */
    FIND_TAGS, /**< The term for the search for the list of tags */
    LAST_RESOURCE /**< Not used */
} ResourceTerm;

/**
 * \enum ResourceType
 */
typedef enum ResourceType {
    POI_RESOURCES, /**< POI Resources */
    EVENT_RESOURCES, /**< Event Resources */
    ROUTE_RESOURCES, /**< Route Resources */
    CATEGORY_RESOURCES, /**< Category Resources */
    TAG_RESOURCES, /**< Tag Resources */
    LAST_TYPE /**< Not used */
} ResourceType;

+ (NSRange) getRange:(ResourceType) resource;
+ (NSString *) getResource:(ResourceTerm) resource;
+ (NSArray *) getResources;

@end
