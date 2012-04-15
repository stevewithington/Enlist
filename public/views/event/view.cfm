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
  
  Notes:
  --->
  <cfimport prefix="form" taglib="/MachII/customtags/form"/>
  <cfimport prefix="view" taglib="/MachII/customtags/view"/>

  <cfset copyToScope("${event.theEvent}")/>

  <view:message key="buttons.event.edit" var="variables.save"/>
  <view:message key="meta.title.event.add" var="variables.type"/>
  <view:message key="meta.title.event.view" var="variables.title" arguments="#variables.theEvent.getName()#"/>
  <view:meta type="title" content="#variables.title#" arguments="#variables.theEvent.getName()#"/>
</cfsilent>

<cfoutput>
  <div class="container-fluid" >
  	<div class="row-fluid">
  		<div class="span10">
	<h3>#variables.title#</h3><br />
  
  
  <table>
	<tr>
		<th><view:message key="form.event.label.name" /></th>
		<td>#variables.theEvent.getName()#</td>
	</tr>
	<tr>
		<td><b><view:message key="form.event.label.location" /></th>
		<td>#variables.theEvent.getLocation()#</td>
	</tr>	
	<tr>
		<th><view:message key="form.event.label.startdate" /></th>
		<td>#variables.theEvent.getStartDate()#</td>
	</tr>
	<tr>
		<th><view:message key="form.event.label.enddate" /></th>
		<td>#variables.theEvent.getEndDate()#</td>
	</tr>
	<tr>
		<th><view:message key="form.event.label.status" /></th>
		<td>#variables.theEvent.getStatus()#</td>
	</tr>
  </table>
  <form:form actionEvent="event.edit">
	<form:hidden name="id" value="#variables.theEvent.getId()#" />
	<div class="form-actions">
	  <form:button type="submit" name="save" value="#variables.save#" class="btn btn-primary"  />
	</div>
  </form:form>
</div>
</div>
</div>
</cfoutput>