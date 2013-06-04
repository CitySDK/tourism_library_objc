//
//  CitySDKTests.h
//  CitySDKTests
//
//  Created by Pedro Cruz Sousa on 01/04/13.
//  Copyright (c) 2013 Pedro Cruz Sousa. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "JsonParser.h"
#import "TourismClientFactory.h"
#import "DataReader.h"
#import "UriTemplate.h"

@interface CitySDKTests : SenTestCase
@property (nonatomic, retain) JsonParser* jsonParser;
@end
