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

#import "Route.h"

/**
 * \brief A simple representation of a {@link Route}.
 * <p>A {@link Route} is a set of {@link PointOfInterest} ordered by a given theme - represented by a {@link ListPointOfInterest}.</p>
 *
 * @author Pedro Cruz
 *
 */
@implementation Route
@synthesize pois = _pois;

/**
 * \brief Gets the {@link ListPointOfInterest} of the {@link Route}.
 * @return the {@link ListPointOfInterest} of the {@link Route}.
 */
- (ListPointOfInterest *) pois
{
    if(!_pois)
        _pois = [[ListPointOfInterest alloc] init];
    
    return _pois;
}

/**
 * \brief Adds a {@link PointOfInterest} to the {@link Route}.
 * @param poi the {@link PointOfInterest} to be added.
 */
- (void) addPoi:(PointOfInterest *)poi
{
    [self.pois addPoi:poi];
}

/**
 * \brief Gets the number of {@link PointOfInterest}s that the {@link Route} has.
 * @return the number of total {@link PointOfInterest}.
 */
- (int) getNumPois
{
    return [self.pois getNumPois];
}

/**
 * \brief Gets the {@link PointOfInterest} in a given index of a {@link Route}.
 * @param i the index of the {@link PointOfInterest}.
 * @return the {@link PointOfInterest} stored in the index.
 */
- (PointOfInterest *) getPoi:(int) i
{
    return [self.pois getPoi:i];
}
@end
