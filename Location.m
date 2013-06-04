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

#import "Location.h"
#import "POIBaseType.h"

/**
 * \brief Representation of the {@link Location} class of the UML diagram found in:
 * <a target="_blank" href="http://www.w3.org/2010/POI/documents/Core/core-20111216.html#poi-data-model">http://www.w3.org/2010/POI/documents/Core/core-20111216.html#poi-data-model.</a>
 *
 * <p>A {@link Location} is composed of:</p>
 * <ul>
 * <li>a group of {@link GeoPoint}, {@link Line}, {@link Polygon} representing the {@link Location}'s Geometry (such as: entry/exit points);</li>
 * <li>a group of {@link Relationship} representing the relationship of this {@link Location} with other {@link PointOfInterest} or {@link Event};</li>
 * <li>address representing the civic address of the {@link Location} in vCard format.</li>
 * </ul>
 *
 * @author Pedro Cruz
 *
 */
@implementation Location
@synthesize point = _point;
@synthesize line = _line;
@synthesize polygon = _polygon;
@synthesize relationship = _relationship;
@synthesize address = _address;

/**
 * \brief Gets the address of the {@link Location}.
 * @return the address of the {@link Location}.
 */
- (POIBaseType *) address
{
    if(!_address)
        _address = [[POIBaseType alloc] init];
    
    return _address;
}

/**
 * \brief Gets all points of the {@link Location}.
 * @return an array of {@link GeoPoint} of the {@link Location}.
 */
- (NSMutableArray *)point
{
    if(!_point)
        _point = [[NSMutableArray alloc] init];
    
    return _point;
}

/**
 * \brief Gets all lines of the {@link Location}.
 * @return an array of {@link Line} of the {@link Location}.
 */
- (NSMutableArray *)line
{
    if(!_line)
        _line = [[NSMutableArray alloc] init];
    
    return _line;
}

/**
 * \brief Gets all the polygons of the {@link Location}.
 * @return an array of {@link Polygon} of the {@link Location}.
 */
- (NSMutableArray *)polygon
{
    if(!_polygon)
        _polygon = [[NSMutableArray alloc] init];
    
    return _polygon;
}

/**
 * \brief Gets all the relationships of the {@link Location}.
 * @return an array of {@link Relationship} of the {@link Location}.
 */
- (NSMutableArray *)relationship
{
    if(!_relationship)
        _relationship = [[NSMutableArray alloc] init];
    
    return _relationship;
}

/**
 * \brief Adds a {@link Point} to the {@link Location}.
 * @param point the {@link GeoPoint} to be added.
 */
- (void) addPoint:(GeoPoint *)point
{
    [self.point addObject:point];
}

/**
 * \brief Adds a {@link Line} to the {@link Location}.
 * @param line the {@link Line} to be added.
 */
- (void) addLine:(Line *)line
{
    [self.line addObject:line];
}

/**
 * \brief Adds a {@link Polygon} to the {@link Location}.
 * @param polygon the {@link Polygon} to be added.
 */
- (void) addPolygon:(Polygon *)polygon
{
    [self.polygon addObject:polygon];
}

/**
 * \brief Adds a {@link Relationship} to the {@link Location}.
 * @param relationship the {@link Relationship} to be added.
 */
- (void) addRelationship:(Relationship *)relationship
{
    [self.relationship addObject:relationship];
}

/**
 * \brief Checks if the {@link Location} has any points.
 * @return <code>true</code> if there are points in the {@link Location}, <code>false</code> otherwise.
 */
- (BOOL) hasPoints
{
    return [self.point count] > 0;
}

/**
 * \brief Checks if the {@link Location} has any lines.
 * @return <code>true</code> if there are lines in the {@link Location}, <code>false</code> otherwise
 */
- (BOOL) hasLines
{
    return [self.line count] > 0;
}

/**
 * \brief Checks if the {@link Location} has any polygons.
 * @return <code>true</code> if there are polygons in the {@link Location}, <code>false</code> otherwise
 */
- (BOOL) hasPolygons
{
    return [self.polygon count] > 0;
}

/**
 * \brief Checks if the {@link Location} has any relationships.
 * @return <code>true</code> if there are relationships in the {@link Location}, <code>false</code> otherwise
 */
- (BOOL) hasRelationships
{
    return [self.relationship count] > 0;
}

@end
