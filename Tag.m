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

#import "Tag.h"

/**
 * \brief Representation of a {@link Tag} object.
 *
 * <p>A {@link Tag} is used to characterize {@link PointOfInterest}, {@link Event} or {@link Route}.</p>
 *
 * @author Pedro Cruz
 *
 */
@implementation Tag
@synthesize tags = _tags;

/**
 * \brief Gets all the tags.
 * @return a list of {@link Tag} values
 */
- (NSMutableArray *) tags
{
    if(!_tags)
        _tags = [[NSMutableArray alloc] init];
    
    return _tags;
}

/**
 * \brief Adds a {@link Tag} value
 * @param tag {@link Tag} value to be added
 */
- (void) addTag:(Tag *) tag
{
    [self.tags addObject:tag];
}

/**
 * \brief Gets the {@link Tag} in index i
 * @param i the {@link Tag} index
 * @return the {@link Tag} at index i or null
 */
- (Tag *) getTag:(int) i
{
    return [self.tags objectAtIndex:i];
}

/**
 * \brief Gets the number of {@link Tag} values
 * @return the total number of {@link Tag} values
 */
- (int) getNumTags
{
    return [self.tags count];
}

@end
