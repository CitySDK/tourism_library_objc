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

#import "Polygon.h"

/**
 * \brief Representation of the Polygon class of the UML Diagram found in:
 * <a target="_blank" href="http://www.w3.org/2010/POI/documents/Core/core-20111216.html#poi-data-model">http://www.w3.org/2010/POI/documents/Core/core-20111216.html#poi-data-model.</a>
 *
 * <p>A {@link Polygon} is a representation of a Represented by a {@link Geometry}, basically having three or more coordinates.</p>
 *
 * @author Pedro Cruz
 *
 */
@implementation Polygon
@synthesize simplePolygon = _simplePolygon;

- (Geometry *) simplePolygon
{
    if(!_simplePolygon)
        _simplePolygon = [[Geometry alloc] init];
    
    return _simplePolygon;
}
@end
