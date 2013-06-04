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
 * \brief Terms used within the JSON message. These can be used to read data (with {@link DataReader})
 * so to get the values of given fields within a {@link POI} based
 * class.
 *
 * @author Pedro Cruz
 *
 */
@interface Terms : NSObject
typedef enum Term {
	AUTHOR_TERM_PRIMARY,
	AUTHOR_TERM_SECONDARY,
	AUTHOR_TERM_CONTRIBUTER,
	AUTHOR_TERM_EDITOR,
	AUTHOR_TERM_PUBLISHER,
	LABEL_TERM_PRIMARY,
	LABEL_TERM_NOTE,
	TIME_TERM_START,
	TIME_TERM_END,
	TIME_TERM_INSTANT,
	TIME_TERM_OPEN,
	LINK_TERM_ALTERNATE,	 /**< \brief a identical POI. Often used as a permalink */
	LINK_TERM_CANONICAL,	 /**< \brief the preferred version of a set of POIs with highly similar content. For example, there could be many different perceptions of a neighborhood boundary POI, but the city's neighborhood map could be the canonical version of this POI. */
	LINK_TERM_COPYRIGHT,	 /**< \brief a copyright statement that applys to the link's context */
	LINK_TERM_DESCRIBEDBY,   /**< \brief more information about this POI */
	LINK_TERM_EDIT,			 /**< \brief a resource that can be used to edit the POI's context */
	LINK_TERM_ENCLOSURE,	 /**< \brief a related resource that is potentially large and might require special handling */
	LINK_TERM_ICON,
	LINK_TERM_LATEST_VERSION,/**< \brief points to a resource containing the latest version */
	LINK_TERM_LICENSE,     /**< \brief a license for this POI */
	LINK_TERM_RELATED,     /**< \brief a related resource */
	LINK_TERM_SEARCH,      /**< \brief a resource that can be used to search through the link's context and related resources */
	LINK_TERM_PARENT,      /**< \brief a parent POI, often the enclosing geographic entity, or the entity this POI in under the domain of (such as a field office-corporate headquarters relationship) */
	LINK_TERM_CHILD,       /**< \brief a child POI, often a geography entity enclosed or under the domain of this POI */
	LINK_TERM_HISTORIC,    /**< \brief links to a POI or other web resource that describes this place at a previous point in time */
	LINK_TERM_FUTURE,      /**< \brief links to a POI or other web resource that describes this place at a later point in time */
	POINT_TERM_CENTER,
	POINT_TERM_NAVIGATION_POINT,
	POINT_TERM_ENTRANCE,
	RELATIONSHIP_TERM_EQUALS,
	RELATIONSHIP_TERM_DISJOINT,
	RELATIONSHIP_TERM_CROSSES,
	RELATIONSHIP_TERM_OVERLAPS,
	RELATIONSHIP_TERM_WITHIN,
	RELATIONSHIP_TERM_CONTAINS,
	RELATIONSHIP_TERM_TOUCHES,
    LAST_FIELD_TERM
} Term;

+ (NSString *) getTerm:(Term) term;
@end
