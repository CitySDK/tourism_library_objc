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

#import "POI.h"

/**
 * \brief A base class for {@link PointOfInterest}, {@link Event}, {@link Route} and {@link POIS}.
 * <p>A {@link POI} is a {@link POIType} which stores a {@link Location}.</p>
 *
 * @author Pedro Cruz
 *
 */
@implementation POI
@synthesize location = _location;

- (Location *) location
{
    if(!_location)
        _location = [[Location alloc] init];
    
    return _location;
}

/**
 * \brief Checks whether the {@link POI} has an address associated
 * @return <code>true</code> if it has an address, <code>false</code> otherwise
 */
- (BOOL) hasAdddress
{
    return (self.location.address.type != nil)
            && (self.location.address.value != nil);
}

@end
