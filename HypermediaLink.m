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

#import "HypermediaLink.h"

/**
 * \brief A HypermediaLink is a link in which a given client can make REST HTTP requests.
 * <p>It is composed of</p>
 * <ul>
 * <li>a version;</li>
 * <li>the available hypermedia links;</li>
 * </ul>
 * Some terminologies can be found in {@link ParameterTerms} (for parameters) and
 * {@link ResourceTerms} (for resources)
 *
 * @author Pedro Cruz
 *
 */
@implementation HypermediaLink
@synthesize version = _version;
@synthesize links = _links;

- (NSMutableDictionary *) links
{
    if(!_links)
        _links = [[NSMutableDictionary alloc] init];
    
    return _links;
}

/**
 * \brief Adds an {@link Hypermedia} with a given name.
 * @param link {@link Hypermedia} to be added.
 * @param name the name to associate the link.
 */
- (void) addHypermedia:(Hypermedia *) link withName:(NSString *) name
{
    if([self.links objectForKey:name] == nil)
        [self.links setObject:link forKey:name];
}

@end
