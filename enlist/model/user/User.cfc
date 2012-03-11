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
	displayname="User"
	output="false"
	hint="A bean which models the User form.">

	<!---
	PROPERTIES
	--->
	<cfset variables.id = "" />
	<cfset variables.status = "" />
	<cfset variables.role = "" /><!--- valid values in config/properties.xml --->
	<cfset variables.chapterId = "" />
	<cfset variables.firstName = "" />
	<cfset variables.lastName = "" />
	<cfset variables.email = "" />
	<cfset variables.twitterUsername = "" />
	<cfset variables.identicaUsername = "" />
	<cfset variables.phone = "" />
	<cfset variables.address1 = "" />
	<cfset variables.address2 = "" />
	<cfset variables.city = "" />
	<cfset variables.state = "" />
	<cfset variables.zip = "" />
	<cfset variables.importHashCode = "" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="User" output="false">
		<cfargument name="id" type="string" required="false" default="" />
		<cfargument name="status" type="string" required="false" default="active" />
		<cfargument name="role" type="string" required="false" default="" />
		<cfargument name="chapterId" type="string" required="false" default="" />
		<cfargument name="firstName" type="string" required="false" default="" />
		<cfargument name="lastName" type="string" required="false" default="" />
		<cfargument name="email" type="string" required="false" default="" />
		<cfargument name="password" type="string" required="false" default="" />
		<cfargument name="passwordSalt" type="string" required="false" default="" />
		<cfargument name="twitterUsername" type="string" required="false" default="" />
		<cfargument name="identicaUsername" type="string" required="false" default="" />
		<cfargument name="phone" type="string" required="false" default="" />
		<cfargument name="address1" type="string" required="false" default="" />
		<cfargument name="address2" type="string" required="false" default="" />
		<cfargument name="city" type="string" required="false" default="" />
		<cfargument name="state" type="string" required="false" default="" />
		<cfargument name="zip" type="string" required="false" default="" />
		<cfargument name="importHashCode" type="string" required="false" default="#CreateUUID()#" />

		<cfset setInstanceMemento(arguments) />

		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getDisplayName" access="public" returntype="string" output="false">
		<cfreturn getFirstName() & " " & getLastName() />
	</cffunction>
	
	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true"/>
		
		<cfset setId(arguments.data.id) />
		<cfset setStatus(arguments.data.status) />
		<cfset setRole(arguments.data.role) />
		<cfset setChapterId(arguments.data.chapterId) />
		<cfset setFirstName(arguments.data.firstName) />
		<cfset setLastName(arguments.data.lastName) />
		<cfset setEmail(arguments.data.email) />
		<cfset setPassword(arguments.data.password) />
		<cfset setPasswordSalt(arguments.data.passwordSalt) />
		<cfset setTwitterUsername(arguments.data.twitterUsername) />
		<cfset setIdenticaUsername(arguments.data.identicaUsername) />
		<cfset setPhone(arguments.data.phone) />
		<cfset setAddress1(arguments.data.address1) />
		<cfset setAddress2(arguments.data.address2) />
		<cfset setCity(arguments.data.city) />
		<cfset setState(arguments.data.state) />
		<cfset setZip(arguments.data.zip) />
		<cfset setImportHashCode(arguments.data.importHashCode) />
	</cffunction>

	<cffunction name="getInstanceMemento" access="public"returntype="struct" output="false">
		
		<cfset var data = structnew() />
		<cfset var fieldname = "" />

		<cfloop list="id,status,role,chapterId,firstName,lastName,email,password,passwordSalt,twitterUsername,identicaUsername,phone,address1,address2,city,state,zip,importHashCode" index="fieldname">
			<cfset data[fieldname] = variables[fieldname] />
		</cfloop>

		<cfreturn data />
	</cffunction>

	<cffunction name="validate" access="public" returntype="struct" output="false">
		<cfscript>
			var errors = StructNew();
			
			if (Len(Trim(getFirstName())) EQ 0) {
				errors.firstName = "First Name is required";
			}
			
			if (Len(Trim(getLastName())) EQ 0) {
				errors.lastName = "Last name is required";
			}

			if (Len(Trim(getEmail())) EQ 0) {
				errors.email = "Email address is required";
			}

			if (getId() eq '' and Len(Trim(getPassword())) EQ 0) {
				errors.password = "Password is required";
			}
						
			if (Len(Trim(getEmail())) GT 0 
				and not IsValid("email", getEmail())) {
				errors.email = "The email address you provided is not valid";
			}
			
			return errors;
		</cfscript>
	</cffunction>
	
	<cffunction name="dump" access="public" returntype="void" output="false">
		<cfargument name="abort" type="boolean" required="false" default="false" />
		
		<cfset var property = "" />
		
		<cfloop collection="#variables#" item="property">
			<cfdump var="#variables[property]#" /><br />
		</cfloop>
		
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setId" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfset variables.id = trim(arguments.id) />
	</cffunction>
	<cffunction name="getId" access="public" returntype="string" output="false">
		<cfreturn variables.id />
	</cffunction>

	<cffunction name="setStatus" access="public" returntype="void" output="false">
		<cfargument name="status" type="string" required="true" />
		<cfset variables.status = trim(arguments.status) />
	</cffunction>
	<cffunction name="getStatus" access="public" returntype="string" output="false">
		<cfreturn variables.status />
	</cffunction>

	<cffunction name="setRole" access="public" returntype="void" output="false">
		<cfargument name="role" type="string" required="true" />
		<cfset variables.role = trim(arguments.role) />
	</cffunction>
	<cffunction name="getRole" access="public" returntype="string" output="false">
		<cfreturn variables.role />
	</cffunction>

	<cffunction name="setChapterId" access="public" returntype="void" output="false">
		<cfargument name="chapterId" type="string" required="true" />
		<cfset variables.chapterId = trim(arguments.chapterId) />
	</cffunction>
	<cffunction name="getChapterId" access="public" returntype="string" output="false">
		<cfreturn variables.chapterId />
	</cffunction>

	<cffunction name="setFirstName" access="public" returntype="void" output="false">
		<cfargument name="firstName" type="string" required="true" />
		<cfset variables.firstName = trim(arguments.firstName) />
	</cffunction>
	<cffunction name="getFirstName" access="public" returntype="string" output="false">
		<cfreturn variables.firstName />
	</cffunction>

	<cffunction name="setLastName" access="public" returntype="void" output="false">
		<cfargument name="lastName" type="string" required="true" />
		<cfset variables.lastName = trim(arguments.lastName) />
	</cffunction>
	<cffunction name="getLastName" access="public" returntype="string" output="false">
		<cfreturn variables.lastName />
	</cffunction>

	<cffunction name="setEmail" access="public" returntype="void" output="false">
		<cfargument name="email" type="string" required="true" />
		<cfset variables.email = trim(arguments.email) />
	</cffunction>
	<cffunction name="getEmail" access="public" returntype="string" output="false">
		<cfreturn variables.email />
	</cffunction>

	<cffunction name="setPassword" access="public" returntype="void" output="false">
		<cfargument name="password" type="string" required="true" />
		<cfset variables.password = trim(arguments.password) />
	</cffunction>
	<cffunction name="getPassword" access="public" returntype="string" output="false">
		<cfreturn variables.password />
	</cffunction>

	<cffunction name="setPasswordSalt" access="public" returntype="void" output="false">
		<cfargument name="passwordSalt" type="string" required="true" />
		<cfset variables.passwordSalt = trim(arguments.passwordSalt) />
	</cffunction>
	<cffunction name="getPasswordSalt" access="public" returntype="string" output="false">
		<cfreturn variables.passwordSalt />
	</cffunction>

	<cffunction name="setTwitterUsername" access="public" returntype="void" output="false">
		<cfargument name="twitterUsername" type="string" required="true" />
		<cfset variables.twitterUsername = trim(arguments.twitterUsername) />
	</cffunction>
	<cffunction name="getTwitterUsername" access="public" returntype="string" output="false">
		<cfreturn variables.twitterUsername />
	</cffunction>

	<cffunction name="setIdenticaUsername" access="public" returntype="void" output="false">
		<cfargument name="identicaUsername" type="string" required="true" />
		<cfset variables.identicaUsername = trim(arguments.identicaUsername) />
	</cffunction>
	<cffunction name="getIdenticaUsername" access="public" returntype="string" output="false">
		<cfreturn variables.identicaUsername />
	</cffunction>

	<cffunction name="setPhone" access="public" returntype="void" output="false">
		<cfargument name="phone" type="string" required="true" />
		<cfset variables.phone = trim(arguments.phone) />
	</cffunction>
	<cffunction name="getPhone" access="public" returntype="string" output="false">
		<cfreturn variables.phone />
	</cffunction>

	<cffunction name="setAddress1" access="public" returntype="void" output="false">
		<cfargument name="address1" type="string" required="true" />
		<cfset variables.address1 = trim(arguments.address1) />
	</cffunction>
	<cffunction name="getAddress1" access="public" returntype="string" output="false">
		<cfreturn variables.address1 />
	</cffunction>

	<cffunction name="setAddress2" access="public" returntype="void" output="false">
		<cfargument name="address2" type="string" required="true" />
		<cfset variables.address2 = trim(arguments.address2) />
	</cffunction>
	<cffunction name="getAddress2" access="public" returntype="string" output="false">
		<cfreturn variables.address2 />
	</cffunction>

	<cffunction name="setCity" access="public" returntype="void" output="false">
		<cfargument name="city" type="string" required="true" />
		<cfset variables.city = trim(arguments.city) />
	</cffunction>
	<cffunction name="getCity" access="public" returntype="string" output="false">
		<cfreturn variables.city />
	</cffunction>

	<cffunction name="setState" access="public" returntype="void" output="false">
		<cfargument name="state" type="string" required="true" />
		<cfset variables.state = trim(arguments.state) />
	</cffunction>
	<cffunction name="getState" access="public" returntype="string" output="false">
		<cfreturn variables.state />
	</cffunction>

	<cffunction name="setZip" access="public" returntype="void" output="false">
		<cfargument name="zip" type="string" required="true" />
		<cfset variables.zip = trim(arguments.zip) />
	</cffunction>
	<cffunction name="getZip" access="public" returntype="string" output="false">
		<cfreturn variables.zip />
	</cffunction>

	<cffunction name="setImportHashCode" access="public" returntype="void" output="false">
		<cfargument name="importHashCode" type="string" required="true" />
		<cfset variables.importHashCode = arguments.importHashCode />
	</cffunction>
	<cffunction name="getImportHashCode" access="public" returntype="UUID" output="false">
		<cfreturn variables.importHashCode />
	</cffunction>

</cfcomponent>