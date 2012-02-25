<cfsilent>
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

	$Id: edit.cfm 184 2011-06-16 06:54:39Z peterjfarrell $

	Notes:
	--->
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfimport prefix="tags" taglib="/customtags" />
	
	<cfset copyToScope("${event.navigation}") />
	
	<cfif NOT Len(variables.navigation.getId())>
		<!--- <cfset variables.type = "New" /> --->
		<!--- same as --->
		<view:message key="form.nav.add.type" var="variables.type" />
		<view:message key="form.nav.add.title" var="variables.title" />
	<cfelse>
		<view:message key="form.nav.edit.type" var="variables.type" />
		<view:message key="form.nav.edit.title" var="variables.title" variables="#variables.navigation.getName()#" />
	</cfif>
	
	<view:meta type="title" content="#variables.title#" />

	<view:script>
		$(document).ready(function(){
			$("#navForm").validate();
		});
	</view:script>
</cfsilent>
<cfoutput>

<ul class="nav nav-pills">
  <li <cfif arguments.event.getArg('event') eq 'navigation.edit'>class="active"</cfif>><view:a event="navigation.edit"><view:message key="links.nav.create" /></view:a></li>
  <li <cfif arguments.event.getArg('event') eq 'navigation.list'>class="active"</cfif>><view:a event="navigation.list"><view:message key="links.nav.list" /></view:a></li>
</ul>	
	
<!--- <tags:displaymessage />
<tags:displayerror /> --->

<h3>#variables.title#</h3>

<form:form actionEvent="navigation.save" bind="navigation" id="navForm">
	<table>
		<tr>
			<th><view:message key="form.nav.label.name" />:</th>
			<td><form:input path="name" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th><view:message key="form.nav.label.location" />:</th>
			<td><form:input path="eventName" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<td><form:hidden name="id" path="id" value="#event.getArg( "navigation" ).getID()#" /></td>
			<view:message key="buttons.nav.save" var="variables.save" />
			<td colspan="3"><form:button type="submit" name="save" value="#variables.save#" /></td>
		</tr>
	</table>
</form:form>
</cfoutput>