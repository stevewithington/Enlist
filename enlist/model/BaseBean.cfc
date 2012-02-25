<!---
	Class: BaseBean
	A base class for beans, implementing some useful stuff like setting/getting mementos, etc...

	Author:
		Adam Presley


	SECTION: Variables

	Private Variables:
		- instance - Contains this bean's instance data


	SECTION: Functions
--->
<cfcomponent displayname="BaseBean" output="false">
	
	<cfset variables.instance = {} />


	<!---
		Constructor: init
		Constructor to initialize this bean.
	--->
	<cffunction name="init" access="public" output="false">
		<cfset setMemento(data = arguments) />
		<cfreturn this />
	</cffunction>

	<!---
		Function: getMemento
		Returns this bean's instance data.

		Author:
			Adam Presley

		Visiblity:
			public

		Returns:
			A structure containing this bean's data
	--->
	<cffunction name="getMemento" returntype="struct" access="public" output="false">
		<cfreturn variables.instance />
	</cffunction>

	<!---
		Function: setMemento
		Sets this bean's instance data.

		Author:
			Adam Presley

		Visibility:
			public

		Parameters:
			data - A structure of values used to set this bean's instance data with
			overwrite - True/false to overwrite the instance data. Defaults to true
	--->
	<cffunction name="setMemento" access="public" output="false">
		<cfargument name="data" type="struct" required="true" />
		<cfargument name="overwrite" type="boolean" required="false" default="true" />

		<cfset structAppend(variables.instance, arguments.data, arguments.overwrite) />
	</cffunction>

	<!---
		Function: setMementoFromQuery
		Sets this bean's instance data from a query record.

		Author:
			Adam Presley

		Visibility:
			public

		Parameters:
			query - A query object to pull data from
			rowNumber - The row in the query to use for populating this bean's instance data. Defaults to 1
			overwrite - True/false to overwrite the instance data. Defaults to true
	--->
	<cffunction name="setMementoFromQuery" access="public" output="false">
		<cfargument name="query" type="query" required="true" />
		<cfargument name="rowNumber" type="numeric" required="false" default="1" />
		<cfargument name="overwrite" type="boolean" required="false" default="true" />

		<cfset var columnName = "" />
		<cfset var result = {} />

		<cfloop list="#arguments.query.columnList#" index="columnName">
			<cfset result[columnName] = arguments.query[columnName][arguments.rowNumber] />
		</cfloop>

		<cfset setMemento(result, arguments.overwrite) />
	</cffunction>

</cfcomponent>