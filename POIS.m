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

#import "POIS.h"

/**
 * \brief The representation of a list of {@link POI}.
 *
 * @author Pedro Cruz
 *
 */
@implementation POIS
@synthesize pois = _pois;

/**
 *\brief Gets all the {@link POI}s stored
 * @return an array of {@link POI}
 */
- (NSMutableArray *) pois
{
    if(!_pois)
        _pois = [[NSMutableArray alloc] init];
    
    return _pois;
}

/**
 * \brief Adds a {@link POI} to the list
 * @param poi the {@link POI} to be added
 */
- (void) addPOI: (POI *) poi
{
    [self.pois addObject:poi];
}

@end
