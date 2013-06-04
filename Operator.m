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

#import "Operator.h"

/**
 * The operator used in the URI Template
 *
 * @author Pedro Cruz
 *
 */
@implementation Operator

- (id) initWithValue:(NSString *) value andOperator:(NSString *) op andSeparator:(NSString *) separator isNamed:(BOOL) named
{
    self = [super init];
    if(self) {
        self.value = value;
        self.op = op;
        self.separator = separator;
        self.named = named;
    }
    
    return self;
}

+ (Operator *) getOperatorWithSymbol:(NSString *) symbol
{
    static NSDictionary* operators = nil;
    /* load operators */
    if(!operators) {
        NSArray* objs = [[NSArray alloc] initWithObjects:
                         [[Operator alloc] initWithValue:@"" andOperator:@"" andSeparator:@"," isNamed:false],
                         [[Operator alloc] initWithValue:@"+" andOperator:@"" andSeparator:@"," isNamed:false],
                         [[Operator alloc] initWithValue:@"#" andOperator:@"#" andSeparator:@"," isNamed:false],
                         [[Operator alloc] initWithValue:@"." andOperator:@"." andSeparator:@"." isNamed:false],
                         [[Operator alloc] initWithValue:@"/" andOperator:@"/" andSeparator:@"/" isNamed:false],
                         [[Operator alloc] initWithValue:@";" andOperator:@";" andSeparator:@";" isNamed:true],
                         [[Operator alloc] initWithValue:@"?" andOperator:@"?" andSeparator:@"&" isNamed:true],
                         [[Operator alloc] initWithValue:@"&" andOperator:@"&" andSeparator:@"&" isNamed:true],
                         nil];
        NSArray* keys = [[NSArray alloc] initWithObjects:@"", @"+", @"#", @".", @"/", @";", @"?", @"&", nil];
        operators = [[NSDictionary alloc] initWithObjects:objs forKeys:keys];
    }
    
    return [operators objectForKey:symbol];
}

@end
