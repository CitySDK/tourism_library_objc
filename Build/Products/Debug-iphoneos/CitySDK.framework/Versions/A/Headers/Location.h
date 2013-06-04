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
#import "GeoPoint.h"
#import "Line.h"
#import "Polygon.h"
#import "Relationship.h"

@interface Location : POIBaseType
@property (readonly, retain) NSMutableArray *point;
@property (readonly, retain) NSMutableArray *line;
@property (readonly, retain) NSMutableArray *polygon;
@property (readonly, retain) POIBaseType *address;
@property (readonly, retain) NSMutableArray *relationship;

- (void) addPoint:(GeoPoint *)point;
- (void) addLine:(Line *)line;
- (void) addPolygon:(Polygon *)polygon;
- (void) addRelationship:(Relationship *)relationship;

- (BOOL) hasPoints;
- (BOOL) hasLines;
- (BOOL) hasPolygons;
- (BOOL) hasRelationships;

@end
