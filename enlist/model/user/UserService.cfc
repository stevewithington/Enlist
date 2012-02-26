<!---

    Enlist - Volunteer Management Software
    Copyright (C) 2011 GreatBizTools, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.

$Id$

Notes:
--->
<cfcomponent
	displayname="UserService"
	extends="enlist.model.BaseService"
	output="false">

	<!---
	PROPERTIES
	--->

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="UserService" output="false">

		<cfset super.init( argumentCollection = arguments ) />

		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getUser" access="public" returntype="any" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfreturn getGateway().getUser( Val(arguments.id) ) />
	</cffunction>

	<cffunction name="getUsers" access="public" returntype="query" output="false">
		<cfreturn getGateway().getUsers() />
	</cffunction>

	<cffunction name="getUsersBySearch" access="public" returntype="query" output="false">
		<cfargument name="id" type="string" required="false" default="" />
		<cfargument name="status" type="string" required="false" default="" />
		<cfargument name="role" type="string" required="false" default="" />
		<cfargument name="chapterId" type="string" required="false" default="" />
		<cfargument name="firstName" type="string" required="false" default="" />
		<cfargument name="lastName" type="string" required="false" default="" />
		<cfargument name="altEmail" type="string" required="false" default="" />
		<cfargument name="twitterUsername" type="string" required="false" default="" />
		<cfargument name="phone" type="string" required="false" default="" />
		<cfargument name="address1" type="string" required="false" default="" />
		<cfargument name="address2" type="string" required="false" default="" />
		<cfargument name="city" type="string" required="false" default="" />
		<cfargument name="state" type="string" required="false" default="" />
		<cfargument name="zip" type="string" required="false" default="" />
			<cfreturn getGateway().search( argumentCollection = arguments ) />
	</cffunction>

	<cffunction name="getUserByAltEmail" access="public" returntype="any" output="false"
		hint="Gets an User from the datastore by Email.">
		<cfargument name="altEmail" type="string" required="true" />
		<cfreturn getGateway().getUser( altEmail = arguments.altEmail ) />
	</cffunction>

	<cffunction name="getUserByTwitterUsername" access="public" returntype="any" output="false"
		hint="Gets an User from the datastore by TwitterUsername.">
		<cfargument name="twitterUsername" type="string" required="true" />
		<cfreturn getGateway().getUser( twitterUsername = arguments.twitterUsername ) />
	</cffunction>

	<cffunction name="logoutUser" access="public" returntype="void" output="false">
		<cfargument name="user" type="enlist.model.user.User" required="true">
		<cfset getSessionFacade().deleteProperty("authentication") />
	</cffunction>

	<cffunction name="registerUser" access="public" returntype="void" output="false">
		<cfargument name="user" type="enlist.model.user.User" required="true">
		<cfset saveUser( arguments.user )>
		<cfset getSessionFacade().getProperty("authentication").setUser( arguments.user ) />
	</cffunction>

	<cffunction name="saveUser" access="public" returntype="any" output="false">
		<cfargument name="user" type="enlist.model.user.User" required="true">

		<cfset var errors = arguments.user.validate() />

		<cfif (structIsEmpty(errors))>
			<cfset getGateway().save( arguments.user ) />
			<cfset getSessionFacade().getProperty("authentication").setUser( arguments.user ) />
		</cfif>

		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->

</cfcomponent>