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

#import "ListPointOfInterest.h"

/**
 * \brief Represents a list of {@link PointOfInterest}.
 *
 * @author Pedro Cruz
 *
 */
@implementation ListPointOfInterest

/**
 * \brief Adds a {@link PointOfInterest}.
 * @param poi the {@link PointOfInterest} to be added.
 */
- (void) addPoi:(PointOfInterest *) poi
{
    [self.pois addObject:poi];
}

/**
 * \brief Gets all the POIs.
 * @return an array of {@link PointOfInterest}.
 */
- (NSMutableArray *) getPois
{
    return self.pois;
}

/**
 * \brief Gets a given {@link PointOfInterest}.
 * @param index the index of the {@link PointOfInterest}.
 * @return the {@link PointOfInterest} stored within the given index.
 */
- (PointOfInterest *) getPoi:(int) index
{
    return [self.pois objectAtIndex:index];
}

/**
 * \brief Returns the number of POIs stored
 * @return the total number of POIs
 */
- (int) getNumPois
{
    return [self.pois count];
}

@end
