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

#import "UriTemplate.h"

@interface UriTemplate()
- (NSString *) expand:(NSString *) value withOperator:(Operator *)operator;
- (NSString *) expandDictionary:(NSString *) name withOperator:(Operator *) operator andDictionary:(NSDictionary *) dict;
- (NSString *) expandArray:(NSString *) name withOperator:(Operator *) operator andArray:(NSArray *) array;
- (NSString *) expandSimple:(NSString *) name withOperator:(Operator *) operator andValue:(NSObject *) value;

- (NSString *) explode:(NSString *) value withOperator:(Operator *)operator;
- (NSString *) explodeDictionary:(NSString *) name withOperator:(Operator *)operator andDictionary:(NSDictionary *) dict;
- (NSString *) explodeArray:(NSString *) name withOperator:(Operator *)operator andArray:(NSArray *) array;
- (NSString *) explodeSimple:(NSString *) name withOperator:(Operator *)operator andValue:(NSObject *) value;

- (NSString *) modify:(NSString *) value withSize:(NSInteger) size andOperator:(Operator *)operator;

- (NSString *) encodeValue:(NSObject *) value;
@end

/**
 * A simplified implementation of the URI Template (<a target="_blank"
 * href="http://tools.ietf.org/html/rfc6570">RFC6570</a>) used to build the
 * server URIs.
 *
 * @author Pedro Cruz
 *
 */
@implementation UriTemplate
@synthesize template = _template;
@synthesize values = _values;

NSString* const TEMPLATE_REGEX = @"\\{[^{}]+\\}";
NSString* const VAR_REGEX = @"((?:\\w+))";
char const CHAR_EXPLODE = '*';
char const CHAR_MODIFIER = ':';

- (NSMutableDictionary *) values
{
    if(!_values) {
        _values = [[NSMutableDictionary alloc] init];
    }
    
    return _values;
}

/**
 * \brief Generate a UriTemplate with a given template form.
 *
 * @param template the wanted template
 * @return {@link UriTemplate}
 */
+ (UriTemplate *) fromTemplate:(NSString *) template
{
    static UriTemplate* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UriTemplate alloc] init];
    });
    
    instance.template = template;
    return instance;
}

/**
 * \brief Set the values of each template
 *
 * @param name the name of the template
 * @param value the value of the template. Supported objects: simple objects, Arrays and Dictionaries.
 */
- (void) set:(NSString *) name withValue:(id) value
{
    [self.values setValue:value forKey: name];
}

/**
 * \brief Checks whether the URI contains the given name in the templated area.
 * This method is case sensitive.
 *
 * @param parameter the parameter to find
 * @return <code>true</code> if the templated area contains the name, <code>false</code> otherwise
 */
- (BOOL) hasParameter:(NSString *) parameter
{
    NSError *error = NULL;
    NSRegularExpression *template = [NSRegularExpression regularExpressionWithPattern:TEMPLATE_REGEX options:NSRegularExpressionCaseInsensitive error:&error];
   
    NSArray* templateMatches = [template matchesInString:self.template options:0 range:NSMakeRange(0, [self.template length])];
    
   for(NSTextCheckingResult* match in templateMatches) {
        NSString* matchText = [self.template substringWithRange:[match range]];
        
        NSRegularExpression *parameters = [NSRegularExpression regularExpressionWithPattern:VAR_REGEX options:NSRegularExpressionCaseInsensitive error:&error];
        NSArray* parameterMatches = [parameters matchesInString:matchText options:0 range:NSMakeRange(0, [matchText length])];
        for(NSTextCheckingResult* params in parameterMatches) {
            NSString* param = [matchText substringWithRange:[params range]];
            if([param isEqualToString:parameter]) {
                return true;
            }
        }
    }
    
    return false;
}

/**
 * \brief Builds the desired URI. This method resets previously set values.
 *
 * @return a String containing the expanded URI Template into a URI
 */
- (NSString *) build
{
    NSError *error = NULL;
    NSMutableString* uri = [[NSMutableString alloc] initWithString:self.template];
    NSRegularExpression *templateRegex = [NSRegularExpression regularExpressionWithPattern:TEMPLATE_REGEX options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray* templateMatches = [templateRegex matchesInString:self.template options:0 range:NSMakeRange(0, [self.template length])];
    
    /* go through all templates */
    for(NSTextCheckingResult* match in templateMatches) {
        NSString* template = [self.template substringWithRange:[match range]];
        
        NSRegularExpression *paramRegex = [NSRegularExpression regularExpressionWithPattern:VAR_REGEX options:NSRegularExpressionCaseInsensitive error:&error];
        NSArray* parameterMatches = [paramRegex matchesInString:template options:0 range:NSMakeRange(0, [template length])];
        
        Operator* op = [Operator getOperatorWithSymbol:[template substringWithRange:NSMakeRange(1, 1)]];
        NSMutableString* parameters = [[NSMutableString alloc] initWithString:op.op];
        
        /* go through all parameters */
        for(int i = 0; i <= [parameterMatches indexOfObject:[parameterMatches lastObject]]; i++) {
            NSTextCheckingResult* params = [parameterMatches objectAtIndex:i];
            NSString* param = [template substringWithRange:[params range]];
            
            /* explode parameter */
            if([template characterAtIndex: params.range.location + params.range.length] == CHAR_EXPLODE){
                [parameters appendString:[self explode:param withOperator:op]];
                
            /* modify parameter value */
            } else if([template characterAtIndex: params.range.location + params.range.length] == CHAR_MODIFIER) {
                NSString* value = [template substringWithRange:[[parameterMatches objectAtIndex:++i] range]];
                [parameters appendString:[self modify:param withSize:[value integerValue] andOperator:op]];
            /* simple expand */
            } else {
                [parameters appendString:[self expand:param withOperator:op]];
            }
        }
        
        if(op.separator != nil && [parameters hasSuffix:op.separator]) {
            [parameters setString:[parameters substringToIndex:([parameters length] - 1)]];
        }
        
        [uri replaceOccurrencesOfString:template withString:parameters options:0 range:NSMakeRange(0, [uri length])];
    }
    
    [self.values removeAllObjects];
    return uri;
}

/*
 * Simple expansion {var}
 */
- (NSString *) expand:(NSString *) value withOperator:(Operator *)operator
{
    NSMutableString* parameters = [[NSMutableString alloc] init];
    if([self.values objectForKey:value] != nil) {
        id obj = [self.values objectForKey:value];
        if([obj isKindOfClass:[NSDictionary class]]) {
            [parameters appendString:[self expandDictionary:value withOperator:operator andDictionary:obj]];
        } else if([obj isKindOfClass:[NSArray class]]) {
            [parameters appendString:[self expandArray:value withOperator:operator andArray:obj]];
        } else {
            [parameters appendString:[self expandSimple:value withOperator:operator andValue:obj]];
        }
        
        [parameters setString:[parameters substringToIndex:[parameters length]]];
        [parameters appendString:operator.separator];
    }

    return parameters;
}

- (NSString *) expandDictionary:(NSString *) name withOperator:(Operator *) operator andDictionary:(NSDictionary *) dict
{
    NSMutableString* parameters = [[NSMutableString alloc] init];
    NSArray* keys = [dict allKeys];
    if(operator.named)
        [parameters appendFormat:@"%@=", name];
    
    for(NSString* key in keys) {
        [parameters appendFormat:@"%@,%@,", key, [self encodeValue:[[dict objectForKey:key] description]]];
    }
    
    return [parameters substringToIndex:[parameters length] - 1];
}

- (NSString *) expandArray:(NSString *) name withOperator:(Operator *) operator andArray:(NSArray *) array
{
    NSMutableString* parameters = [[NSMutableString alloc] init];
    if(operator.named)
        [parameters appendFormat:@"%@=", name];
    
    for(int i = 0; i < [array count]; i++) {
        [parameters appendFormat:@"%@,", [array objectAtIndex:i]];
    }
    
    return [parameters substringToIndex:[parameters length] - 1];
}

- (NSString *) expandSimple:(NSString *) name withOperator:(Operator *) operator andValue:(NSObject *) value
{
    NSMutableString* parameters = [[NSMutableString alloc] init];
    if(operator.named) {
        [parameters appendFormat:@"%@=%@", name, [self encodeValue:value]];
    } else {
        [parameters appendString:[self encodeValue:value]];
    }
    
    return parameters;
}

/*
 * Variable explosion: {var*}
 */
- (NSString *) explode:(NSString *) value withOperator:(Operator *)operator
{
    NSMutableString* parameters = [[NSMutableString alloc] init];
    if([self.values objectForKey:value] != nil) {
        id obj = [self.values objectForKey:value];
        if([obj isKindOfClass:[NSDictionary class]]) {
            [parameters appendString:[self explodeDictionary:value withOperator:operator andDictionary:obj]];
        } else if([obj isKindOfClass:[NSArray class]]) {
            [parameters appendString:[self explodeArray:value withOperator:operator andArray:obj]];
        } else {
            [parameters appendString:[self explodeSimple:value withOperator:operator andValue:obj]];
        }
        
        [parameters setString:[parameters substringToIndex:[parameters length]]];
        [parameters appendString:operator.separator];
    }
    
    return parameters;
}

- (NSString *) explodeDictionary:(NSString *) name withOperator:(Operator *)operator andDictionary:(NSDictionary *) dict
{
    NSMutableString* parameters = [[NSMutableString alloc] init];
    NSArray* keys = [dict allKeys];
    
    for(NSString* key in keys) {
        if(operator.named)
            [parameters appendFormat:@"%@=%@%@", key, [self encodeValue:[[dict objectForKey:key] description]], operator.separator];
        else
            [parameters appendFormat:@"%@%@%@%@", key, operator.separator, [self encodeValue:[[dict objectForKey:key] description]], operator.separator];
    }
    
    return [parameters substringToIndex:[parameters length] - 1];
}

- (NSString *) explodeArray:(NSString *) name withOperator:(Operator *)operator andArray:(NSArray *) array
{
    NSMutableString* parameters = [[NSMutableString alloc] init];
    
    for(int i = 0; i < [array count]; i++) {
        if(operator.named)
            [parameters appendFormat:@"%@=%@", name, [array objectAtIndex:i]];
        else
            [parameters appendFormat:@"%@%@", [array objectAtIndex:i], operator.separator];
    }
    
    return [parameters substringToIndex:[parameters length] - 1];
}

- (NSString *) explodeSimple:(NSString *) name withOperator:(Operator *)operator andValue:(NSObject *) value
{
    return [self expandSimple:name withOperator:operator andValue:value];
}

/*
 * Variable modification: {var:40}
 */
- (NSString *) modify:(NSString *) value withSize:(NSInteger) size andOperator:(Operator *)operator
{
    NSMutableString* parameters = [[NSMutableString alloc] init];
    if([self.values objectForKey:value] != nil) {
        NSString* v = [self encodeValue:[[self.values objectForKey:value] substringToIndex:size]];
        if(operator.named) {
            [parameters appendFormat:@"%@=%@", value, v];
        } else {
            [parameters appendString:v];
        }
        
        [parameters appendString:operator.separator];
    }
    
    return parameters;
}

/*
 * Encodes a given value into percentage-coding
 */
- (NSString *) encodeValue:(NSObject *) value
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef) [[NSString alloc] initWithFormat:@"%@", value], NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
}

@end
