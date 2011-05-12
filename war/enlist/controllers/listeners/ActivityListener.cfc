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
	displayname="ActivityListener"
	extends="MachII.framework.Listener"
	output="false"
	depends="activityService,eventService,sessionFacade">

	<!---
	PROPERTIES
	--->

	<!---
	CONFIGURATION / INITIALIZATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the listener.">
		<!--- Put custom configuration for this listener here. --->
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getActivityVolunteerHistoryForUser" returntype="array" access="public" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<cfset var authentication = getSessionFacade().getProperty("authentication")/>
		<cfset var user = ""/>
		<cfset var result = arrayNew(1)/>

		<cfif authentication.hasUser() and authentication.getIsAuthenticated()>
			<cfset user = authentication.getUser()/>
			<cfset result = getActivityService().getActivityVolunteerHistoryByUser( user.getId() ) />
		</cfif>
		<cfreturn result/>
	</cffunction>

	<cffunction name="getActivity" access="public" returntype="enlist.model.event.activity.Activity" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<cfscript>
			if (not arguments.event.isArgDefined("activity")) {
				return getActivityService().getActivity(arguments.event.getArg("id", ""));
			} else {
				return arguments.event.getArg("activity");
			}
		</cfscript>
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="saveActivity" access="public" returntype="void" output="false"
		hint="Processes the activity forms (registration, admin new/edit activity) and saves the activity">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<cfscript>
			var activity = arguments.event.getArg("activity");
			var errors = getActivityService().saveActivity(activity);

			if (not StructIsEmpty(errors)) {
				arguments.event.setArg("message", "Please correct the following errors:");
				arguments.event.setArg("errors", errors);
				redirectEvent("fail", "", true);
			} else {
				arguments.event.setArg("message", "Activity Saved");
				arguments.event.removeArg("activity");
				redirectEvent("pass", "", true);
			}
		</cfscript>
	</cffunction>

</cfcomponent>