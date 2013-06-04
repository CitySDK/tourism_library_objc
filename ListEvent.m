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

#import "ListEvent.h"

/**
 * \brief Represents a list of {@link Event}.
 *
 * @author Pedro Cruz
 *
 */
@implementation ListEvent

/**
 * \brief Adds an {@link Event}.
 * @param event the {@link Event} to be added.
 */
- (void) addEvent:(Event *) event
{
    [self.pois addObject:event];
}

/**
 * \brief Gets all the events.
 * @return an array of {@link Event}.
 */
- (NSMutableArray *) getEvents
{
    return self.pois;
}

/**
 * \brief Gets a given {@link Event}.
 * @param index the index of the {@link Event}
 * @return the event stored within the given index.
 */
- (Event *) getEvent:(int) index
{
    return [self.pois objectAtIndex:index];
}

/**
 * \brief Returns the number of events stored.
 * @return the total number of events.
 */
- (int) getNumEvents
{
    return [self.pois count];
}

@end
