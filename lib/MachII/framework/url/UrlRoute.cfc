<!---

    Mach-II - A framework for object oriented MVC web applications in CFML
    Copyright (C) 2003-2010 GreatBizTools, LLC

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
 
	As a special exception, the copyright holders of this library give you 
	permission to link this library with independent modules to produce an 
	executable, regardless of the license terms of these independent 
	modules, and to copy and distribute the resultant executable under 
	the terms of your choice, provided that you also meet, for each linked 
	independent module, the terms and conditions of the license of that
	module.  An independent module is a module which is not derived from 
	or based on this library and communicates with Mach-II solely through 
	the public interfaces* (see definition below). If you modify this library, 
	but you may extend this exception to your version of the library, 
	but you are not obligated to do so. If you do not wish to do so, 
	delete this exception statement from your version.


	* An independent module is a module which not derived from or based on 
	this library with the exception of independent module components that 
	extend certain Mach-II public interfaces (see README for list of public 
	interfaces).

Author: Kurt Wiersma (kurt@mach-ii.com)
$Id: UrlRoute.cfc 2764 2011-05-06 07:34:55Z peterjfarrell $

Created version: 1.8.0
Updated version: 1.8.0

Notes:
--->
<cfcomponent 
	displayname="UrlRoute"
	output="false"
	hint="The UrlRoute object represent a possible route for use by the UrlRoutesProperty.">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.name = "" />
	<cfset variables.moduleName = "" />
	<cfset variables.eventName = "" />
	<cfset variables.urlAlias = "" />
	<cfset variables.requiredParameters = "" />
	<cfset variables.optionalParameters = "" />
	<cfset variables.ownerId = "" />
	<cfset variables.zeroLengthStringRepresentation = "_-_NULL_-_" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="UrlRoute" output="false"
		hint="Initializes the route.">
		<cfargument name="name" type="string" required="false" default="" />
		<cfargument name="moduleName" type="string" required="false" default="" />
		<cfargument name="eventName" type="string" required="false" default="" />
		<cfargument name="urlAlias" type="string" required="false" default="" />
		<cfargument name="requiredParameters" type="array" required="false" default="#ArrayNew(1)#" />
		<cfargument name="optionalParameters" type="array" required="false" default="#ArrayNew(1)#" />
		<cfargument name="urlParameterFormatters" type="struct" required="false" default="#StructNew()#" />
		<cfargument name="zeroLengthStringRepresentation" type="string" required="false" default="_-_NULL_-_" />
		
		<cfset setName(arguments.name) />
		<cfset setModuleName(arguments.moduleName) />
		<cfset setEventName(arguments.eventName) />
		<cfset setUrlAlias(arguments.urlAlias) />
		<cfset setRequiredParameters(arguments.requiredParameters) />
		<cfset setOptionalParameters(arguments.optionalParameters) />
		<cfset setUrlParameterFormatters(arguments.urlParameterFormatters) />
		<cfset setZeroLengthStringRepresentation(arguments.zeroLengthStringRepresentation) />
		
		<cfreturn this />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS	
	--->
	<cffunction name="parseRoute" access="public" returntype="struct" output="false"
		hint="Parses route to event and module name with incoming url elements to name/value pairs.">
		<cfargument name="urlElements" type="array" required="true" />
		<cfargument name="moduleDelimiter" type="string" required="true" />
		<cfargument name="eventParameter" type="string" required="true" />
		
		<cfset var params = parseRouteParams(arguments.urlElements) />

		<cfif getModuleName() EQ "">
			<cfset params[arguments.eventParameter] = getEventName() />
		<cfelse>
			<cfset params[arguments.eventParameter] = getModuleName() & arguments.moduleDelimiter & getEventName() />
		</cfif>
		
		<!---
		Debugging code: Please do not uncommment
		<cfdump var="#getRequiredParameters()#" label="required route parameters" />
		<cfdump var="#getOptionalParameters()#" label="optional route parameters" />
		<cfdump var="#params#" label="parsed route parameters" />
		<cfabort />
		--->
		
		<cfreturn params />
	</cffunction>
	
	<cffunction name="parseRouteParams" access="public" returntype="struct" output="false"
		hint="Used in the RequestManager to form the current route url for buildCurrentUrl() and to parse params on an incoming route invocation.">
		<cfargument name="urlElements" type="array" required="true"
			hint="Array of URL elements built from the available path_info." />
		
		<cfset var params = StructNew() />
		<cfset var requiredParameters = getRequiredParameters() />
		<cfset var requiredParametersCount = ArrayLen(requiredParameters) />
		<cfset var optionalParameters = getOptionalParameters() />
		<cfset var optionalParametersCount = ArrayLen(optionalParameters) />
		<cfset var totalRequiredParametersProcessed = 0 />
		<cfset var totalOptionalParametersProcessed = 0 />
		<cfset var element = "" />
		<cfset var i = 0 />
		
		<!--- Remove route name from URL elements so we do not have to correct for it --->
		<cfset ArrayDeleteAt(arguments.urlElements, 1) />

		<!---
		Debugging code: Please do not uncomment
		<cfdump var="#arguments.urlElements#" />
		<cfabort />
		--->
		
		<cfif ArrayLen(arguments.urlElements) GTE 1>
			
			<!--- Parse the URL elements for required parameters, when required parameters run out continue with optional parameters --->
			<cfloop from="1" to="#ArrayLen(arguments.urlElements)#" index="i">
				<!--- Builds all the required parameters from the known URL elements --->
				<cfif requiredParametersCount GTE i>
					<cfset params[requiredParameters[i].name] = arguments.urlElements[i] />
					<cfset totalRequiredParametersProcessed = totalRequiredParametersProcessed + 1 />
				<!--- Continues to build with optional parameters from the remaining known URL elements --->
				<cfelseif optionalParametersCount GTE (i - requiredParametersCount)>
					<cfif arguments.urlElements[i] NEQ variables.zeroLengthStringRepresentation>
						<cfset params[optionalParameters[i - requiredParametersCount].name] = arguments.urlElements[i] />
					<cfelse>
						<cfset params[optionalParameters[i - requiredParametersCount].name] = "" />
					</cfif>
					<cfset totalOptionalParametersProcessed = totalOptionalParametersProcessed + 1 />
				</cfif>
				
				<!--- <cftrace text="i = #i#"> --->
			</cfloop>
			<!---
			Debugging code: Please do not uncomment
			<cftrace text="totalRequiredParametersProcessed = #totalRequiredParametersProcessed#, requiredParametersCount = #requiredParametersCount#"/>
			<cftrace text="totalOptionalParametersProcessed = #totalOptionalParametersProcessed#, optionalParametersCount = #optionalParametersCount#"/>
			--->
		</cfif>
	
		<!--- Check to ensure all required parameters were present --->
		<cfif totalRequiredParametersProcessed lt requiredParametersCount>
			<cfthrow type="MachII.framework.UrlRoute.RequiredParametersMissing"
				message="When attempting to process the route '#getName()#' the total number of url args processed was #totalRequiredParametersProcessed# which is less then the required parameters count of #requiredParametersCount#."
				detail="" />
		</cfif>
	
		<!--- Handle optionalArguments and add in defaults --->	
		<cfif totalOptionalParametersProcessed LT optionalParametersCount>
			<cfloop from="#totalOptionalParametersProcessed + 1#" to="#optionalParametersCount#" index="i">
				<cfset element = optionalParameters[i] />
				<cfif element.default EQ "''">
					<cfset params[element.name] = "" />
				<cfelse>
					<cfset params[element.name] = element.default />
				</cfif>
			</cfloop>
		</cfif>
				
		<!---
		Debugging code: Please do not uncomment
		<cfdump var="#params#" />
		<cfabort />
		--->

		<cfreturn params />
	</cffunction>
	
	<cffunction name="buildRouteUrl" access="public" returntype="string" output="false"
		hint="Builds a URL that matches this route definition.">
		<cfargument name="urlParameters" type="struct" required="true"
			hint="Name/value pairs to build the url with a struct of data." />
		<cfargument name="queryStringParameters" type="struct" required="true"
			hint="Name/value pairs to build the query string with a struct of data." />
		<cfargument name="urlBase" type="string" required="true" 
			hint="Base of the url." />
		<cfargument name="seriesDelimiter" type="string" required="true" />
		<cfargument name="queryStringDelimiter" type="string" required="true" />
	
		<cfset var builtUrl = "" />
		<cfset var queryString = "" />
		<cfset var params = arguments.urlParameters />
		<cfset var value = "" />
		<cfset var i = "" />
		<cfset var defaultValue = "" />	
		<cfset var isDefaultValueDefined = false />
		<cfset var usedDefaultValue = false />
		<cfset var element = "" />
		<cfset var param = 0 />
		<cfset var orderedParams = arrayNew(1) />
		<cfset var requiredParameters = getRequiredParameters() />
		<cfset var optionalParameters = getOptionalParameters() />
		<cfset var optionalParameterPosition = 0 />
		
		<!--- Add URL alias (defaults to route name if not defined) --->
		<cfset queryString = queryString & getUrlAlias() />		
		
		<!--- Build with required parameters --->
		<cfloop from="1" to="#ArrayLen(requiredParameters)#" index="i">
			
			<!--- Reset variables --->
			<cfset defaultValue = "" />
			<cfset isDefaultValueDefined = false />
			
			<!--- Get the default if defined --->
			<cfif StructKeyExists(requiredParameters[i], "default")>
				<cfset defaultValue = requiredParameters[i].default />
				<cfif defaultValue EQ "''">
					<cfset defaultValue = "" />
				</cfif>
				<cfset isDefaultValueDefined = true />
			</cfif>
			
			<!--- Ensure the required parameter has a default value --->
			<cfif NOT StructKeyExists(params, requiredParameters[i].name) AND NOT isDefaultValueDefined>
				<cfthrow type="MachII.framework.url.UrlRoute.RouteArgumentMissing"
					message="When attempting to build a url for the route '#getName()#' required parameter '#requiredParameters[i].name#' was not specified."
					detail="All parameters: #getAllParameterNames()#" />
			</cfif>
			
			<!--- Reset variables --->
			<cfset param = StructNew() />
			
			<!--- Required parameter has not been defined so use the default value --->
			<cfif NOT StructKeyExists(params, requiredParameters[i].name)>
				<cfset params[requiredParameters[i].name] = defaultValue />
				<cfset param.name = requiredParameters[i].name />
				<cfset param.value = defaultValue />
			
			<!--- Required parameter has been defined in the url params with a value so we just need to put in the ordered array --->
			<cfelse>
				<cfset param.name = requiredParameters[i].name />
				<cfset param.value = params[requiredParameters[i].name] />
			</cfif>
			
			<cfif StructKeyExists(requiredParameters[i], "formatter")>
				<cfset param.value = variables.urlParameterFormatters[requiredParameters[i].formatter].format(param.value, param.name, arguments.urlParameters) />
			</cfif>
			
			<cfset ArrayAppend(orderedParams, param) />
		</cfloop>
		
		<!--- Take the ordered required parameters and build the onto the URL --->
		<cfloop from="1" to="#ArrayLen(orderedParams)#" index="i">
			<cfif IsSimpleValue(orderedParams[i].value)>
				<cfset queryString = queryString & "/" & URLEncodedFormat(orderedParams[i].value) />
			</cfif>
		</cfloop>
		
		<!--- Reset ordered parameters for optional params --->
		<cfset orderedParams = ArrayNew(1) />

		<!--- Build with optional parameters --->
		<cfloop from="1" to="#ArrayLen(optionalParameters)#" index="i">
			
			<!--- Reset variables --->
			<cfset defaultValue = "" />
			<cfset isDefaultValueDefined = false />
			<cfset usedDefaultValue = false />
			<cfset param = StructNew() />
			
			<!--- Get the default if defined --->
			<cfif StructKeyExists(optionalParameters[i], "default")>
				<cfset defaultValue = optionalParameters[i].default />
				<cfif defaultValue EQ "''">
					<cfset defaultValue = variables.zeroLengthStringRepresentation />
				</cfif>
				<cfset isDefaultValueDefined = true />
			</cfif>
			
			<!--- Optional parameter has not been defined so use the default value --->
			<cfif NOT StructKeyExists(params, optionalParameters[i].name)>
				<cfset params[optionalParameters[i].name] = defaultValue />
				<cfset param.name = element />
				<cfset param.value = defaultValue />
				<cfset usedDefaultValue = true />
			
			<!--- Optional parameter has been defined in the url params with a value so we just need to put in the ordered array --->
			<cfelse>
				<cfset param.name = optionalParameters[i].name />
				<cfset param.value = params[optionalParameters[i].name] />
			</cfif>
			
			<cfif StructKeyExists(optionalParameters[i], "formatter")>
				<cfset param.value = variables.urlParameterFormatters[optionalParameters[i].formatter].format(param.value, param.name, arguments.urlParameters) />
			</cfif>
			
			<cfset ArrayAppend(orderedParams, param) />
			
			<!---
				Optional parameters must used up until the position 
				(i.e. if only 3rd optional parameter is defined then the 1st and 2nd parameters must be used)
			--->
			<cfif NOT usedDefaultValue>
				<cfset optionalParameterPosition = i />
			</cfif>
		</cfloop>
		
		<!---
			Take the ordered required parameters and build the onto the URL but only up to the point
			in which the optional parameters have to used
		--->
		<cfloop from="1" to="#optionalParameterPosition#" index="i">
			<cfif IsSimpleValue(orderedParams[i].value)>
				<cfset queryString = queryString & "/" & URLEncodedFormat(orderedParams[i].value) />
			</cfif>
		</cfloop>
		
		<!--- Prepend the urlBase and add trailing series delimiter --->
		<cfif Len(queryString)>
			<cfset builtUrl = arguments.urlBase & "/" & queryString />
			<cfif arguments.seriesDelimiter NEQ "&">
				<cfset builtUrl = builtUrl & arguments.seriesDelimiter />
			</cfif>
		<cfelse>
			<cfset builtUrl = arguments.urlBase />
		</cfif>
		
		<!--- Add any additional query string parameters from arguments.queryStringParameters --->
		<cfif StructCount(arguments.queryStringParameters)>
			<cfset builtUrl = builtUrl & "?" />
			<cfset i = 1 />
			
			<cfloop collection="#arguments.queryStringParameters#" item="param">
				<cfif i GT 1>
					<cfset builtUrl = builtUrl & "&" />
				</cfif>
				<cfset builtUrl = builtUrl & param & "=" & URLEncodedFormat(arguments.queryStringParameters[param]) />
				<cfset i = i + 1 />
			</cfloop>
		</cfif>
		
		<cfreturn builtUrl />
	</cffunction>
	
	<cffunction name="getAllParameterNames" access="public" returntype="string" output="false"
		hint="Gets all parameter names - both required and optional.">
		
		<cfset var parameterList = "" />
		<cfset var requiredParameters = getRequiredParameters() />
		<cfset var optionalParameters = getOptionalParameters() />
		<cfset var i = 0 />

		<cfloop from="1" to="#arrayLen(requiredParameters)#" index="i">
			<cfset parameterList = ListAppend(parameterList, requiredParameters[i].name) />
		</cfloop>
		
		<cfloop from="1" to="#arrayLen(optionalParameters)#" index="i">
			<cfset parameterList = ListAppend(parameterList, optionalParameters[i].name) />
		</cfloop>
		
		<cfreturn parameterList />
	</cffunction>
	
	<!---
	PROTECTED FUNCTIONS
	--->
	<cffunction name="explodeParameter" access="private" returntype="struct" output="false"
		hint="Explodes a parameter into a struct.">
		<cfargument name="parameterString" type="string" required="true" />
		
		<cfset var temp = StructNew() />

		<cfif arguments.parameterString.endsWith(">")>
			<cfset temp.formatter = "default" />
			<cfset arguments.parameterString = Left(arguments.parameterString, Len(arguments.parameterString) - 1) />
		<cfelseif ListLen(arguments.parameterString, ">") EQ 2>
			<cfset temp.formatter = ListLast(arguments.parameterString, ">") />
			<cfset arguments.parameterString = ListDeleteAt(arguments.parameterString, 2, ">") />
		</cfif>

		<cfif ListLen(arguments.parameterString, ":") EQ 2>
			<cfset temp.default = ListLast(arguments.parameterString, ":") />
			<cfset arguments.parameterString = ListDeleteAt(arguments.parameterString, 2, ":") />
		</cfif>
		
		<cfset temp.name = arguments.parameterString />		
		
		<cfreturn temp />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfset variables.name = arguments.name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.name />
	</cffunction>

	<cffunction name="setModuleName" access="public" returntype="void" output="false">
		<cfargument name="moduleName" type="string" required="true" />
		<cfset variables.moduleName = arguments.moduleName />
	</cffunction>	
	<cffunction name="getModuleName" access="public" returntype="string" output="false">
		<cfreturn variables.moduleName />
	</cffunction>

	<cffunction name="setEventName" access="public" returntype="void" output="false">
		<cfargument name="eventName" type="string" required="true" />
		<cfset variables.eventName = arguments.eventName />
	</cffunction>	
	<cffunction name="getEventName" access="public" returntype="string" output="false">
		<cfreturn variables.eventName />
	</cffunction>

	<cffunction name="setUrlAlias" access="public" returntype="void" output="false">
		<cfargument name="urlAlias" type="string" required="true" />
		<cfset variables.urlAlias = arguments.urlAlias />
	</cffunction>	
	<cffunction name="getUrlAlias" access="public" returntype="string" output="false"
		hint="If url alias is '' (zero-length string), return the route name.">
		<cfif isUrlAliasDefined()>
			<cfreturn variables.urlAlias />
		<cfelse>
			<cfreturn getName() />
		</cfif>
	</cffunction>
	<cffunction name="isUrlAliasDefined" access="public" returntype="boolean" output="false"
		hint="Checks if a url alias is defined.">
		<cfreturn Len(variables.urlAlias) />
	</cffunction>

	<cffunction name="setRequiredParameters" access="public" returntype="void" output="false">
		<cfargument name="requiredParameters" type="array" required="true" />
		
		<cfset var i = 0 />
		
		<!--- Explode parameters --->
		<cfloop from="1" to="#ArrayLen(arguments.requiredParameters)#" index="i">			
			<cfset arguments.requiredParameters[i]  = explodeParameter(arguments.requiredParameters[i]) />
		</cfloop>
		
		<cfset variables.requiredParameters = arguments.requiredParameters />
	</cffunction>	
	<cffunction name="getRequiredParameters" access="public" returntype="array" output="false">
		<cfreturn variables.requiredParameters />
	</cffunction>

	<cffunction name="setOptionalParameters" access="public" returntype="void" output="false">
		<cfargument name="optionalParameters" type="array" required="true" />
		
		<cfset var i = 0 />
		
		<!--- Verify that all optional parameters have a default defined and explode --->
		<cfloop from="1" to="#ArrayLen(arguments.optionalParameters)#" index="i">
			<cfif NOT ListLen(arguments.optionalParameters[i], ":") EQ 2>
				<cfthrow type="MachII.properties.UrlRoute.InvalidOptionalParams"
					message="The optional URL Route '#getName()#' with parameter '#ListGetAt(arguments.optionalParameters[i], 1, ":")#' does not have default defined.">
			</cfif>
			
			<cfset arguments.optionalParameters[i]  = explodeParameter(arguments.optionalParameters[i]) />
		</cfloop>
		
		<cfset variables.optionalParameters = arguments.optionalParameters />
	</cffunction>	
	<cffunction name="getOptionalParameters" access="public" returntype="array" output="false">
		<cfreturn variables.optionalParameters />
	</cffunction>
	
	<cffunction name="setOwnerId" access="public" returntype="void" output="false">
		<cfargument name="ownerId" type="string" required="true" />
		<cfset variables.ownerId = arguments.ownerId />
	</cffunction>	
	<cffunction name="getOwnerId" access="public" returntype="string" output="false">
		<cfreturn variables.ownerId />
	</cffunction>

	<cffunction name="setUrlParameterFormatters" access="public" returntype="void" output="false">
		<cfargument name="urlParameterFormatters" type="struct" required="true" />
		<cfset variables.urlParameterFormatters = arguments.urlParameterFormatters />
	</cffunction>
	<cffunction name="getUrlParameterFormatters" access="public" returntype="struct" output="false">
		<cfreturn variables.urlParameterFormatters />
	</cffunction>

	<cffunction name="setZeroLengthStringRepresentation" access="public" returntype="void" output="false">
		<cfargument name="zeroLengthStringRepresentation" type="string" required="true" />
		<cfset variables.zeroLengthStringRepresentation = arguments.zeroLengthStringRepresentation />
	</cffunction>	
	<cffunction name="getZeroLengthStringRepresentation" access="public" returntype="string" output="false">
		<cfreturn variables.zeroLengthStringRepresentation />
	</cffunction>

</cfcomponent>