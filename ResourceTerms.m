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
#import "ResourceTerms.h"

@implementation ResourceTerms

NSString* const resourceTerm[] = {
    @"find-poi",
    @"find-poi-relation",
    @"find-event",
    @"find-event-relation",
    @"find-route",
    @"find-categories",
    @"find-tags"
};

NSRange const resourceType[] = {
    {0, 2},
    {2, 2},
    {4, 1},
    {5, 1},
    {6, 1}
};

/**
 * \brief Gets the range of the given resource type.
 * @param resource the wanted resource
 */
+ (NSRange) getRange:(ResourceType) resource
{
    if(resource < LAST_TYPE)
        return resourceType[resource];
    else
        return NSMakeRange(LAST_TYPE, 0);
}

/**
 * \brief Gets the string representation of the given resource.
 * @param resource the wanted resource
 */
+ (NSString *) getResource:(ResourceTerm) resource
{
    if(resource < LAST_RESOURCE)
        return resourceTerm[resource];
    else
        return @"";
}

/**
 * \brief Gets all the string representations.
 */
+ (NSArray *) getResources
{
    NSArray *array = [[NSArray alloc] initWithObjects:resourceTerm count:LAST_RESOURCE];
    return array;
}

@end
