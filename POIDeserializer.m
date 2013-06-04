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

#import "POIDeserializer.h"

NSString * const jsonTerms[] = {
    @"poi",
    @"event",
    @"routes",
    @"citysdk-tourism",
    @"_links",
    @"categories",
    @"tags",
    @"tag"
};

NSString * const baseTerms[] = {
    @"id",
    @"value",
    @"href",
    @"type",
    @"lang",
    @"base",
    @"created",
    @"updated",
    @"deleted",
    @"author",
    @"license"
};

NSString * const termTypeTerms[] = {
    @"term",
    @"scheme"
};

NSString * const typeTerms[] = {
    @"label",
    @"description",
    @"category",
    @"time",
    @"link",
    @"location"
};

NSString * const locationTerms[] = {
    @"point",
    @"Point",
    @"line",
    @"LineString",
    @"polygon",
    @"SimplePolygon",
    @"posList",
    @"address",
    @"relationship",
    @"targetPOI",
    @"targetEvent"
};

@interface POIDeserializer()
- (void) deserializeBase:(NSDictionary *) data :(POIBaseType **)base;
- (void) deserializeTermType: (NSDictionary *) data :(POITermType **)termType;
- (void) deserializeLabel:(NSDictionary *) data :(POIType **)type;
- (void) deserializeDescription:(NSDictionary *) data :(POIType **)type;
- (void) deserializeCategory:(NSDictionary *) data :(POIType **)type;
- (void) deserializeTime:(NSDictionary *) data :(POIType **)type;
- (void) deserializeLink:(NSDictionary *) data :(POIType **)type;
- (void) deserializePoints:(NSArray *) data :(POI **)poi;
- (void) deserializeLines:(NSArray *) data :(POI **)poi;
- (void) deserializePolygons:(NSArray *) data :(POI **)poi;
- (void) deserializeRelationship:(NSArray *) data :(POI **)poi;
- (void) deserializeAddress:(NSDictionary *) data :(POI **)poi;
- (void) deserializeLocation:(NSDictionary *) data :(POI **)poi;
- (void) deserializePOI:(NSDictionary *) data :(POI **)poi;
- (void) deserializeList:(NSArray *) array :(POIS **)pois :(NSString *)name;
- (void) deserializeCategories:(NSArray *) array :(Category **) categories;
- (void) deserializeTags:(NSArray *) array :(ListTag **) tags;
- (void) deserializeHypermedia:(NSArray *) array:(Resources **) resources;
@end

@implementation POIDeserializer 
- (void) deserializeBase:(NSDictionary *) data :(POIBaseType **)base
{
    NSString *value;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    if((value = [data objectForKey:baseTerms[ID]]) != nil)
        (*base).baseID = value;
    
    if((value = [data objectForKey:baseTerms[VALUE]]) != nil)
        (*base).value = value;
    
    if((value = [data objectForKey:baseTerms[HREF]]) != nil)
        (*base).href = value;
    
    if((value = [data objectForKey:baseTerms[TYPE]]) != nil)
        (*base).type = value;
    
    if((value = [data objectForKey:baseTerms[LANG]]) != nil)
        (*base).lang = value;
    
    if((value = [data objectForKey:baseTerms[BASE]]) != nil)
        (*base).base = value;
    
    if((value = [data objectForKey:baseTerms[CREATED]]) != nil)
        (*base).created = [dateFormatter dateFromString:value];
    
    if((value = [data objectForKey:baseTerms[UPDATED]]) != nil)
        (*base).updated = [dateFormatter dateFromString:value];
    
    if((value = [data objectForKey:baseTerms[DELETED]]) != nil)
        (*base).deleted = [dateFormatter dateFromString:value];
    
    if(([data objectForKey:baseTerms[AUTHOR]]) != nil) {
        POITermType *term = (*base).author;
        [self deserializeTermType:[data objectForKey:baseTerms[AUTHOR]] :&term];
        (*base).author = term;
    }
    
    if(([data objectForKey:baseTerms[LICENSE]]) != nil) {
        POITermType *term = (*base).license;
        [self deserializeTermType:[data objectForKey:baseTerms[LICENSE]] :&term];
        (*base).license = term;
    }
}

- (void) deserializeTermType: (NSDictionary *) data :(POITermType **)termType
{
    NSString *value;
    if((value = [data objectForKey:termTypeTerms[TERM]]) != nil)
        (*termType).term = value;

    if((value = [data objectForKey:termTypeTerms[SCHEME]]) != nil)
        (*termType).scheme = value;
    
    [self deserializeBase:data :termType];
}

- (void) deserializeLabel:(NSDictionary *) data :(POIType **)type
{
    NSArray *array;
    if((array = [data objectForKey:typeTerms[LABEL]]) != nil) {
        for(int i = 0; i < [array count]; i++) {
            NSDictionary *d = [array objectAtIndex:i];
            POITermType *term = [[POITermType alloc] init];
            [self deserializeTermType:d :&term];
            [(*type) addLabel:term];
        }
    }
}

- (void) deserializeDescription:(NSDictionary *) data :(POIType **)type
{
    NSArray *array;
    if((array = [data objectForKey:typeTerms[DESCRIPTION]]) != nil) {
        for(int i = 0; i < [array count]; i++) {
            NSDictionary *d = [array objectAtIndex:i];
            POITermType *term = [[POITermType alloc] init];
            [self deserializeTermType:d :&term];
            [(*type) addDescription:term];
        }
    }
}

- (void) deserializeCategory:(NSDictionary *) data :(POIType **)type
{
    NSArray *array;
    if((array = [data objectForKey:typeTerms[CATEGORY]]) != nil) {
        for(int i = 0; i < [array count]; i++) {
            NSDictionary *d = [array objectAtIndex:i];
            POITermType *term = [[POITermType alloc] init];
            [self deserializeTermType:d :&term];
            [(*type) addCategory:term];
        }
    }
}

- (void) deserializeTime:(NSDictionary *) data :(POIType **)type
{
    NSArray *array;
    if((array = [data objectForKey:typeTerms[TIME]]) != nil) {
        for(int i = 0; i < [array count]; i++) {
            NSDictionary *d = [array objectAtIndex:i];
            POITermType *term = [[POITermType alloc] init];
            [self deserializeTermType:d :&term];
            [(*type) addTime:term];
        }
    }
}

- (void) deserializeLink:(NSDictionary *) data :(POIType **)type
{
    NSArray *array;
    if((array = [data objectForKey:typeTerms[LINK]]) != nil) {
        for(int i = 0; i < [array count]; i++) {
            NSDictionary *d = [array objectAtIndex:i];
            POITermType *term = [[POITermType alloc] init];
            [self deserializeTermType:d :&term];
            [(*type) addLink:term];
        }
    }
}

- (void) deserializePoints:(NSArray *) data :(POI **)poi
{
    for(int i = 0; i < [data count]; i++) {
        NSDictionary *d = [data objectAtIndex:i];
        NSDictionary *pointData = [d objectForKey:locationTerms[POINT_P]];

        GeoPoint *point = [[GeoPoint alloc] init];
        point.point.posList = [pointData objectForKey:locationTerms[POS_LIST]];
        [self deserializeTermType:d :&point];
        [(*poi).location addPoint:point];
    }
}

- (void) deserializeLines:(NSArray *) data :(POI **)poi
{
    for(int i = 0; i < [data count]; i++) {
        NSDictionary *d = [data objectAtIndex:i];
        NSDictionary *lineData = [d objectForKey:locationTerms[LINE_STRING]];
        
        Line *line = [[Line alloc] init];
        line.lineString.posList = [lineData objectForKey:locationTerms[POS_LIST]];
        
        [self deserializeTermType:d :&line];
        [(*poi).location addLine:line];
    }
}

- (void) deserializePolygons:(NSArray *) data :(POI **)poi
{
    for(int i = 0; i < [data count]; i++) {
        NSDictionary *d = [data objectAtIndex:i];
        NSDictionary *polygonData = [d objectForKey:locationTerms[SIMPLE_POLYGON]];
        
        Polygon *polygon = [[Polygon alloc] init];
        polygon.simplePolygon.posList = [polygonData objectForKey:locationTerms[POS_LIST]];
        
        [self deserializeTermType:d :&polygon];
        [(*poi).location addPolygon:polygon];
    }
}

- (void) deserializeRelationship:(NSArray *) data :(POI **)poi
{
    for(int i = 0; i < [data count]; i++) {
        NSDictionary *d = [data objectAtIndex:i];

        Relationship *relationship = [[Relationship alloc] init];
        [self deserializeTermType:d :&relationship];
        
        NSString *target;
        if((target = [d objectForKey:locationTerms[TARGET_POI]]) != nil)
            relationship.targetPOI = target;
        else if((target = [d objectForKey:locationTerms[TARGET_EVENT]]) != nil)
            relationship.targetEvent = target;
        
        [(*poi).location addRelationship: relationship];
    }
}

- (void) deserializeAddress:(NSDictionary *) data :(POI **)poi
{
    Location *location = (*poi).location;
    POIBaseType *address = location.address;
    [self deserializeBase:[data objectForKey:locationTerms[ADDRESS]] :&address];
}

- (void) deserializeLocation:(NSDictionary *) data :(POI **)poi
{
    NSArray *array;
    NSDictionary *locationData;
    
    locationData = [data objectForKey:typeTerms[LOCATION]];
    [self deserializeAddress:locationData :poi];

    if((array = [locationData objectForKey:locationTerms[POINT]]) != nil) {
        [self deserializePoints:array :poi];
    }
    
    if((array = [locationData objectForKey:locationTerms[LINE]]) != nil) {
        [self deserializeLines:array :poi];
    }
    
    if((array = [locationData objectForKey:locationTerms[POLYGON]]) != nil) {
        [self deserializePolygons:array :poi];
    }
    
    if((array = [locationData objectForKey:locationTerms[RELATIONSHIP]]) != nil) {
        [self deserializeRelationship:array :poi];
    }
}

- (void) deserializeSinglePoi: (NSDictionary *) data:(POI **) poi
{
    [self deserializeBase:data :poi];
    [self deserializeLabel:data :poi];
    [self deserializeDescription:data :poi];
    [self deserializeCategory:data :poi];
    [self deserializeTime:data :poi];
    [self deserializeLink:data :poi];
    [self deserializeLocation:data :poi];
}

- (void) deserializePOI:(NSDictionary *) data :(POI **)poi
{
    [self deserializeSinglePoi: data: poi];
    
    // routes
    if([data objectForKey:@"pois"] != nil) {
        Route* route = (*poi);
        NSArray* array = [data objectForKey:@"pois"];
        for(int i = 0; i < [array count]; i++) {
            NSDictionary* elem = [array objectAtIndex:i];
            PointOfInterest* poi = [[PointOfInterest alloc] init];
            [self deserializeSinglePoi:elem :&poi];
            [route addPoi:poi];
        }
    }
}

- (void) deserializeList:(NSArray *) array :(POIS **)pois :(NSString *)name
{
    Class poiClass = NSClassFromString(name);
    for(int i = 0; i < [array count]; i++) {
        NSDictionary* elem = [array objectAtIndex:i];
        id object = [[poiClass alloc] init];
        [self deserializePOI:elem :&object];
        [(*pois) addPOI:object];
    }
}

- (void) deserializeCategories:(NSArray *) array :(Category **) categories
{
    
    for(int i = 0; i < [array count]; i++) {
        Category* category = [[Category alloc] init];
        NSDictionary* elem = [array objectAtIndex:i];
        [self deserializePOI:elem :&category];
        if([elem objectForKey:jsonTerms[CATEGORIES]] != nil) {
            [self deserializeCategories:[elem objectForKey:jsonTerms[CATEGORIES]] :&category];
        }
        [(*categories) addCategory:category];
    }
}

- (void) deserializeTags:(NSArray *) array :(ListTag **) tags
{
    for(int i = 0; i < [array count]; i++) {
        NSDictionary* tag = [array objectAtIndex:i];
        NSArray* sub = [tag objectForKey:jsonTerms[TAG]];
        for(int j = 0; j < [sub count]; j++) {
            Tag* tag = [[Tag alloc] init];
            NSDictionary* elem = [sub objectAtIndex:j];
            [self deserializeBase:elem :&tag];
            [(*tags) addTag:tag];
        }
    }
}

- (void) deserializeHypermedia:(NSArray *) array:(Resources **) resources
{
    for(int i = 0; i < [array count]; i++) {
        NSDictionary* resource = [array objectAtIndex:i];
        NSDictionary* hypermedia = [resource objectForKey:@"_links"];
        
        NSString* version = [resource objectForKey:@"version"];
        NSArray* links = [hypermedia allKeys];
        
        HypermediaLink* hLink = [[HypermediaLink alloc] init];
        hLink.version = version;
        for(int j = 0; j < [links count]; j++) {
            NSString* name = [links objectAtIndex:j];
            NSDictionary* link = [hypermedia objectForKey:name];
        
            Hypermedia* l = [[Hypermedia alloc] init];
            l.href = [link objectForKey:@"href"];
            l.templated = [link objectForKey:@"templated"];
            
            [hLink addHypermedia:l withName:name];
        }
        
        [(*resources) addResource:hLink];
    }
}

- (void) parseJson:(NSDictionary *)json :(NSObject<Deserializable> **)poi
{
    id value;
    if((value = [json objectForKey:jsonTerms[CATEGORIES]]) != nil) {
        [self deserializeCategories:value :poi];
    } else if((value = [json objectForKey:jsonTerms[TOURISM]]) != nil) {
        [self deserializeHypermedia: value: poi];
    } else if((value = [json objectForKey:jsonTerms[TAGS]]) != nil) {
        [self deserializeTags: value: poi];
    } else if((value = [json objectForKey:jsonTerms[SPOI]]) != nil) {
        [self deserializeList: value: poi: @"PointOfInterest"];
    } else if((value = [json objectForKey:jsonTerms[EVENT]]) != nil) {
        [self deserializeList: value: poi: @"Event"];
    } else if((value = [json objectForKey:jsonTerms[ROUTE]]) != nil) {
        [self deserializeList: value: poi: @"Route"];
    } else {
        [self deserializePOI: json: poi];
    }
}

@end
