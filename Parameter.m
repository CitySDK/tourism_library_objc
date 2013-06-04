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

#import "Parameter.h"

@interface Parameter()
- (BOOL) isValidName: (NSString *) name :(NSError **) err;
@end

/**
 * \brief It is used to indicate what parameters should the URI have upon a HTTP request.
 * <p>Its term should be one of the terms shown in {@link ParameterTerms}
 * or it returns an error. Its value should be the search value.</p>
 *
 * @author Pedro Cruz
 *
 */
@implementation Parameter
- (BOOL) isValidName: (NSString *) name :(NSError **) err
{
    NSArray *array = [ParameterTerms getTerms];
    for(int i = 0; i < [array count]; i++) {
        if([name isEqualToString:[array objectAtIndex:i]])
            return true;
    }
    
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:@"invalid parameter" forKey:NSLocalizedDescriptionKey];
    *err = [NSError errorWithDomain:@"invalid" code:4 userInfo:details];
    return false;
}

/**
 * \brief Constructor first validates the name before actually creating the Parameter.
 * <p>Its validation verifies if it is one of the terms found in {@link ParameterTerms}.
 * If it is not found in the aforementioned enum, then it will set the error field.</p>
 * @param name the name of the parameter
 * @param value the value of the parameter used for search
 * @param error set if the parameter term is invalid
 */
- (id) initWithName:(NSString *) name andValue:(id) value :(NSError **) error
{
    self = [super init];
    if([self isValidName :name :error]) {
        self.name = name;
        self.value = value;
    }
    
    return self;
}

- (BOOL)isEqual:(id)object
{
    if(object == nil)
        return false;
    
    if([object isKindOfClass:[self class]]) {
        Parameter *parameter = object;
        return [parameter.name isEqualToString:self.name];
    }
    
    return false;
}
@end
