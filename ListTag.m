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

#import "ListTag.h"

/**
 * \brief Represents a list of {@link Tag}.
 *
 * @author Pedro Cruz
 *
 */
@implementation ListTag
/**
 * \brief Adds a {@link Tag}
 * @param tag the {@link Tag} to be added
 */
- (void) addTag:(Tag *) tag
{
    [self.pois addObject:tag];
}

/**
 * \brief Gets all the tags
 * @return the list of {@link Tag}
 */
- (NSMutableArray *) getTags
{
    return self.pois;
}

/**
 * \brief Gets a given {@link Tag}
 * @param i the index of the {@link Tag}
 * @return the {@link Tag} stored within the given index.
 */
- (Tag *) getTag:(int) i
{
    return [self.pois objectAtIndex:i];
}

/**
 * \brief Returns the number of tags stored
 * @return the total number of tags
 */
- (int) getNumTags
{
    return [self.pois count];
}

@end
