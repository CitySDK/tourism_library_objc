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

#import "ParameterTerms.h"

NSString* const parameterTerms[] = {
    @"base",
    @"id",
    @"tag",
    @"category",
    @"complete",
    @"minimal",
    @"relation",
    @"coords",
    @"list",
    @"offset",
    @"code",
    @"event",
    @"limit",
    @"route",
    @"time"
};

@implementation ParameterTerms
/**
 * \brief Gets the string representation of the given term.
 * @param term the wanted term
 */
+ (NSString *) getTerm:(ParameterTerm) term
{
    if(term < LAST_PARAMETER)
        return parameterTerms[term];
    else
        return @"";
}

/**
 * \brief Gets all the string representations.
 */
+ (NSArray *) getTerms
{
    NSArray *array = [[NSArray alloc] initWithObjects:parameterTerms count:LAST_PARAMETER];
    return array;
}

@end
