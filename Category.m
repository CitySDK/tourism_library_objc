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

#import "Category.h"

/**
 * \brief Representation of a {@link Category} object.
 *
 * <p>A {@link Category} is used to characterize {@link PointOfInterest}, {@link Event} or {@link Route}.
 * It can contain its own set of sub-categories.
 *
 * @author Pedro Cruz
 *
 */
@implementation Category
@synthesize subCategories = _subCategories;

/**
 * \brief Gets all the sub categories of the {@link Category}.
 * @return an array of {@link Category}.
 */
- (NSMutableArray *) subCategories
{
    if(!_subCategories)
        _subCategories = [[NSMutableArray alloc] init];
    
    return _subCategories;
}

/**
 * \brief Adds a {@link Category} to this {@link Category}.
 * @param category {@link Category} to be added.
 */
- (void) addCategory:(Category *) category
{
    [self.subCategories addObject:category];
}

/**
 * \brief Gets the category at a given index
 * @param index an index
 * @return the category at index index
 */
- (Category *) getCategory:(int) index
{
    return [self.subCategories objectAtIndex:index];
}

/**
 * \brief Gets the number of sub categories in the {@link Category}.
 * @return the total number of sub-categories.
 */
- (int) getNumCategories
{
    return [self.subCategories count];
}

/**
 * \brief Checks whether this {@link Category} has sub-categories.
 * @return <code>true</code> if it has sub-categories, <code>false</code> otherwise
 */
- (BOOL) hasSubCategories
{
    return [self.subCategories count] > 0;
}

@end
