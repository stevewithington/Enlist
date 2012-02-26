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
<cfcomponent displayname="ActivityGateway" output="false">	
	
	<!---
		INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="ActivityGateway" output="false" hint="Initializes the gateway.">
		<cfreturn this />
	</cffunction>

	<!---
		DEPENDENCIES
	--->
    <cffunction name="getEventService" access="public" returntype="enlist.model.event.EventService" output="false">
        <cfreturn variables.eventService />
    </cffunction>

    <cffunction name="setEventService" access="public" returntype="void" output="false">
        <cfargument name="eventService" type="enlist.model.event.EventService" required="true" />
        <cfset variables.eventService = arguments.eventService />
    </cffunction>

	<cffunction name="getUserService" returntype="enlist.model.user.UserService" access="public" output="false">
		<cfreturn variables.userService />
	</cffunction>

	<cffunction name="setUserService" returntype="void" access="public" output="false">
		<cfargument name="userService" type="enlist.model.user.UserService" required="true" />
		<cfset variables.userService = arguments.userService />
	</cffunction>

	<!---
		PUBLIC FUNCTIONS
	--->

	<!---
		Function: list
		A method for getting a list of activities. You are able to filter the query from
		a series of filters.

		Visibility:
			public

		Parameters:
			id - Filter query results by a specific ID
			title - Filter query where title is like this clause
			description - Filter query by description
			numPeople - Filter by number of people at this activity
			startDate - Filter by the activity start date
			endDate - Filter by the activity end date
			pointHours - Filter by number of point hours for this activity
			location - Filter by location
			eventId - Filter by the event this activity is tied to

		Returns:
			A query of activities
	--->
	<cffunction name="list" access="public" returntype="query" output="false" hint="Lists all activities.">
		<cfargument name="id" type="string" required="false" default="0" />
		<cfargument name="title" type="string" required="false" default=""/>
		<cfargument name="description" type="string" required="false" default="" />
		<cfargument name="numPeople" type="string" required="false" default="0" />
		<cfargument name="startDate" type="string" required="false" default="" />
		<cfargument name="endDate" type="string" required="false" default="" />
		<cfargument name="pointHours" type="string" required="false" default="0" />
		<cfargument name="location" type="string" required="false" default="" />
		<cfargument name="eventId" type="string" required="false" default="0" />

		<cfset var qryActivities = "" />

		<cfquery name="qryActivities">
			SELECT 
				  a.id
				, a.title
				, a.description
				, a.numPeople
				, a.startDate
				, a.endDate
				, a.pointHours
				, a.location
				, a.eventId

			FROM activity AS a
			WHERE 1=1
				<cfif arguments.id GT 0>
					AND a.id=<cfqueryparam value="#arguments.id#" cfsqltype="CF_SQL_INTEGER" />
				</cfif>

				<cfif len(arguments.title)>
					AND a.title LIKE <cfqueryparam value="%#arguments.title#%" cfsqltype="CF_SQL_VARCHAR" maxlength="100" />
				</cfif>

				<cfif len(arguments.description)>
					AND a.description LIKE <cfqueryparam value="%#arguments.description#%" cfsqltype="CF_SQL_VARCHAR" maxlength="1000" />
				</cfif>

				<cfif arguments.numPeople GT 0>
					AND a.numPeople=<cfqueryparam value="#arguments.numPeople#" cfsqltype="CF_SQL_INTEGER" />
				</cfif>

				<cfif isDate(arguments.startDate)>
					AND a.startDate=<cfqueryparam value="#arguments.startDate#" cfsqltype="CF_SQL_DATE" />
				</cfif>

				<cfif isDate(arguments.startDate)>
					AND a.endDate=<cfqueryparam value="#arguments.endDate#" cfsqltype="CF_SQL_DATE" />
				</cfif>
		</cfquery>
	
		<cfreturn qryActivities />
	</cffunction>

	<!---
		Function: read
		Reads an individual entity from the database into an <Activity> bean. Expects
		an ID to read from the database. If an ID is not passed in a new, blank
		bean is returned.

		Author:
			Adam Presley

		Visibility:
			public

		Parameters:
			id - ID of the activity entity to read. Defaults to zero (0)

		Returns:
			An <Activity> bean
	--->
	<cffunction name="read" returntype="enlist.model.event.activity.Activity" access="public" output="false">
		<cfargument name="id" type="string" required="false" default="0" />

		<cfset var qryActivity = "" />
		<cfset var bean = "" />
		<cfset var memento = {} />
		<cfset var columnName = "" />

		<cfset bean = createObject("component", "enlist.model.event.activity.Activity").init() />

		<cfif arguments.id GT 0>
			<cfquery name="qryActivity">
				SELECT 
					  a.id
					, a.title
					, a.description
					, a.numPeople
					, a.startDate
					, a.endDate
					, a.pointHours
					, a.location
					, a.eventId

				FROM activity AS a
				WHERE a.id=<cfqueryparam value="#arguments.id#" cfsqltype="CF_SQL_INTEGER" />
			</cfquery>

			<cfif qryActivity.recordCount>
				<cfloop list="#qryActivity.columnList#" index="columnName">
					<cfset memnto[columnName] = qryActivity[columnName] />
				</cfloop>

				<cfset bean.setInstanceMemento(memento) />
				<cfset bean.setEvent(variables.eventService.getEvent(bean.getEventId())) />
			</cfif>
		</cfif>

		<cfreturn bean />
	</cffunction>

	<!---
		Function: save
		Persists an <enlist.model.event.activity.Activity> bean to the database.

		Author:
			Adam Presley

		Visiblity:
			public

		Parameters:
			bean - <enlist.model.event.activity.Activity> bean with ID populated
	--->
	<cffunction name="save" returntype="enlist.model.event.activity.Activity" access="public" output="false">
		<cfargument name="bean" type="enlist.model.event.activity.Activity" required="true" />

		<cfset var qrySaveActivity = "" />
		<cfset var qryGetId = "" />

		<cfif len(arguments.bean.getId())>
			<cfquery name="qrySaveActivity">
				UPDATE activity SET
					  title=<cfqueryparam value="#arguments.bean.getTitle()#" cfsqltype="CF_SQL_VARCHAR" maxlength="100" />
					, description=<cfqueryparam value="#arguments.bean.getDescription()#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000" />
					, numPeople=<cfqueryparam value="#arguments.bean.getNumPeople()#" cfsqltype="CF_SQL_INTEGER" />
					, startDate=<cfqueryparam value="#arguments.bean.getStartDate()#" cfsqltype="CF_SQL_TIMESTAMP" />
					, endDate=<cfqueryparam value="#arguments.bean.getEndDate()#" cfsqltype="CF_SQL_TIMESTAMP" />
					, pointHours=<cfqueryparam value="#arguments.bean.getPointHours()#" cfsqltype="CF_SQL_NUMERIC" scale="2" />
					, location=<cfqueryparam value="#arguments.bean.getLocation()#" cfsqltype="CF_SQL_VARCHAR" maxlength="255" />
					, eventId=<cfqueryparam value="#arguments.bean.getEvent().getId()#" cfsqltype="CF_SQL_INTEGER" />

				WHERE
					id=<cfqueryparam value="#arguments.bean.getId()#" cfsqltype="CF_SQL_INTEGER" />
			</cfquery>
			
		<cfelse>
			<cfquery name="qrySaveActivity">
				INSERT INTO activity (
					  title
					, description
					, numPeople
					, startDate
					, endDate
					, pointHours
					, location
					, eventId
				) VALUES (
					<cfqueryparam value="#arguments.bean.getTitle()#" cfsqltype="CF_SQL_VARCHAR" maxlength="100" />
					, <cfqueryparam value="#arguments.bean.getDescription()#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000" />
					, <cfqueryparam value="#arguments.bean.getNumPeople()#" cfsqltype="CF_SQL_INTEGER" />
					, <cfqueryparam value="#arguments.bean.getStartDate()#" cfsqltype="CF_SQL_TIMESTAMP" />
					, <cfqueryparam value="#arguments.bean.getEndDate()#" cfsqltype="CF_SQL_TIMESTAMP" />
					, <cfqueryparam value="#arguments.bean.getPointHours()#" cfsqltype="CF_SQL_NUMERIC" scale="2" />
					, <cfqueryparam value="#arguments.bean.getLocation()#" cfsqltype="CF_SQL_VARCHAR" maxlength="255" />
					, <cfqueryparam value="#arguments.bean.getEvent().getId()#" cfsqltype="CF_SQL_INTEGER" />
				)
			</cfquery>

			<!---
				Not sure if H2 supports multi-statments in a single query command, but my first
				try did not work, so I've made it a seperate call for now.
				- Adam P
			--->
			<cfquery name="qryGetId">
				SELECT last_insert_id() AS newId
			</cfquery>

			<cfset arguments.bean.setId(qryGetId.newId) />
		</cfif>

		<cfreturn arguments.bean />
	</cffunction>

	<cffunction name="listByPropertyMap" access="public" returntype="array" output="false">
		<cfreturn addEventNamesToActivities(super.listByPropertyMap(arguments)) />
	</cffunction>

	<cffunction name="getActivityVolunteer" returntype="enlist.model.event.activity.ActivityVolunteer" access="public" output="false"
		hint="">
		<cfargument name="id" type="string" required="false" default="" />

		<cfset var activityVolunteer = "" />

		<cfif NOT Len( arguments.id )>
			<cfset activityVolunteer = createObject( "component", "enlist.model.event.activity.ActivityVolunteer" ).init( argumentCollection = arguments ) />
		<cfelse>
			<cfset activityVolunteer = GoogleQuery( "select from activityvolunteer where id == '#arguments.id#'" ) />
			<cfset activityVolunteer = activityVolunteer[1] />
		</cfif>

		<cfset activityVolunteer.setActivity( getActivity( activityVolunteer.getActivity().getId() ) ) />
		<cfset setUserFromUserStub( activityVolunteer ) />

		<cfreturn activityVolunteer />
	</cffunction>

	<cffunction name="getActivityVolunteerHistoryByUser" returntype="array" access="public" output="false"
		hint="">
		<cfargument name="userId" type="string" required="true" />

		<cfset var volunteerActivities = GoogleQuery("select from activityvolunteer where userId == '#arguments.userId#' order by scheduledEnd desc") />
		<cfset var volunteerActivity = "" />
		<cfset var user = getUserService().getUser( arguments.userId ) />

		<cfloop array="#volunteerActivities#" index="volunteerActivity">
			<cfset volunteerActivity.setActivity( getActivity( volunteerActivity.getActivityId() ) ) />
			<cfset volunteerActivity.setUser( user ) />
		</cfloop>

		<cfreturn volunteerActivities />
	</cffunction>

	<cffunction name="saveActivity" access="public" returntype="void" output="false">
		<cfargument name="activity" type="enlist.model.event.activity.Activity" required="true">
		<cfset getDAO().save( arguments.activity ) />
	</cffunction>

    <!---
	PROTECTED FUNCTIONS
	--->
	<cffunction name="setUserFromUserStub" access="private" output="false" returntype="void"
		hint="Accept a bean with a populated userId and set the User property with the instance of that userId.">
		<cfargument name="aBean" type="any" required="true" />
		
		<cfif Len(arguments.aBean.getUser().getId()) >
			<cfset arguments.aBean.setEvent( getUserService().getUser( arguments.aBean.getUser().getId() ) ) />
		</cfif>
	</cffunction>
	
	<cffunction name="addEventNamesToActivities" access="private" output="false" returntype="array" 
		hint="Takes in an activities array an adds the event names">
		<cfargument name="activities" type="array" required="true" />
		
		<cfset var activity = "" />
		
		<cfloop array="#arguments.activities#" index="activity">
			<cfset activity.setEvent( getEventService().getEvent( activity.getEventId() ) ) />
		</cfloop>
		
		<cfreturn arguments.activities />
	</cffunction>

</cfcomponent>