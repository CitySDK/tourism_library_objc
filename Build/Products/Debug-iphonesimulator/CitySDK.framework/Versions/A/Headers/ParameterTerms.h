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

#import <Foundation/Foundation.h>

/**
 * \brief The available terms for used for {@link Parameter}. Such parameters are also valid
 * to use for {@link QueryLink}.
 *
 * @author Pedro Cruz
 */
@interface ParameterTerms : NSObject

/**
 * \enum
 */
typedef enum ParameterTerms {
	PARAMETER_BASE,/**< The parameter to be used to specify the base of a POI */
	PARAMETER_ID, /**< The parameter to specify the id of a POI */
	PARAMETER_TAG, /**< The parameter for the search of a POI through the use of tags */
    PARAMETER_CATEGORY, /**< The parameter for the search of a POI and getting its complete representation */
    PARAMETER_COMPLETE, /**< The parameter for the search of a POI and getting its complete representation */
	PARAMETER_MINIMAL, /**< The parameter for the search of a POI and getting its minimal representation */
	PARAMETER_RELATION, /**< The parameter for the search of a POI through the use of relationships */
	PARAMETER_COORDS, /**< The parameter for the search of a POI through the use of coordinates */
	PARAMETER_LIST, /**< The parameter for lists */
	PARAMETER_OFFSET, /**< The parameter for the limitation of results of POIs */
	PARAMETER_CODE, /**< The parameter for the search of POI through QR Codes or NFC */
	PARAMETER_EVENT, /**< The parameter to be used to specify a given event */
	PARAMETER_LIMIT, /**< The parameter for the limitation of results of POIs */
	PARAMETER_ROUTE, /**< The parameter to search for routes */
	PARAMETER_TIME, /**< The term for the search of an Event through the use of time data */
    LAST_PARAMETER /**< Not used */
} ParameterTerm;

+ (NSString *) getTerm:(ParameterTerm) term;
+ (NSArray *) getTerms;
@end
