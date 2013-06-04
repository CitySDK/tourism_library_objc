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

#import "ListRoute.h"

/**
 * \brief Represents a list of {@link Route}.
 *
 * @author Pedro Cruz
 *
 */
@implementation ListRoute
/**
 * \brief Adds a {@link Route}.
 * @param route the {@link Route} to be added.
 */
- (void) addRoute:(Route *) route
{
    [self.pois addObject:route];
}

/**
 * \brief Gets all the routes.
 * @return an array of {@link Route}.
 */
- (NSMutableArray *) getRoutes
{
    return self.pois;
}

/**
 * \brief Gets a given {@link Route}.
 * @param index the index of the {@link Route}.
 * @return the {@link Route} in the given index.
 */
- (Route *) getRoute:(int) index
{
    return [self.pois objectAtIndex:index];
}

/**
 * \brief Returns the number of routes stored.
 * @return the total number of routes.
 */
- (int) getNumRoutes
{
    return [self.pois count];
}
@end
