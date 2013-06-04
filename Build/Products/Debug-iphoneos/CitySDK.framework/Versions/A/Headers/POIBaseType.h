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
@class POITermType;

@interface POIBaseType : NSObject
@property (nonatomic, copy) NSString *baseID; /**< \brief a unique identifier for this POI. Can be a URI fragment */
@property (nonatomic, copy) NSString *value; /**< \brief the information content */
@property (nonatomic, copy) NSString *href; /**< \brief an absolute reference to the content type */
@property (nonatomic, copy) NSString *type; /**< \brief MIME type */
@property (nonatomic, copy) NSString *lang; /**< \brief language type */
@property (nonatomic, copy) NSString *base; /**< \brief base URI */
@property (nonatomic, retain) NSDate *created; /**< \brief time at which this POIBaseType was created */
@property (nonatomic, retain) NSDate *updated; /**< \brief time at which this POIBaseType was updated */
@property (nonatomic, retain) NSDate *deleted; /**< \brief time at which this POIBaseType was deleted */
@property (nonatomic, retain) POITermType *author; /**< \brief the author of this POIBaseType */
@property (nonatomic, retain) POITermType *license; /**< \brief the license restrictions of this information */
@end
