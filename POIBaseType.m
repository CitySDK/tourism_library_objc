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

#import "POIBaseType.h"
#import "POITermType.h"

/**
 * \brief Representation of the POIBaseType class of the UML diagram found in:
 * <a target="_blank" href="http://www.w3.org/2010/POI/documents/Core/core-20111216.html#poi-data-model">http://www.w3.org/2010/POI/documents/Core/core-20111216.html#poi-data-model.</a>
 *
 * <p>This is the base class of other classes. 
 *
 * @author Pedro Cruz
 *
 */
@implementation POIBaseType
@synthesize author = _author;
@synthesize license = _license;

- (POITermType *) author
{
    if(!_author)
        _author = [[POITermType alloc] init];
    
    return _author;
}

- (POITermType *) license
{
    if(!_license)
        _license = [[POITermType alloc] init];
    
    return _license;
}

- (void) author:(POITermType *) author
{
    self.author = author;
}

- (void) license:(POITermType *) license
{
    self.license = license;
}

@end
