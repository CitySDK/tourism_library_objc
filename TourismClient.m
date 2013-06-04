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

#import "TourismClient.h"

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
    Stuff; \
    _Pragma("clang diagnostic pop") \
} while (0)

@interface TourismClient()
@property (nonatomic, retain) Resources *resources;
@property (nonatomic, retain) JsonParser *parser;
@property (nonatomic, copy) NSString *homeUrl;
@property (nonatomic, copy) NSString *version;

- (NSError *) makeError:(NSString *)domain :(NSString *)errorValue :(int)code;
- (BOOL) verifyVersion:(NSError **) err;
- (BOOL) validateResource:(ResourceTerm) resource :(NSError **)err;
- (BOOL) validateParameters:(ParameterList *) parameters ofResource:(ResourceTerm) resource :(NSError **)err;
- (BOOL) validateListValue:(Parameter *) parameter :(NSError **)err;

- (NSObject<Deserializable> *) getList:(ParameterList *) parameters ofResource:(ResourceTerm) term usingParser:(SEL) selector :(NSError **) err;
- (NSObject<Deserializable> *) getSingle:(NSString *) base withId:(NSString *) identifier usingParser:(SEL) selector :(NSError **) err;
- (NSObject<Deserializable> *) getCategorization:(ParameterList *) parameters ofResource:(ResourceTerm) resource usingParser:(SEL) selector :(NSError **) err;

@end

/**
 * \brief Stub used for the CitySDK Tourism API. It abstracts applications from the different requests allowed in the API and returns the correct data objects from such calls.
 *
 * @author Pedro Cruz
 *
 */
@implementation TourismClient
@synthesize version = _version;

- (NSError *) makeError:(NSString *)domain :(NSString *)errorValue :(int)code
{
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:errorValue forKey:NSLocalizedDescriptionKey];
    return [NSError errorWithDomain:domain code:code userInfo:details];
}

- (BOOL) verifyVersion:(NSError **) err
{
    if([self.resources hasVersion:self.version])
        return true;
    else {
        *err = [self makeError:@"Invalid Version" :@"Invalid version or non-existent" :3];
        return false;
    }
}

- (BOOL) validateResource:(ResourceTerm) resource :(NSError **)err
{
    return [self hasResource:resource :err];
}

- (BOOL) validateParameters:(ParameterList*) parameters ofResource:(ResourceTerm) resource :(NSError **)err
{
    HypermediaLink* hypermedia = [self.resources getHypermediaWithVersion:self.version];
    Hypermedia* link = [hypermedia.links objectForKey:[ResourceTerms getResource:resource]];
    UriTemplate* uriTemplate = [UriTemplate fromTemplate:link.href];
    
    for(int i = 0; i < [parameters size]; i++) {
        Parameter* param = [parameters get:i];
        if(![uriTemplate hasParameter:param.name]) {
            NSString* msg = [[NSString alloc] initWithFormat:@"Parameter %@ is not supported for %@", param.name, [ResourceTerms getResource:resource]];
            *err = [self makeError:@"Invalid Parameter" :msg :3];
            return false;
        }
    }
    
    return true;
}

- (BOOL) validateListValue:(Parameter *) parameter :(NSError **)err
{
    if(!(parameter && [parameter.name isEqualToString:@"list"] && ([parameter.value isEqualToString:@"poi"] || [parameter.value isEqualToString:@"event"] || [parameter.value isEqualToString:@"route"]))) {
        *err = [self makeError:@"Invalid Parameter" :@"It must have a list parameter with the value poi, event or route" :3];
        return false;
    }
    
    return true;
}

- (NSObject<Deserializable> *) getList:(ParameterList *) parameters ofResource:(ResourceTerm) resource usingParser:(SEL) selector :(NSError **) err
{
    if([self verifyVersion:err] && [self validateResource:resource :err] && [self validateParameters:parameters ofResource:resource :err]) {
        HypermediaLink* hypermedia = [self.resources getHypermediaWithVersion:self.version];
        Hypermedia* link = [hypermedia.links objectForKey:[ResourceTerms getResource:resource]];
        UriTemplate* template = [UriTemplate fromTemplate:link.href];
        
        for(int i = 0; i < [parameters size]; i++) {
            Parameter* param = [parameters get:i];
            [template set:param.name withValue:param.value];
        }
        
        NSString* uri = [template build];
        NSString* response = [Request getResponse:uri :err];
        if(response) {
            self.parser.json = response;
            SuppressPerformSelectorLeakWarning(return [self.parser performSelector:selector withObject:(*err)];);
        }
    }
    
    return nil;
}

- (NSObject<Deserializable> *) getSingle:(NSString *) base withId:(NSString *) identifier usingParser:(SEL) selector :(NSError **) err
{
    NSString* url = [[NSString alloc] initWithFormat:@"%@%@", base, identifier];
    NSString* response = [Request getResponse:url :err];
    if(response) {
        self.parser.json = response;
        SuppressPerformSelectorLeakWarning(return [self.parser performSelector:selector withObject:(*err)];);
    }
    
    return nil;
}

- (NSObject<Deserializable> *) getCategorization:(ParameterList *) parameters ofResource:(ResourceTerm) resource usingParser:(SEL) selector :(NSError **) err
{
    if([self validateListValue:[parameters find:PARAMETER_LIST] :err]) {
        return [self getList: parameters ofResource:resource usingParser:selector :err];
    }
    
    return nil;
}

/**
 * \brief Initializes with a given resource for a given home URL
 * @param resources the resources of the server
 * @param homeUrl the home URI of the server
 */
- (id) initWithResources:(Resources *)resources andHomeUrl:(NSString *)homeUrl
{
    self = [super init];
    if(self){
        [self setResources:resources andHomeUrl:homeUrl];
    }
    
    return self;
}

/**
 * \brief Sets the client stub with a given resources for a given homeUrl
 * @param resources the resources of the server
 * @param homeUrl the home URI of the server
 */
- (void) setResources:(Resources *)resources andHomeUrl:(NSString *)homeUrl
{
    self.resources = resources;
    self.homeUrl = homeUrl;
    self.parser = [[JsonParser alloc] init];
}

- (id) copyWithZone:(NSZone *)zone
{
    TourismClient *copy = [[[self class] allocWithZone:zone] init];
    [copy setResources:self.resources andHomeUrl:self.homeUrl];
    return copy;
}

/**
 * \brief Sets the client stub to use a given version.
 * @param version the version to be used.
 */
- (void) setVersion:(NSString *) version
{
    _version = version;
}

/**
 * \brief Gets all the available capacities for the queried servers
 * @param err to indicate a given error.
 * @return a set of terms allowed for the server or nil (and an error description).
 */
- (NSArray *) getAvailableResources:(NSError **) err
{
    if(![self resources] && ![self verifyVersion: err])
        return nil;
    
    return [self.resources getResources:self.version];
}

/**
 * \brief Checks whether a given resource is available for the queried server.
 * @param term a given term.
 * @param err to indicate a given error.
 * @return <code>true</code> if available, <code>false</code> otherwise. In case of negative return, err may contain an error description.
 */
- (BOOL) hasResource:(ResourceTerm) term :(NSError **) err
{
    if(![self resources] && ![self verifyVersion:err])
        return false;
    
    return [self.resources hasResource:[ResourceTerms getResource:term] inVersion:self.version];
}

/**
 * \brief Checks whether the server has a given resource.
 * @param type the type to search for.
 * @param err to indicate a given error.
 * @return <code>true</code> if the server has any given resource of the referred type <code>false</code> otherwise.
 */
- (BOOL) hasAnyResourcesOf:(ResourceType) type :(NSError **) err;
{
    if(![self resources] && ![self verifyVersion:err])
        return false;
    
    NSArray* resources = [ResourceTerms getResources];
    NSArray* resourcesOf = [resources subarrayWithRange:[ResourceTerms getRange:type]];
    
    for(int i = 0; i < [resourcesOf count]; i++) {
        if([self.resources hasResource:[resourcesOf objectAtIndex:i] inVersion:self.version])
            return true;
    }
    
    return false;
}

/**
 * \brief Checks whether a given resource is presented with a given parameter
 * @param resource the resource term.
 * @param parameter the parameter term to check.
 * @param err to indicate a given error.
 * @return <code>true</code> if the resource has a given parameter or <code>false</code> otherwise.
 */
- (BOOL) hasResource:(ResourceTerm) resource withParameter:(ParameterTerm) parameter :(NSError **) err
{
    if(![self resources] && ![self verifyVersion:err])
        return false;
    
    return [self.resources hasResourceParameter:[ParameterTerms getTerm:parameter] inResource:[ResourceTerms getResource:resource] inVersion:self.version];
}

/**
 * \brief Returns a list of POIs following the desired parameters.
 * <p>If such parameters are not valid terms for a POI, it will set an error.</p>
 * @param list the parameters that should be followed.
 * @param err error can be set to the following: 
 * <ul>
 * <li>if the given parameterList contains invalid POI terms;</li>
 * <li>in case of socket errors;</li>
 * <li>if the server does not support the a term found in the parameterList;</li>
 * <li>in case of unforeseen errors;</li>
 * <li>if the server returns a code different from HTTP 200 OK.</li>
 * @return a {@link ListPointOfInterest}.
 */
- (ListPointOfInterest *) getPois:(ParameterList *)list :(NSError **) err
{
    return (ListPointOfInterest *)[self getList:list ofResource:FIND_POI usingParser:@selector(parseJsonAsListOfPois:) :err];
}

/**
 * \brief Returns a list of Events following the desired parameters.
 * <p>If such parameters are not valid terms for an Event, it will set an error.</p>
 * @param list the parameters that should be followed.
 * @param err error can be set to the following:
 * <ul>
 * <li>if the given parameterList contains invalid Event terms;</li>
 * <li>in case of socket errors;</li>
 * <li>if the server does not support the a term found in the parameterList;</li>
 * <li>in case of unforeseen errors;</li>
 * <li>if the server returns a code different from HTTP 200 OK.</li>
 * @return a {@link ListEvent}.
 */
- (ListEvent *) getEvents:(ParameterList *)list :(NSError **) err
{
    return (ListEvent *)[self getList:list ofResource:FIND_EVENT usingParser:@selector(parseJsonAsListOfEvents:) :err];
}

/**
 * \brief Returns a list of Routes following the desired parameters.
 * <p>If such parameters are not valid terms for a Route, it will set an error.</p>
 * @param list the parameters that should be followed.
 * @param err error can be set to the following:
 * <ul>
 * <li>if the given parameterList contains invalid Route terms;</li>
 * <li>in case of socket errors;</li>
 * <li>if the server does not support the a term found in the parameterList;</li>
 * <li>in case of unforeseen errors;</li>
 * <li>if the server returns a code different from HTTP 200 OK.</li>
 * @return a {@link ListRoute}.
 */
- (ListRoute *) getRoutes:(ParameterList *)list :(NSError **) err
{
    return (ListRoute *)[self getList:list ofResource:FIND_ROUTE usingParser:@selector(parseJsonAsListOfRoutes:) :err];
}

/**
 * \brief Returns the complete description of a given POI.
 * @param poiBase the base URL of the POI.
 * @param poiID the ID of the POI.
 * @param err error can be set to the following:
 * <ul>
 * <li>in case of socket errors;</li>
 * <li>in case of unforeseen errors;</li>
 * <li>if the server returns a code different from HTTP 200 OK.</li>
 * @return a {@link PointOfInterest} containing a complete description of the POI.
 */
- (PointOfInterest *) getPoi:(NSString *)poiBase withId:(NSString *)poiID :(NSError**) err
{
    return (PointOfInterest *)[self getSingle:poiBase withId:poiID usingParser:@selector(parseJsonAsPointOfInterest:) :err];
}

/**
 * \brief Returns the a given Event.
 * @param eventBase the base URL of the Event.
 * @param eventID the ID of the Event.
 * @param err error can be set to the following:
 * <ul>
 * <li>in case of socket errors;</li>
 * <li>in case of unforeseen errors;</li>
 * <li>if the server returns a code different from HTTP 200 OK.</li>
 * @return a {@link Event} containing the description of the Event.
 */
- (Event *) getEvent:(NSString *) eventBase withID:(NSString *) eventID :(NSError **) err
{
    return (Event *)[self getSingle:eventBase withId:eventID usingParser:@selector(parseJsonAsEvent:) :err];
}

/**
 * \brief Returns the a given Route.
 * @param routeBase the base URL of the Route.
 * @param routeID the ID of the Route.
 * @param err error can be set to the following:
 * <ul>
 * <li>in case of socket errors;</li>
 * <li>in case of unforeseen errors;</li>
 * <li>if the server returns a code different from HTTP 200 OK.</li>
 * @return a {@link Route} containing the description of the Route.
 */
- (Route *) getRoute:(NSString *) routeBase withID:(NSString *) routeID :(NSError **) err
{
    return (Route *)[self getSingle:routeBase withId:routeID usingParser:@selector(parseJsonAsRoute:) :err];
}

/**
 * \brief Returns the list of {@link Category} available. List should contain a parameter its value set to one of the following:
 * <ul>
 * <li>poi;</li>
 * <li>event;</li>
 * <li>route.</li>
 * </ul>
 * @param list the parameters that should be followed
 * @param err error can be set to the following:
 * <ul>
 * <li>if the given parameterList contains invalid Category parameters;</li>
 * <li>in case of socket errors;</li>
 * <li>if the server does not support the a term found in the parameterList;</li>
 * <li>in case of unforeseen errors;</li>
 * <li>if the server returns a code different from HTTP 200 OK.</li>
 * @return a {@link Category}.
 */
- (Category *) getCategories:(ParameterList *)list :(NSError **) err
{
    return (Category *)[self getCategorization:list ofResource:FIND_CATEGORIES usingParser:@selector(parseJsonAsCategory:) :err];
}

/**
 * \brief Returns the list of {@link Tag} available. List should contain a parameter its value set to one of the following:
 * <ul>
 * <li>poi;</li>
 * <li>event;</li>
 * <li>route.</li>
 * </ul>
 * @param list the parameters that should be followed
 * @param err error can be set to the following:
 * <ul>
 * <li>if the given parameterList contains invalid Tag parameters;</li>
 * <li>in case of socket errors;</li>
 * <li>if the server does not support the a term found in the parameterList;</li>
 * <li>in case of unforeseen errors;</li>
 * <li>if the server returns a code different from HTTP 200 OK.</li>
 * @return a {@link ListTag}.
 */
- (ListTag *) getTags:(ParameterList *)list :(NSError **) err
{
    return (ListTag *)[self getCategorization:list ofResource:FIND_TAGS usingParser:@selector(parseJsonAsTags:) :err];
}

@end
