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

#import "ParameterList.h"

@interface ParameterList()
@property (nonatomic, retain) NSMutableArray *list;
@end

/**
 * \brief A list of {@link Parameter} used for the {@link TourismClient} stub when performing HTTP requests.
 *
 * @author Pedro Cruz
 *
 */
@implementation ParameterList

- (id)init
{
    self = [super init];
    if(self) {
        self.list = [[NSMutableArray alloc] init];
    }
    
    return self;
}

/**
 * \brief Adds a new parameter, if it does not exist already.
 * @param parameter {@link Parameter} to be added.
 */
- (void) add:(Parameter *) parameter
{
    if([self.list indexOfObject:parameter] == NSNotFound)
        [self.list addObject:parameter];
}

/**
 * \brief Gets the {@link Parameter} in the given index.
 * @param i index of the {@link Parameter}.
 * @return {@link Parameter} in index i.
 */
- (Parameter *) get:(int) i
{
    return [self.list objectAtIndex:i];
}

/**
 * \brief Gets the {@link Parameter} with a given parameter term
 * @param parameter term (name) of the {@link Parameter}.
 * @return {@link Parameter} with the name parameter.
 */
- (Parameter *) find:(ParameterTerm) parameter
{
    NSString* name = [ParameterTerms getTerm:parameter];
    for(int i = 0; i < [self.list count]; i++) {
        Parameter* parameter = [self.list objectAtIndex:i];
        if([name isEqualToString:parameter.name])
            return parameter;
    }
    
    return nil;
}

/**
 * \brief Replaces or adds a given {@link Parameter}.
 * @param parameter the {@link Parameter} to be replaced/added.
 */
- (void) replace:(Parameter *) parameter
{
    int index;
    if((index = [self.list indexOfObject:parameter]) != NSNotFound) {
        [self.list replaceObjectAtIndex:index withObject:parameter];
    } else {
        [self add:parameter];
    }
}

/**
 * \brief Removes all {@link Parameter}.
 */
- (void) removeAll
{
    if([self.list count] > 0)
        [self.list removeAllObjects];
}

/**
 * \brief Gets the number of parameters in the parameter list.
 * @return the number of parameters.
 */
- (int) size
{
    return [self.list count];
}

@end
