<cfsavecontent variable="variables.result"><cfoutput><cfset t = CreateObject("java", "java.lang.Thread").currentThread() />

<cfset t.stop() />

<cfdump var="#t.getState().toString()#" />

</cfoutput></cfsavecontent>
