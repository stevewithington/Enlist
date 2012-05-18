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

Notes:
--->
<cfcomponent
	displayname="DatabaseProperty"
	extends="MachII.framework.Property"
	output="false"
	hint="A property for the database specific settings">

	<!---
	PROPERTIES
	--->

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the property.">

		<cfset createDatabase() />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="createDatabase" access="public" returntype="void" output="false"
		hint="Creates and setup the datasource and database.">

		<cfset DatasourceCreate("enlist"
			, {
				drivername: "org.h2.Driver"
				, hoststring: "jdbc:h2:" & ExpandPath('./') & "/WEB-INF/bluedragon/h2databases/enlist;AUTO_SERVER=TRUE;IGNORECASE=false;MODE=MySQL"
				, initstring: "RUNSCRIPT FROM '#ExpandPath("../docs/sql")#/mysql_createDB.sql'\\;"
				, databasename: "enlist"
				, username: "enlist"
				, password: "enlist"
			}) />

	</cffunction>

	<cffunction name="recreateDatabase" access="public" returntype="void" output="false"
		hint="Recreates and setup the datasource and database.">

		<cfset var environmentGroup = getAppManager().getEnvironmentGroup() />

		<!--- Do not run if the environment group is production --->
		<cfif environmentGroup NEQ "production">

			<!--- Drop the objects so the init script runs again --->
			<cfquery datasource="enlist">
				drop all objects;
			</cfquery>

			<cfset DatasourceDelete("enlist") />
			<cfset createDatabase() />
		</cfif>

	</cffunction>

</cfcomponent>