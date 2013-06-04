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

#import "Resources.h"

@implementation Resources
@synthesize resources = _resources;

- (NSMutableDictionary *) resources
{
    if (!_resources) {
        _resources = [[NSMutableDictionary alloc] init];
    }
    
    return _resources;
}

/**
 * \brief Adds a {@link HypermediaLink}.
 *
 * @param link the {@link HypermediaLink} to be added.
 */
- (void) addResource:(HypermediaLink *) link
{
    if(![self.resources objectForKey:link.version]) {
        [self.resources setValue:link forKey:link.version];
    }
}

/**
 * Checks the existance of a given version
 *
 * @param version version to check
 * @return <code>true</code> if it is available, <code>false</code> otherwise.
 */
- (bool) hasVersion:(NSString *) version
{
    return [self.resources objectForKey:version] != nil;
}

/**
 * Checks if this {@link Resource} has a given resource in a given version.
 *
 * @param version the version of the link
 * @param resource the resource to be found.
 * @return <code>true</code> if it has the given resource, <code>false</code> otherwise.
 */
- (bool) hasResource:(NSString *) resource inVersion:(NSString *) version
{
    HypermediaLink* hypermedia;
    if((hypermedia = [self.resources objectForKey:version]) != nil)
        return [hypermedia.links objectForKey:resource] != nil;
    
    return false;
}

/**
 * Checks whether a given resource in a given version allows the search
 * using a given parameter
 *
 * @param version the wanted version
 * @param resource the name of the resource
 * @param parameter the search parameter
 * @return <code>true</code> if it is allowed, <code>false</code> otherwise
 */
- (bool) hasResourceParameter:(NSString *) parameter inResource:(NSString *) resource inVersion:(NSString *) version
{
    return false;
}

/**
 * Gets the {@link HypermediaLink} with
 * the given version.
 *
 * @param version the version of the {@link HypermediaLink}.
 * @return the {@link HypermediaLink} corresponding to the given version or nil if the version is not available
 */
- (HypermediaLink *) getHypermediaWithVersion:(NSString *) version
{
    return [self.resources objectForKey:version];
}

/**
 * Gets all the resources of a given version
 *
 * @param version the wanted version
 * @return a set of resources of the given version
 */
- (NSArray *) getResources:(NSString *) version
{
    HypermediaLink* links;
    links = [self.resources objectForKey:version];
    return [links.links allKeys];
}

/**
 * Gets all the versions stored
 *
 * @return a set of versions
 */
- (NSArray *) getVersions
{
    return [self.resources allKeys];
}

@end
