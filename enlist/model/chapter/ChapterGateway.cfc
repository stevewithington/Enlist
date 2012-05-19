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
	displayname="ChapterGateway"
	hint=""
	output="false">

	<!---
	PUBLIC FUNCTIONS - ScRuD
	--->
	<cffunction name="read" access="public" returntype="void" output="false">
		<cfargument name="chapterID" type="numeric" required="true" />
		<cfargument name="chapter" type="Chapter" required="true" />

		<cfset var chapterQry = 0 />
		<cfset var data = StructNew() />

		<cfif arguments.chapterID>
			<cfquery name="chapterQry">
				select 	id, name, location, status
				from	chapter
				where 	id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.chapterID#" />
			</cfquery>

			<cfloop list="#chapterQry.columnList#" index="field">
				<cfset data[field] = chapterQry[field] />
			</cfloop>

			<cfset arguments.chapter.init(argumentcollection=data) />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="chapter" type="Chapter" required="true" />

		<cfif arguments.chapter.getID()>
			<cfset update(arguments.chapter) />
		<cfelse>
			<cfset create(arguments.chapter) />
		</cfif>
	</cffunction>

	<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="chapter" type="Chapter" required="true" />

		<cfset var data = chapter.getInstanceMemento() />
		<cfset var newChapterQry = 0 />
		<cfset var maxIdQry = 0 />

		<cftransaction>
			<cfquery name="newChapterQry">
				INSERT INTO chapter (
					name
					, location
					, status
				) VALUES (
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.name#"
						null="#yesnoformat(len(data.name) eq 0)#" maxlength="100" />
					, <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.location#"
						null="#yesnoformat(len(data.location) eq 0)#" maxlength="100" />
					, <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.status#"
						null="#yesnoformat(len(data.status) eq 0)#" maxlength="50" />
				)
			</cfquery>
			<cfquery name="maxIdQry">
				SELECT LAST_INSERT_ID() as maxID
			</cfquery>
		</cftransaction>

		<cfset chapter.setId(maxIdQry.maxID) />
	</cffunction>

	<cffunction name="update" access="private" returntype="void" output="false">
		<cfargument name="chapter" type="Chapter" required="true" />

		<cfset var data = chapter.getInstanceMemento() />
		<cfset var updateChapterQry = 0 />

		<cfquery name="updateChapterQry">
		UPDATE chapter
			SET
				name =
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.name#"
						null="#yesnoformat(len(data.name) eq 0)#" maxlength="100" />
				, location =
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.location#"
						null="#yesnoformat(len(data.location) eq 0)#" maxlength="100" />
				, status =
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.status#"
						null="#yesnoformat(len(data.status) eq 0)#" maxlength="50" />
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#data.id#" />
		</cfquery>
	</cffunction>

	<!---
	PUBLIC FUNCTIONS - GATEWAY
	--->
	<cffunction name="getChapters" access="public" returntype="query" output="false">
		<cfset var chaptersQry = 0 />

		<cfquery name="chaptersQry">
			select 	id, name, location, status
			from	chapter
			order by name
		</cfquery>

		<cfreturn chaptersQry />
	</cffunction>

</cfcomponent>