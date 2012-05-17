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

<!---
	Class: Activity
	A bean representing an individual activity. Activities are some thing that can be done
	by one or more people at a specific event. They have a date range, as well as a
	point value and location.
--->
<cfcomponent displayname="Activity" extends="enlist.model.BaseBean" output="false">
	<!---
		Constructor: init
		Initializes this bean.

		Parameters:
			id - ID for this entity. Defaults to ""
			title - Title of this activity. Defaults to ""
			description - A longer description for this activity. Defaults to ""
			numPeople - Number of people involved. Defaults to ""
			startDate - The start date for this activity. Defaults to ""
			endDate - The end date for this activity. Defaults to ""
			pointHours - The number of points hours for this activity. Defaults to ""
			location - The location where this activity is to occur. Defaults to ""
			eventId - ID of the event this activity is related to. Defaults to ""
			event - An event bean for the event this activity is related to. 
	--->
	<cffunction name="init" access="public" output="false" returntype="enlist.model.event.activity.Activity">
		<cfargument name="id" type="string" required="false" default="" />
		<cfargument name="title" type="string" required="false" default=""/>
		<cfargument name="description" type="string" required="false" default="" />
		<cfargument name="numPeople" type="string" required="false" default="" />
		<cfargument name="startDate" type="string" required="false" default="" />
		<cfargument name="endDate" type="string" required="false" default="" />
		<cfargument name="pointHours" type="string" required="false" default="" />
		<cfargument name="location" type="string" required="false" default="" />
		<cfargument name="eventId" type="string" required="false" default="" />
		<cfargument name="event" type="enlist.model.event.Event" required="false" />

		<cfset this = super.init(argumentCollection = arguments) />

		<cfif !structKeyExists(arguments, "event")>
			<cfset variables.instance.event = createObject("component", "enlist.model.event.Event").init() />
		</cfif>

		<cfreturn this />
	</cffunction>


	<!---
		PUBLIC FUNCTIONS
	--->

	<!---
		Function: validate
		Validates that the data for this bean is indeed correct. This will record a
		structure that contains keys for any fields that have errors.

		Visibility:
			public

		Returns:
			A structure whose keys are fields of this bean that contain errors
	--->
	<cffunction name="validate" access="public" returntype="struct" output="false">
		<cfscript>
			// TODO: not sure what's required and what isn't. Are point hours integers or are floats allowed?
			var errors = StructNew();
			
			if (Len(Trim(getEventId())) eq 0) {
				errors.eventId = "An activity must be associated with an event";
			}
			
			if (Len(Trim(getTitle())) eq 0) {
				errors.title = "An activity title is required";
			}
			
			if (Len(Trim(getNumPeople())) neq 0 
				and not IsValid("integer", getNumPeople())) {
				errors.numPeople = "Number of people must be an integer";
			}
			
			if (Len(Trim(getStartDate())) neq 0 
				and not IsValid("date", getStartDate())) {
				errors.startDate = "The start date is not valid";
			}
			
			if (Len(Trim(getEndDate())) neq 0 
				and not IsValid("date", getEndDate())) {
				errors.endDate = "The end date is not valid";
			}
			
			if (IsValid("date", getStartDate()) and IsValid("date", getEndDate()) 
				and getStartDate() gt getEndDate()) {
				errors.endDate = "The end date must be the same as or later than the start date";
			}
			
			return errors;
		</cfscript>
	</cffunction>


	<!---
		ACCESSORS / MUTATORS
	--->
	<cffunction name="getId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.id />
	</cffunction>
	
	<cffunction name="setId" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfset variables.instance.id = arguments.id />
	</cffunction>

	<cffunction name="getTitle" returntype="string" access="public" output="false">
		<cfreturn variables.instance.title />
	</cffunction>
	
	<cffunction name="setTitle" returntype="void" access="public" output="false">
		<cfargument name="title" type="string" required="true" />
		<cfset variables.instance.title = arguments.title />
	</cffunction>

	<cffunction name="getDescription" returntype="string" access="public" output="false">
		<cfreturn variables.instance.description />
	</cffunction>
	
	<cffunction name="setDescription" returntype="void" access="public" output="false">
		<cfargument name="description" type="string" required="true" />
		<cfset variables.instance.description = arguments.description />
	</cffunction>

	<cffunction name="getNumPeople" returntype="string" access="public" output="false">
		<cfreturn variables.instance.numPeople />
	</cffunction>
	
	<cffunction name="setNumPeople" returntype="void" access="public" output="false">
		<cfargument name="numPeople" type="string" required="true" />
		<cfset variables.instance.numPeople = arguments.numPeople />
	</cffunction>

	<cffunction name="getStartDate" returntype="string" access="public" output="false">
		<cfreturn dateFormat(variables.instance.startDate, "MM/dd/yyyy") />
	</cffunction>
	
	<cffunction name="setStartDate" returntype="void" access="public" output="false">
		<cfargument name="startDate" type="string" required="true" />
		<cfset variables.instance.startDate = arguments.startDate />
	</cffunction>

	<cffunction name="getEndDate" returntype="string" access="public" output="false">
		<cfreturn dateFormat(variables.instance.endDate, "MM/dd/yyyy") />
	</cffunction>
	
	<cffunction name="setEndDate" returntype="void" access="public" output="false">
		<cfargument name="endDate" type="string" required="true" />
		<cfset variables.instance.endDate = arguments.endDate />
	</cffunction>

	<cffunction name="getPointHours" returntype="string" access="public" output="false">
		<cfreturn variables.instance.pointHours />
	</cffunction>
	
	<cffunction name="setPointHours" returntype="void" access="public" output="false">
		<cfargument name="pointHours" type="string" required="true" />
		<cfset variables.instance.pointHours = arguments.pointHours />
	</cffunction>

	<cffunction name="getLocation" returntype="string" access="public" output="false">
		<cfreturn variables.instance.location />
	</cffunction>
	
	<cffunction name="setLocation" returntype="void" access="public" output="false">
		<cfargument name="location" type="string" required="true" />
		<cfset variables.instance.location = arguments.location />
	</cffunction>

	<cffunction name="getEvent" access="public" returntype="enlist.model.event.Event" output="false">
		<cfreturn variables.instance.event />
	</cffunction>
	
	<cffunction name="setEvent" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true" />
		<cfset variables.instance.event = arguments.event />
	</cffunction>
	
	<cffunction name="getEventId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.eventId />
	</cffunction>
	
	<cffunction name="setEventId" access="public" returntype="void" output="false">
		<cfargument name="eventId" type="string" required="true" />
		<cfset variables.instance.eventId = arguments.eventId />
	</cffunction>

	<cffunction name="setInstanceData" access="public" output="false" returntype="void">
		<cfargument name="instance" type="struct" required="true" />
		<cfset variables.instance = arguments.instance />
	</cffunction>
	<cffunction name="getInstanceData" access="public" output="false" returntype="struct">
		<cfreturn variables.instance />
	</cffunction>
	
	<cffunction name="save" returntype="void" access="public" output="false">
		
	</cffunction>
</cfcomponent>