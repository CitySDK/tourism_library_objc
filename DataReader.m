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
#import "DataReader.h"

@interface DataReader()
+ (NSLocale *) getLocaleFromString: (NSString *)locale;
+ (NSString *) getValue: (POI *)poi withLocale:(NSLocale *)locale andTag:(NSString *) tag;
@end

/**
 * \brief Used as an aid to get data from a {@link POI}-based object.
 * <p>It abstract the parsing of data and gets the information needed specified by the application
 * using a given set of terms or languages. In case a given language is not found, it defaults to
 * en_GB.</p>
 *
 * @author Pedro Cruz
 *
 */
@implementation DataReader
static NSLocale* defaultLocale = nil;
static NSString* priceTag = @"X-citysdk/price";
static NSString* waitingTag = @"X-citysdk/waiting-time";
static NSString* occupationTag = @"X-citysdk/occupation";
static NSString* calendarTag = @"text/calendar";
static NSString* getSelectorString[] = {
    @"getLabels:",
    @"getDescriptions:"
};

+ (NSLocale *) getLocaleFromString:(NSString *)locale
{
    if(!defaultLocale)
        [DataReader setDefaultLocale:nil];
    return [[NSLocale alloc] initWithLocaleIdentifier:locale];
}

/**
 * \brief Sets the default locale. If locale is nil, it defaults to en_GB.
 * @param locale the wanted default locale.
 */
+ (void) setDefaultLocale: (NSLocale *) locale
{
    if(!locale)
        defaultLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    else
        defaultLocale = locale;
}

/**
 * \brief Gets a mapping of all the available languages in a given field (description or label) of the {@link POI} object.
 * @param poi the object to get the data.
 * @param field the desired field to check (FIELD_LABELS or FIELD_DESCRIPTIONS)
 * @return a mapping of language codes (e.g.: pt, en) and the respective locale for a given field.
 */
+ (NSDictionary *) getAvailableLangs: (POI *)poi fromField:(Field) field
{
    SEL method = NSSelectorFromString(getSelectorString[field]);
    NSArray* array = [DataReader performSelector:method withObject:poi];
    NSMutableDictionary* langs = [[NSMutableDictionary alloc] init];
    for(POIBaseType* base in array) {
        if(base.lang) {
            NSLocale* locale = [[NSLocale alloc] initWithLocaleIdentifier:base.lang];
            [langs setObject:locale forKey:[locale objectForKey:NSLocaleLanguageCode]];
        }
    }
    
    return langs;
}

+ (NSArray *) getLabels:(POI *) poi
{
    return poi.label;
}

+ (NSArray *) getDescriptions:(POI *) poi
{
    return poi.poiDescription;
}


/**
 * \brief Gets the label with the given term in a given language.
 * @param poi the object to get the data.
 * @param term the term used.
 * @param locale the wanted language.
 * @return a NSString containing the following: the value of the label in the given language. If such language is not found it will return in default language and if the default language is not present it will return nil.
 */
+ (NSString *) getLabel: (POI *)poi withTerm: (Term)term andLocale: (NSLocale *)locale
{
    if(!poi)
        return [[NSString alloc] init];
    
    NSString* defaultValue = nil;
    NSLocale* labelLang;
    NSLocale* poiLang = [DataReader getLocaleFromString:poi.lang];
    NSArray* labels = poi.label;
    for(POITermType* label in labels) {
        if(!label.lang)
            labelLang = poiLang;
        else
            labelLang = [DataReader getLocaleFromString:label.lang];
        
        if([label.term isEqualToString:[Terms getTerm: term]]
           && [[labelLang objectForKey:NSLocaleLanguageCode] isEqual:[defaultLocale objectForKey:NSLocaleLanguageCode]]) {
            defaultValue = label.value;
        } else if([label.term isEqualToString:[Terms getTerm: term]]
                  && [[labelLang objectForKey:NSLocaleLanguageCode] isEqual:[locale objectForKey:NSLocaleLanguageCode]]) {
            return label.value;
        }
    }
    
    return defaultValue;
}

/**
 * \brief Gets the description in a given language.
 * @param poi the object to get the data.
 * @param locale the wanted language.
 * @return a NSString containing the following: the value of the description in the desired language or in the default language if none found or nil.
 */
+ (NSString *) getDescription: (POI *)poi withLocale: (NSLocale *)locale
{
    if(!poi)
        return [[NSString alloc] init];
    
    NSLocale* descriptionLang;
    NSLocale* poiLang = [DataReader getLocaleFromString:poi.lang];
    NSString* defaultValue = nil;
    NSArray* descriptions = poi.poiDescription;
    for(POIBaseType* description in descriptions) {
        if(!description.lang)
            descriptionLang = poiLang;
        else
            descriptionLang = [DataReader getLocaleFromString:description.lang];
        
        if([[descriptionLang objectForKey:NSLocaleLanguageCode] isEqual:[defaultLocale objectForKey:NSLocaleLanguageCode]]) {
            defaultValue = description.value;
        } else if([[descriptionLang objectForKey:NSLocaleLanguageCode] isEqual:[locale objectForKey:NSLocaleLanguageCode]]) {
            return description.value;
        }
    }
    
    return defaultValue;
}

/**
 * \brief Gets the categories in a given language.
 * @param poi the object to get the data.
 * @param locale the wanted language.
 * @return a NSArray containing the following: the value of the categories in the desired language or an empty array if none found.
 */
+ (NSArray *) getCategories: (POI *)poi withLocale: (NSLocale *)locale
{
    NSMutableArray* cats = [[NSMutableArray alloc] init];
    if(!poi)
        return cats;
    
    NSArray* categories = poi.category;
    for(POITermType* category in categories) {
        NSLocale *catLang = [DataReader getLocaleFromString:category.lang];
        if([category.term isEqualToString:@"category"]
                && [[catLang objectForKey:NSLocaleLanguageCode] isEqual:[locale objectForKey:NSLocaleLanguageCode]]) {
            if(category.value) {
                [cats addObject:category.value];
            }
        }
    }
    
    return cats;
}

/**
 * \brief Gets the price in a given language.
 * @param poi the object to get the data.
 * @param locale the wanted language.
 * @return a NSString containing the following: the value of the price in the desired language or in the default language if it was not found or nil if the default language is not present.
 */
+ (NSString *) getPrice: (POI *)poi withLocale: (NSLocale *)locale
{
    return [DataReader getValue:poi withLocale:locale andTag:priceTag];
}

/**
 * \brief Gets the waiting time in a given language.
 * @param poi the object to get the data.
 * @return a NSString containing the waiting time (in seconds) or nil.
 */
+ (NSString *) getWaitingTime: (POI *)poi
{
    return [DataReader getValue:poi withLocale:nil andTag:waitingTag];
}

/**
 * \brief Gets the occupation in a given language.
 * @param poi the object to get the data.
 * @return a NSString containing the occupation value (0 to 100) or nil.
 */
+ (NSString *) getOccupation: (POI *)poi
{
    return [DataReader getValue:poi withLocale:nil andTag:occupationTag];
}

+ (NSString *) getValue: (POI *)poi withLocale:(NSLocale *)locale andTag:(NSString *) tag
{
    if(!poi)
        return [[NSString alloc] init];
    
    NSLocale* descriptionLang;
    NSLocale* poiLang = [DataReader getLocaleFromString:poi.lang];
    NSString* defaultValue = nil;
    NSArray* descriptions = poi.poiDescription;
    for(POIBaseType* description in descriptions) {
        if(!description.lang)
            descriptionLang = poiLang;
        else
            descriptionLang = [DataReader getLocaleFromString:description.lang];
        
        if([description.type isEqualToString:tag]
           && [[descriptionLang objectForKey:NSLocaleLanguageCode] isEqual:[defaultLocale objectForKey:NSLocaleLanguageCode]]){
            defaultValue = description.value;
        } else if([description.type isEqualToString:tag]
                  && [[descriptionLang objectForKey:NSLocaleLanguageCode] isEqual:[defaultLocale objectForKey:NSLocaleLanguageCode]]) {
            return description.value;
        }
    }
    
    return defaultValue;
}

/**
 * \brief Gets all the thumbnails in 64-base bytecode or URI
 * @param poi the object to get the data.
 * @return a list of {@link ImageContent} where each element contains the following: the bytecode (base-64) or URI of the thumbnail, or an empty list if none found.
 */
+ (NSArray *) getThumbnails: (POI *)poi
{
    NSMutableArray* thumbnails = [[NSMutableArray alloc] init];
    if(!poi)
        return thumbnails;
    
    ImageContent* img = nil;
    NSArray* links = poi.link;
    for(POITermType* link in links) {
        if([link.term isEqualToString:[Terms getTerm:LINK_TERM_ICON]]) {
            if(link.href) {
                img = [[ImageContent alloc] initWithContent:link.href andIsUri:YES];
                [thumbnails addObject:img];
            } else if(link.value) {
                img = [[ImageContent alloc] initWithContent:link.value andIsUri:NO];
                [thumbnails addObject:img];
            }
        }
    }
    
    return thumbnails;
}

/**
 * \brief Gets a list of points of the POI object with the given term.
 * @param poi the object to get the data.
 * @param term the term to be used.
 * @return a list (of {@link GeometryContent}) containing all geometries with the given term or an empty list.
 */
+ (NSArray *) getLocationGeometry: (POI *)poi withTerm: (Term)term
{
    NSMutableArray* geometries = [[NSMutableArray alloc] init];
    if(!poi)
        return geometries;
    
    [geometries addObjectsFromArray:[DataReader getLocationPoint:poi withTerm:term]];
    [geometries addObjectsFromArray:[DataReader getLocationLine:poi withTerm:term]];
    [geometries addObjectsFromArray:[DataReader getLocationPolygon:poi withTerm:term]];
    
    return geometries;
}

/**
 * \brief Gets a list of points of the POI object with the given term.
 * It only checks the {@link GeoPoint} geometry.
 * @param poi the object to get the data.
 * @param term the term to be used.
 * @return a list (of {@link PointContent}) containing all points with the given term or an empty list.
 */
+ (NSArray *) getLocationPoint: (POI *)poi withTerm: (Term)term
{
    NSMutableArray* locationPoints = [[NSMutableArray alloc] init];
    if(!poi)
        return locationPoints;
    
    Location* location = poi.location;
    PointContent* point;
    if(location.hasPoints) {
        NSArray* points = location.point;
        for(GeoPoint* p in points) {
            if([p.term isEqualToString:[Terms getTerm:term]]) {
                NSArray* data = [p.point.posList componentsSeparatedByString:@" "];
                point = [[PointContent alloc] initPointWithLatitude:[data objectAtIndex:0] andLongitude:[data objectAtIndex:1]];
                [locationPoints addObject:point];
            }
        }
    }
    
    return locationPoints;
}

/**
 * \brief Gets a list of lines of the POI object with the given term.
 * It only checks the {@link Line} geometry.
 * @param poi the object to get the data.
 * @param term the term to be used.
 * @return a list (of {@link LineContent}) containing all lines with the given term or an empty list.
 */
+ (NSArray *) getLocationLine: (POI *)poi withTerm: (Term)term
{
    NSMutableArray* locationLines = [[NSMutableArray alloc] init];
    if(!poi)
        return locationLines;
    
    Location* location = poi.location;
    LineContent* line;
    if(location.hasLines) {
        NSArray* lines = location.line;
        for(Line* l in lines) {
            if([l.term isEqualToString:[Terms getTerm:term]]) {
                NSArray* data = [l.lineString.posList componentsSeparatedByString:@","];
                NSArray* pointOne = [[data objectAtIndex:0] componentsSeparatedByString:@" "];
                NSArray* pointTwo = [[data objectAtIndex:1] componentsSeparatedByString:@" "];
                
                LocationContent* locationOne = [[LocationContent alloc] initWithLatitude:[pointOne objectAtIndex:0] andLongitude:[pointTwo objectAtIndex:1]];
                LocationContent* locationTwo = [[LocationContent alloc] initWithLatitude:[pointTwo objectAtIndex:0] andLongitude:[pointTwo objectAtIndex:1]];
                
                line = [[LineContent alloc] initWithPointOne:locationOne andPointTwo:locationTwo];
                [locationLines addObject:line];
            }
        }
    }
    
    return locationLines;
}

/**
 * \brief Gets a list of polygons of the POI object with the given term.
 * It only checks the {@link Polygon} geometry.
 * @param poi the object to get the data.
 * @param term the term to be used.
 * @return a list (of {@link PolygonContent}) containing all polygons with the given term or an empty list.
 */
+ (NSArray *) getLocationPolygon: (POI *)poi withTerm: (Term)term
{
    NSMutableArray* locationPolygons = [[NSMutableArray alloc] init];
    if(!poi)
        return locationPolygons;
    
    Location* location = poi.location;
    PolygonContent* polygon;
    if(location.hasPolygons) {
        NSArray* polygons = location.polygon;
        for(Polygon* p in polygons) {
            if([p.term isEqualToString:[Terms getTerm:term]]) {
                polygon = [[PolygonContent alloc] init];
                NSArray* data = [p.simplePolygon.posList componentsSeparatedByString:@","];
                for(int i = 0; i < [data count]; i++) {
                    NSArray* posList = [[data objectAtIndex:i] componentsSeparatedByString:@","];
                    LocationContent* location = [[LocationContent alloc] initWithLatitude:[posList objectAtIndex:0] andLongitude:[posList objectAtIndex:1]];
                    [polygon addLocation:location];
                }
                
                [locationPolygons addObject:polygon];
            }
        }
    }
    
    return locationPolygons;
}

/**
 * \brief Gets the contacts in vCard format
 * @param poi the object to get the data.
 * @return a NSString containing the information in vCard format or nil if none were found.
 */
+ (NSString *) getContacts: (POI *)poi
{
    if(!poi)
        return [[NSString alloc] init];

    return poi.location.address.value;
}

/**
 * \brief Returns an a calendar in iCalendar format of the given term.
 * @param poi the object to get the data.
 * @param term the term to search for.
 * @return a NSString containing the information in iCalendar format with the given term or nil if none were found.
 */
+ (NSString *) getCalendar: (POI *)poi withTerm: (Term)term
{
    if(poi) {
        NSArray* times = poi.time;
        for(POITermType* time in times) {
            if([time.type isEqualToString:calendarTag]
           && [time.term isEqualToString:[Terms getTerm:term]]){
                return time.value;
            }
        }
    }
    
    return nil;
}

/**
 * \brief Gets all the URI images of the given POI object.
 * @param poi the object to get the data.
 * @return the list of URIs ({@link ImageContent}) of the images or an empty list if none were found.
 */
+ (NSArray *) getImagesUri: (POI *)poi
{
    NSMutableArray* imgs = [[NSMutableArray alloc] init];
    if(poi) {
        NSArray* links = poi.link;
        for(POITermType* link in links){
            if([link.term isEqualToString:[Terms getTerm:LINK_TERM_RELATED]]
               && [link.type rangeOfString:@"image/"].location != NSNotFound) {
                ImageContent* img = [[ImageContent alloc] initWithContent:link.href andIsUri:YES];
                [imgs addObject:img];
            }
        }
    }
    
    return imgs;
}

/**
 * \brief Gets the relationship base with a given term.
 * @param poi the object to get the data.
 * @param term the term used.
 * @return a NSString containing the relationship base with the given term or nil if none was found.
 */
+ (NSString *) getRelationshipBase: (POI *)poi withTerm: (Term)term
{
    if(poi && poi.location.hasRelationships) {
        NSArray* relationships = poi.location.relationship;
        for(Relationship* relationship in relationships) {
            if([relationship.term isEqualToString:[Terms getTerm:term]]) {
                return relationship.base;
            }
        }
    }
    
    return nil;
}

/**
 * \brief Gets the relationship id with a given term.
 * @param poi the object to get the data.
 * @param term the term used.
 * @return a NSString containing the relationship id with the given term or null if none was found.
 */
+ (NSString *) getRelationshipId: (POI *)poi withTerm: (Term)term
{
    if(poi && poi.location.hasRelationships) {
        NSArray* relationships = poi.location.relationship;
        for(Relationship* relationship in relationships) {
            if([relationship.term isEqualToString:[Terms getTerm:term]]) {
                if(!relationship.targetEvent)
                    return relationship.targetPOI;
                else
                    return relationship.targetEvent;
            }
        }
    }
    
    return nil;
}

/**
 * \brief Returns the link with a given term.
 * @param poi the object to get the data.
 * @param term the term used
 * @return a NSString containing a link or null if none found.
 */
+ (NSString *) getLink: (POI *)poi withTerm: (Term)term
{
    if(poi) {
        NSArray* links = poi.link;
        for(POITermType* link in links) {
            if([link.term isEqualToString:[Terms getTerm:term]]) {
                return link.href;
            }
        }
    }
    
    return nil;
}

/**
 * \brief Gets the tags within the list of tags in a given language.
 * @param tags the list of tags.
 * @param locale the wanted language.
 * @return a list of tags in the given language, or an empty list if none was found.
 */
+ (NSArray *) getTags: (ListTag *)tags withLocale: (NSLocale *)locale
{
    NSMutableArray* tagsList = [[NSMutableArray alloc] init];
    if(tags) {
        for(int i = 0; i < [tags getNumTags]; i++) {
            Tag* tag = [tags getTag:i];
            NSArray* list = tag.tags;
            for(Tag* t in list) {
                NSLocale* tagLocale = [DataReader getLocaleFromString:t.lang];
                if([[locale objectForKey:NSLocaleLanguageCode] isEqual:[tagLocale objectForKey:NSLocaleLanguageCode]]) {
                    [tagsList addObject:[[NSString alloc] initWithString:t.value]];
                }
            }
        }
    }
    
    return tagsList;
}

@end
