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

#import "PolygonContent.h"

/**
 * \brief Container of a polygon. A polygon is no more than a list of {@link LocationContent}.
 *
 * @author Pedro Cruz
 *
 */
@implementation PolygonContent
@synthesize values = _values;
- (NSMutableArray *) values
{
    if(!_values)
        _values = [[NSMutableArray alloc] init];
    
    return _values;
}

/**
 * \brief Adds a location to the polygon
 * @param location the location to be added
 */
- (void) addLocation:(LocationContent *)location
{
    [self.values addObject:location];
}

- (int) getNumGeo
{
    return [self.values count];
}
@end
