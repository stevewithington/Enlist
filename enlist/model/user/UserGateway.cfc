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
<cfcomponent output="false">

	<cffunction name="getUser" access="public" returntype="enlist.model.user.User" output="false">
		<cfargument name="ID" type="numeric" required="false" default="0">
		<cfargument name="email" type="string" required="false" default="">

		<cfset var user = CreateObject('component', 'enlist.model.user.User').init() />
		<cfset var userQry = 0 />
		<cfset var data = structNew() />

		<cfif arguments.ID neq 0 OR arguments.email neq "">
			<cfquery name="userQry">
			select 	*
			from	user
			where
			<cfif val(arguments.ID)>
				id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ID#" />
			<cfelse>
				email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
			</cfif>
			</cfquery>
			<cfloop list="#userQry.columnList#" index="field">
				<cfset 'data.#field#' = evaluate('userQry.#field#')>
			</cfloop>
			<cfset user.init(argumentcollection=data) />
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
	
	<<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="user" type="enlist.model.user.user" required="yes">
		<cfset var data = user.getInstanceMemento()>
		<cfset var newuser = ''>
		<cfset var qMaxID = ''>

		<!--- salt and hash the password --->
		<cfset data.passwordSalt = CreateUUID() />
		<cfset data.password = Hash(data.password & data.passwordSalt, 'SHA-256') />
		
		<cftransaction>
		<cfquery name="newuser">
		INSERT INTO user (	status, role, chapterId, firstName, lastName, email, password, passwordSalt, twitterUsername, identicaUsername, phone, address1, address2, city, state, zip, importHashCode )
		VALUES (
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.status#" null="#yesnoformat(len(data.status) eq 0)#" maxlength="50">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.role#" null="#yesnoformat(len(data.role) eq 0)#" maxlength="50">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#data.chapterID#" null="#yesnoformat(len(data.chapterID) eq 0)#" maxlength="5">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.firstName#" null="#yesnoformat(len(data.firstName) eq 0)#" maxlength="50">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.lastName#" null="#yesnoformat(len(data.lastName) eq 0)#" maxlength="50">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.email#" null="#yesnoformat(len(data.email) eq 0)#" maxlength="255">,
			<cfqueryparam cfsqltype="cf_sql_char" value="#data.password#" null="#yesnoformat(len(data.password) eq 0)#" maxlength="64" />,
			<cfqueryparam cfsqltype="cf_sql_char" value="#data.passwordSalt#" null="#yesnoformat(len(data.passwordSalt) eq 0)#" maxlength="35" />, 
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.twitterUsername#" null="#yesnoformat(len(data.twitterUsername) eq 0)#" maxlength="50">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.identicaUsername#" null="#yesnoformat(len(data.identicaUsername) eq 0)#" maxlength="50">,
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

		<!--- only update the password if they provided a new one, and if so generate a new salt too --->
		<cfif Len(Trim(data.password)) gt 0>
			<cfset data.passwordSalt = CreateUUID() />
			<cfset data.password = Hash(data.password & data.passwordSalt, 'SHA-256') />
		</cfif>

		<cfquery name="updateuser">
		UPDATE user
		SET 
			status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.status#" null="#yesnoformat(len(data.status) eq 0)#" maxlength="50">,
			role = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.role#" null="#yesnoformat(len(data.role) eq 0)#" maxlength="50">,
			chapterID = <cfqueryparam cfsqltype="cf_sql_integer" value="#data.chapterID#" null="#yesnoformat(len(data.chapterID) eq 0)#" maxlength="5">,
			firstName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.firstName#" null="#yesnoformat(len(data.firstName) eq 0)#" maxlength="50">,
			lastName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.lastName#" null="#yesnoformat(len(data.lastName) eq 0)#" maxlength="50">,
			email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.email#" null="#yesnoformat(len(data.email) eq 0)#" maxlength="255">,
		<cfif Len(Trim(data.password)) gt 0>
			password = <cfqueryparam cfsqltype="cf_sql_char" value="#data.password#" maxlength="64" />, 
			passwordSalt = <cfqueryparam cfsqltype="cf_sql_char" value="#data.passwordSalt#" maxlength="35" />, 
		</cfif>
			twitterUsername = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.twitterUsername#" null="#yesnoformat(len(data.twitterUsername) eq 0)#" maxlength="50">,
			identicaUsername = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.identicaUsername#" null="#yesnoformat(len(data.identicaUsername) eq 0)#" maxlength="50">,
			phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.phone#" null="#yesnoformat(len(data.phone) eq 0)#" maxlength="50">,
			address1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.address1#" null="#yesnoformat(len(data.address1) eq 0)#" maxlength="50">,
			address2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.address2#" null="#yesnoformat(len(data.address2) eq 0)#" maxlength="50">,
			city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.city#" null="#yesnoformat(len(data.city) eq 0)#" maxlength="50">,
			state = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.state#" null="#yesnoformat(len(data.state) eq 0)#" maxlength="50">,
			zip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.zip#" null="#yesnoformat(len(data.zip) eq 0)#" maxlength="50">
		WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#data.id#">
		</cfquery>
	</cffunction>
	
	<cffunction name="search" access="public" returntype="query" output="false">
		<cfargument name="user" type="enlist.model.user.User" required="true" />

		<cfset var qryUsers = "">

		<cfquery name="qryUsers">
		SELECT * FROM user WHERE
			1=1
			<cfif arguments.user.getStatus() neq ''>
				AND UPPER(status) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(arguments.user.getStatus())#">
			</cfif>
			<cfif arguments.user.getRole() neq ''>
				AND UPPER(role) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(arguments.user.getRole())#">
			</cfif>
			<cfif arguments.user.getChapterId() neq ''>
				AND chapterID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user.getChapterId()#">
			</cfif>
			<cfif arguments.user.getFirstName() neq ''>
				AND UPPER(firstName) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(arguments.user.getFirstName())#">
			</cfif>
			<cfif arguments.user.getLastName() neq ''>
				AND UPPER(lastName) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(arguments.user.getLastName())#">
			</cfif>
			<cfif arguments.user.getEmail() neq ''>
				AND UPPER(email) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(arguments.user.getEmail())#">
			</cfif>
			<cfif arguments.user.getTwitterUsername() neq ''>
				AND UPPER(twitterUsername) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(arguments.user.getTwitterUsername())#">
			</cfif>
			<cfif arguments.user.getIdenticaUsername() neq ''>
				AND UPPER(identicaUsername) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(arguments.user.getIdenticaUsername())#">
			</cfif>
			<cfif arguments.user.getPhone() neq ''>
				AND phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getPhone()#">
			</cfif>
			<cfif arguments.user.getAddress1() neq ''>
				AND UPPER(address1) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(arguments.user.getAddress1())#">
			</cfif>
			<cfif arguments.user.getAddress2() neq ''>
				AND UPPER(address2) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(arguments.user.getAddress2())#">
			</cfif>
			<cfif arguments.user.getCity() neq ''>
				AND UPPER(city) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(arguments.user.getCity())#">
			</cfif>
			<cfif arguments.user.getState() neq ''>
				AND UPPER(state) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(arguments.user.getState())#">
			</cfif>
			<cfif arguments.user.getZip() neq ''>
				AND zip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user.getZip()#">
			</cfif>
			<cfif arguments.user.getId() neq ''>
				AND id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user.getId()#">
			</cfif>
		</cfquery>
		
		<cfreturn qryUsers />
	</cffunction>

</cfcomponent>