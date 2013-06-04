//
//  CitySDKTests.m
//  CitySDKTests
//
//  Created by Pedro Cruz Sousa on 01/04/13.
//  Copyright (c) 2013 Pedro Cruz Sousa. All rights reserved.
//

#import "CitySDKTests.h"

NSString* const url = @"http://polar-lowlands-9873.herokuapp.com/?list=backend";

@interface CitySDKTests()
@property (nonatomic, retain) NSArray* categories;
@end

@implementation CitySDKTests
@synthesize jsonParser = _jsonParser;

- (void)setUp
{
    [super setUp];
    self.jsonParser = [[JsonParser alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testUriTemplate
{
    NSString* template = @"http://tourism.citysdk.cm-lisboa.pt/pois/search{?category,tag:6,complete,minimal,coords*,limit,offset}";

    NSMutableDictionary* coords = [[NSMutableDictionary alloc] init];
    [coords setValue:[NSNumber numberWithDouble:38.21231] forKey:@"lat"];
    [coords setValue:[NSNumber numberWithDouble:-9.12314] forKey:@"lon"];
    [coords setValue:[NSNumber numberWithDouble:1500] forKey:@"radius"];
    
    NSMutableArray* category = [[NSMutableArray alloc] init];
    [category addObject:@"museum"];
    [category addObject:@"garden"];

    UriTemplate* uriTemplate = [UriTemplate fromTemplate:template];
    [uriTemplate set:@"tag" withValue:@"notícias"];
    [uriTemplate set:@"coords" withValue:coords];
    [uriTemplate set:@"category" withValue:category];
    STAssertEqualObjects(@"http://tourism.citysdk.cm-lisboa.pt/pois/search?category=museum,garden&tag=not%C3%ADci&lat=38.21231&lon=-9.123139999999999&radius=1500", [uriTemplate build], @"URI Template produced wrong URI");
}

- (void)testListPoi
{
    NSError* err;
    TourismClient* client = [[TourismClientFactory getInstance] getClient:url :&err];
    
    if(err) {
        STFail(@"%@", [err description]);
    } else {
        NSMutableArray* values = [[NSMutableArray alloc] init];
        [values addObject:@"musem"];
        [values addObject:@"garden"];
        
        NSMutableString* coordinates = [[NSMutableString alloc] initWithFormat:@"%lf %lf %d", 31.0123123, -9.1246533, 1500];
        
        Parameter* categories = [[Parameter alloc] initWithName:@"category" andValue:values :&err];
        Parameter* coords = [[Parameter alloc] initWithName:@"coords" andValue:coordinates :&err];
        Parameter* tag = [[Parameter alloc] initWithName:@"tag" andValue:@"rock" :&err];
        
        ParameterList* parameterList = [[ParameterList alloc] init];
        [parameterList add:categories];
        [parameterList add:coords];
        [parameterList add:tag];
        
        client.version = @"1.0";
        ListPointOfInterest* pois = [client getPois:parameterList :&err];
        if(err) {
            STFail(@"%@", [err description]);
        } else {
            NSString* baseUrl = @"http://polar-lowlands-9873.herokuapp.com/v1/poi/";
            for(int i = 0; i < [pois getNumPois]; i++) {
                PointOfInterest* poi = [pois getPoi:i];
                NSString* testUrl = [[NSString alloc] initWithFormat:@"%@%d", baseUrl, (i+1)];
                NSString* poiUrl = [[NSString alloc] initWithFormat:@"%@%@", poi.base, poi.baseID];
                STAssertEqualObjects(testUrl, poiUrl, @"POI not equal");
            }
        }
    }
}

- (void)testCategories
{
    NSError *err;
    TourismClient* client = [[TourismClientFactory getInstance] getClient:url :&err];
    
    if(err) {
        STFail(@"%@", [err description]);
    } else {
        ParameterList* parameterList = [[ParameterList alloc] init];
        [parameterList add:[[Parameter alloc] initWithName:@"list" andValue:@"poi" :&err]];
        client.version = @"1.0";
        Category* categories = [client getCategories:parameterList :&err];
        if(err) {
            STFail(@"%@", [err description]);
        } else {
            [self assertCategories: categories];
        }
    }
}

- (void)assertCategories:(Category *) categories
{
    if([categories hasSubCategories]) {
        NSArray* subCategories = categories.subCategories;
        for(int i = 0; i < [subCategories count]; i++) {
            Category* cat = [subCategories objectAtIndex:i];
            STAssertTrue([self hasCategory:[DataReader getLabel:cat withTerm:LABEL_TERM_PRIMARY andLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"pt-PT"]]], @"Unknown category %@", cat.value);
        }
    }
}

- (BOOL)hasCategory:(NSString *) category
{
    if(!self.categories)
        self.categories = [[NSArray alloc] initWithObjects:@"alojamento", @"hoteis", @"hostel", @"motel", @"musica", nil];
    for(int i = 0; i < [self.categories count]; i++) {
        if([category isEqualToString:[self.categories objectAtIndex:i]])
            return true;
    }
    
    return false;
}

- (void)testPoiWithId
{
    NSError *err;
    TourismClient* client = [[TourismClientFactory getInstance] getClient:url :&err];
    
    if(err) {
        STFail(@"%@", [err description]);
    } else {
        ParameterList* parameterList = [[ParameterList alloc] init];
        [parameterList add:[[Parameter alloc] initWithName:@"tag" andValue:@"culture" :&err]];
        [parameterList add:[[Parameter alloc] initWithName:@"limit" andValue:[[NSNumber alloc] initWithInt:5] :&err]];
        [parameterList add:[[Parameter alloc] initWithName:@"offset" andValue:[[NSNumber alloc] initWithInt:0] :&err]];
        
        client.version = @"1.0";
        ListPointOfInterest* list = [client getPois:parameterList :&err];
        if(err) {
            STFail(@"%@", [err description]);
        } else {
            NSString* baseUrl = @"http://polar-lowlands-9873.herokuapp.com/v1/poi/";
            for(int i = 0; i < [list getNumPois]; i++) {
                PointOfInterest* poi = [list getPoi:i];
                poi = [client getPoi:poi.base withId:poi.baseID :&err];
                if(err) {
                    STFail(@"%@", [err description]);
                } else {
                    NSString* testUrl = [[NSString alloc] initWithFormat:@"%@%d", baseUrl, (i+1)];
                    NSString* poiUrl = [[NSString alloc] initWithFormat:@"%@%@", poi.base, poi.baseID];
                    STAssertEqualObjects(testUrl, poiUrl, @"POI not equal");
                }
            }
        }
    }
}

- (void)testAvailableLanguages
{
    NSError *err;
    TourismClient* client = [[TourismClientFactory getInstance] getClient:url :&err];
    
    if(err) {
        STFail(@"%@", [err description]);
    } else {
        NSMutableArray* values = [[NSMutableArray alloc] init];
        [values addObject:@"musem"];
        [values addObject:@"garden"];
        
        NSMutableString* coordinates = [[NSMutableString alloc] initWithFormat:@"%lf %lf %d", 31.0123123, -9.1246533, 1500];
        
        Parameter* categories = [[Parameter alloc] initWithName:@"category" andValue:values :&err];
        Parameter* coords = [[Parameter alloc] initWithName:@"coords" andValue:coordinates :&err];
        Parameter* tag = [[Parameter alloc] initWithName:@"tag" andValue:@"rock" :&err];
        
        ParameterList* parameterList = [[ParameterList alloc] init];
        [parameterList add:categories];
        [parameterList add:coords];
        [parameterList add:tag];
        
        client.version = @"1.0";
        ListPointOfInterest* pois = [client getPois:parameterList :&err];
        if(err) {
            STFail(@"%@", [err description]);
        } else {
            NSArray* langs = [[NSArray alloc] initWithObjects:[[NSLocale alloc] initWithLocaleIdentifier:@"pt-PT"], [[NSLocale alloc] initWithLocaleIdentifier:@"en-GB"], nil];
            for(int i = 0; i < [pois getNumPois]; i++) {
                NSDictionary* map = [DataReader getAvailableLangs:[pois getPoi:i] fromField:FIELD_LABELS];
                NSArray* keys = [map allKeys];
                for (int i = 0; i < [keys count]; i++) {
                    NSLocale* l = [langs objectAtIndex:i];
                    NSLocale* l2 = [map objectForKey:[keys objectAtIndex:i]];
                    STAssertEqualObjects([l objectForKey:NSLocaleCountryCode], [l2 objectForKey:NSLocaleCountryCode], @"Locale differs");
                }
            }
        }
    }
}

- (void)testDataReader
{
    NSError *err;
    TourismClient* client = [[TourismClientFactory getInstance] getClient:url :&err];
    
    if(err) {
        STFail(@"%@", [err description]);
    } else {
        NSMutableArray* values = [[NSMutableArray alloc] init];
        [values addObject:@"musem"];
        [values addObject:@"garden"];
        
        NSMutableString* coordinates = [[NSMutableString alloc] initWithFormat:@"%lf %lf %d", 31.0123123, -9.1246533, 1500];
        
        Parameter* categories = [[Parameter alloc] initWithName:@"category" andValue:values :&err];
        Parameter* coords = [[Parameter alloc] initWithName:@"coords" andValue:coordinates :&err];
        Parameter* tag = [[Parameter alloc] initWithName:@"tag" andValue:@"rock" :&err];
        
        ParameterList* parameterList = [[ParameterList alloc] init];
        [parameterList add:categories];
        [parameterList add:coords];
        [parameterList add:tag];
        
        client.version = @"1.0";
        ListEvent* events = [client getEvents:parameterList :&err];
        if(err) {
            STFail(@"%@", [err description]);
        } else {
            NSArray* eventOne = [[NSArray alloc] initWithObjects:@"Awolnation", @"Awolnation ao vivo na TMN ao Vivo", @"http://www1.sk-static.com/images/media/img/col6/20110322-001232-973681.jpg", nil];
            NSArray* eventTwo = [[NSArray alloc] initWithObjects:@"Sigur Ros", @"Sigur Ros ao vivo no Campo Pequeno", @"http://www1.sk-static.com/images/media/img/col6/20120930-091715-168615.jpg", nil];
            NSArray* eventThree = [[NSArray alloc] initWithObjects:@"Mumford and Sons", @"Mumford and Sons ao vivo no Coliseu de Lisboa", @"http://www2.sk-static.com/images/media/img/col6/20110613-051124-257858.jpg", nil];
            NSArray* eventGroup = [[NSArray alloc] initWithObjects:eventOne, eventTwo, eventThree, nil];
            
            for(int i = 0; i < [events getNumEvents]; i++) {
                int j = 0;
                Event* event = [events getEvent:i];
                NSString* label = [DataReader getLabel:event withTerm:LABEL_TERM_PRIMARY andLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"pt-PT"]];
                NSString* description = [DataReader getDescription:event withLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"pt-PT"]];
                NSArray* imgs = [DataReader getThumbnails:event];
                NSString* thumbnail = nil;
                ImageContent* content = nil;
                if(imgs && [imgs count] > 0) {
                    content = [imgs objectAtIndex:0];
                    thumbnail = content.content;
                } else {
                    STFail(@"Nil or empty images");
                }
                
                STAssertEqualObjects(label, [[eventGroup objectAtIndex:i] objectAtIndex:j++], @"Label not equal");
                STAssertEqualObjects(description, [[eventGroup objectAtIndex:i] objectAtIndex:j++], @"Description not equal");
                STAssertEqualObjects(thumbnail, [[eventGroup objectAtIndex:i] objectAtIndex:j++], @"Thumbnail not equal");
                STAssertTrue([content isByteCode] == NO, @"Image content is a bytecode");
                STAssertTrue([content isImgUri] == YES, @"Image content is not a URI");
            }
        }
    }
}

@end
