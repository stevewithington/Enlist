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
<cfcomponent output="false">

	<cffunction name="getUser" access="public" returntype="enlist.model.user.User" output="false">
		<cfargument name="ID" type="numeric" required="false" default="0">
		<cfargument name="googleEmail" type="string" required="false" default="">

		<cfset var user = '' />
		<cfset var userQry = 0 />
		<cfset var data = structNew() />

		<cfif arguments.ID eq 0 AND arguments.googleEmail EQ "">
			<cfset user = createObject("component", "enlist.model.user.User").init() />
		<cfelse>
			<cfquery name="userQry">
			select 	*
			from	user
			where
			<cfif val(arguments.id)>
				id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ID#" />
			<cfelse>
				googleEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.googleEmail#">
			</cfif>
			</cfquery>
			<cfloop list="#userQry.columnList#" index="field">
				<cfset 'data.#field#' = evaluate('userQry.#field#')>
			</cfloop>
			<cfset user = createObject("component", "enlist.model.user.User").init(argumentcollection=data) />
		</cfif>

		<cfreturn user />
	</cffunction>

	<cffunction name="getUsers" access="public" returntype="query" output="false">
		<cfset var users = 0>
		<cfquery name="users">
		select 	*
		from	user
		order by firstName
		</cfquery>
		<cfreturn users />
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="user" type="enlist.model.user.user" required="true">
		<cfif Val(arguments.user.getID()) neq 0>
			<cfset update(arguments.user)>
		<cfelse>
			<cfset create(arguments.user)>
		</cfif>
	</cffunction>
	
	<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="user" type="enlist.model.user.user" required="yes">
		<cfset var data = user.getInstanceMemento()>
		<cfset var newuser = ''>
		<cfset var qMaxID = ''>
		
		<cftransaction>
		<cfquery name="newuser">
		INSERT INTO user (	status, role, chapterId, firstName, lastName, googleEmail, altEmail, phone, address1, address2,
		city, state, zip, importHashCode )
		VALUES (
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.status#" null="#yesnoformat(len(data.status) eq 0)#" maxlength="50">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.role#" null="#yesnoformat(len(data.role) eq 0)#" maxlength="50">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#data.chapterID#" null="#yesnoformat(len(data.chapterID) eq 0)#" maxlength="5">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.firstName#" null="#yesnoformat(len(data.firstName) eq 0)#" maxlength="50">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.lastName#" null="#yesnoformat(len(data.lastName) eq 0)#" maxlength="50">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.googleEmail#" null="#yesnoformat(len(data.googleEmail) eq 0)#" maxlength="255">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.altEmail#" null="#yesnoformat(len(data.altEmail) eq 0)#" maxlength="255">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.phone#" null="#yesnoformat(len(data.phone) eq 0)#" maxlength="50">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.address1#" null="#yesnoformat(len(data.address1) eq 0)#" maxlength="50">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.address2#" null="#yesnoformat(len(data.address2) eq 0)#" maxlength="50">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.city#" null="#yesnoformat(len(data.city) eq 0)#" maxlength="50">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.state#" null="#yesnoformat(len(data.state) eq 0)#" maxlength="50">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.zip#" null="#yesnoformat(len(data.zip) eq 0)#" maxlength="50">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#createUUID()#">
		)
		</cfquery>
		<cfquery name="qMaxID">
		SELECT LAST_INSERT_ID() as maxID
		</cfquery>
		</cftransaction>
		<cfset user.setId(qMaxID.maxID)>
	</cffunction>

	<cffunction name="update" access="private" returntype="void" output="false">
		<cfargument name="user" type="enlist.model.user.user" required="yes">
		<cfset var data = user.getInstanceMemento()>
		<cfset var updateuser = 0>
		<cfquery name="updateuser">
		UPDATE user
		SET 
			status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.status#" null="#yesnoformat(len(data.status) eq 0)#" maxlength="50">,
			role = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.role#" null="#yesnoformat(len(data.role) eq 0)#" maxlength="50">,
			chapterID = <cfqueryparam cfsqltype="cf_sql_integer" value="#data.chapterID#" null="#yesnoformat(len(data.chapterID) eq 0)#" maxlength="5">,
			firstName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.firstName#" null="#yesnoformat(len(data.firstName) eq 0)#" maxlength="50">,
			lastName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.lastName#" null="#yesnoformat(len(data.lastName) eq 0)#" maxlength="50">,
			googleEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.googleEmail#" null="#yesnoformat(len(data.googleEmail) eq 0)#" maxlength="255">,
			altEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.altEmail#" null="#yesnoformat(len(data.altEmail) eq 0)#" maxlength="255">,
			phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.phone#" null="#yesnoformat(len(data.phone) eq 0)#" maxlength="50">,
			address1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.address1#" null="#yesnoformat(len(data.address1) eq 0)#" maxlength="50">,
			address2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.address2#" null="#yesnoformat(len(data.address2) eq 0)#" maxlength="50">,
			city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.city#" null="#yesnoformat(len(data.city) eq 0)#" maxlength="50">,
			state = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.state#" null="#yesnoformat(len(data.state) eq 0)#" maxlength="50">,
			zip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.zip#" null="#yesnoformat(len(data.zip) eq 0)#" maxlength="50">
		WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#data.id#">
		</cfquery>
	</cffunction>

</cfcomponent>