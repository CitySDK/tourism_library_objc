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

#import "POIBaseType.h"
#import "POITermType.h"

@interface POIType : POIBaseType
@property (readonly, retain) NSMutableArray *label; /**< \brief a human-readable name. Multiple names are used for synonyms and multiple languages */
@property (readonly, retain) NSMutableArray *poiDescription; /**< \brief a human-readable description that can be discriminated with the language attribute */
@property (readonly, retain) NSMutableArray *category; /**< \brief a categorical classification */
@property (readonly, retain) NSMutableArray *time; /**< \brief a fixed time or sequence of times using iCalendar */
@property (readonly, retain) NSMutableArray *link; /**< \brief a link to another POI or web resource */

- (void) addLabel:(POITermType *)label;
- (void) addDescription:(POITermType *)description;
- (void) addCategory:(POITermType *)category;
- (void) addTime:(POITermType *)time;
- (void) addLink:(POITermType *)link;

- (BOOL) hasLabels;
- (BOOL) hasDescriptions;
- (BOOL) hasCategories;
- (BOOL) hasTimes;
- (BOOL) hasLinks;

@end
