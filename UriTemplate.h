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
#import <Foundation/Foundation.h>
#import "Operator.h"

@interface UriTemplate : NSObject
@property (nonatomic, copy) NSString *template;
@property (nonatomic, retain) NSMutableDictionary *values;

+ (UriTemplate *) fromTemplate:(NSString *) template;
- (void) set:(NSString *) name withValue:(id) value;
- (BOOL) hasParameter:(NSString *) parameter;
- (NSString *) build;
@end
