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

#import "ImageContent.h"

/**
 * \brief Container of an image. It can be either the byte-code (base64) of the image
 * or a URI of the image.
 *
 * @author Pedro Cruz
 *
 */
@implementation ImageContent
/**
 * \brief Initializes with a given content
 */
- (id) initWithContent:(NSString *) content andIsUri:(BOOL) isUri;
{
    self = [super init];
    if(self){
        self.content = content;
        self.imgUri = isUri;
        self.byteCode = !isUri;
    }
    
    return self;
}

- (NSString *) description
{
    return [self.content description];
}

@end
