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

#import "POIType.h"

/**
 * \brief Representation of the POIType class of the UML Diagram found in:
 * <a target="_blank" href="http://www.w3.org/2010/POI/documents/Core/core-20111216.html#poi-data-model">http://www.w3.org/2010/POI/documents/Core/core-20111216.html#poi-data-model.</a>
 *
 * <p>The {@link POIType} entity is an abstract entity derived from {@link POIBaseType} and adds entities
 * for describing, labeling, categorizing and indicating the time span of a POI or group of POIs.
 * The entity also incudes child entities for linking to other POIs, external web resources or
 * metadata.</p>
 *
 * @author Pedro Cruz
 *
 */
@implementation POIType
@synthesize label = _label;
@synthesize poiDescription = _description;
@synthesize category = _category;
@synthesize time = _time;
@synthesize link = _link;

- (NSMutableArray *)label
{
    if(!_label)
        _label = [[NSMutableArray alloc] init];
    
    return _label;
}

- (NSMutableArray *)poiDescription
{
    if(!_description)
        _description = [[NSMutableArray alloc] init];
    
    return _description;
}

- (NSMutableArray *)category
{
    if(!_category)
        _category = [[NSMutableArray alloc] init];
    
    return _category;
}

- (NSMutableArray *)time
{
    if(!_time)
        _time = [[NSMutableArray alloc] init];
    
    return _time;
}

- (NSMutableArray *)link
{
    if(!_link)
        _link = [[NSMutableArray alloc] init];
    
    return _link;
}

/**
 * \brief Adds a category to the POIType.
 * @param category the category to be added.
 */
- (void) addCategory:(POITermType *)category
{
    [self.category addObject:category];
}

/**
 * \brief Adds a description to the POIType.
 * @param description the description to be added.
 */
- (void) addDescription:(POITermType *)description
{
    [self.poiDescription addObject:description];
}

/**
 * \brief Adds a label to the POIType.
 * @param label the label to be added.
 */
- (void) addLabel:(POITermType *)label
{
    [self.label addObject:label];
}

/**
 * \brief Adds a link to the POIType.
 * @param link the link to be added.
 */
- (void) addLink:(POITermType *)link
{
    [self.link addObject:link];
}

/**
 * \brief Adds a time to the POIType.
 * @param time the time to be added.
 */
- (void) addTime:(POITermType *)time
{
    [self.time addObject:time];
}

/**
 * \brief Checks if there are categories in the POIType.
 * @return <code>true</code> if there are categories in the POIType, <code>false</code> otherwise
 */
- (BOOL) hasCategories
{
    return [self.category count] > 0;
}

/**
 * \brief Checks if there are descriptions in the POIType.
 * @return <code>true</code> if there are descriptions in the POIType, <code>false</code> otherwise.
 */
- (BOOL) hasDescriptions
{
    return [self.poiDescription count] > 0;
}

/**
 * \brief Checks if there are labels in the POIType.
 * @return <code>true</code> if there are labels in the POIType, <code>false</code> otherwise
 */
- (BOOL) hasLabels
{
    return [self.label count] > 0;
}

/**
 * \brief Checks if there are links in the POIType.
 * @return <code>true</code> if there are links in the POIType, <code>false</code> otherwise.
 */
- (BOOL) hasLinks
{
    return [self.link count] > 0;
}

/**
 * \brief Checks if there are times in the POIType.
 * @return <code>true</code> if there are times in the POIType, <code>false</code> otherwise.
 */
- (BOOL) hasTimes
{
    return [self.time count] > 0;
}

@end
