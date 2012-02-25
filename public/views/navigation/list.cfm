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

$Id: list.cfm 184 2011-06-16 06:54:39Z peterjfarrell $

Notes:
--->
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfset copyToScope("${event.navigations}") />
	
	<view:meta type="title" content="Navigation Link List" />
</cfsilent>
<cfoutput>
	
<ul class="nav nav-pills">
  <li <cfif arguments.event.getArg('event') eq 'navigation.edit'>class="active"</cfif>><view:a event="navigation.edit"><view:message key="links.nav.create" /></view:a></li>
  <li <cfif arguments.event.getArg('event') eq 'navigation.list'>class="active"</cfif>><view:a event="navigation.list"><view:message key="links.nav.list" /></view:a></li>
</ul>

<h3>Navigation Link List</h3>

<table>
	<tr>
		<th><view:message key="form.nav.label.name" /></th>
		<th><view:message key="form.nav.label.event" /></th>
		<th><view:message key="form.nav.label.actions" /></th>
	</tr>
<cfloop array="#variables.navigations#" index="link">
	<tr>
		<td>#variables.link.getName()#</td>
		<td>#variables.link.geteventName()#</td>
		<td>
			<view:a event="navigation.edit" p:id="#variables.link.getID()#"><view:message key="links.nav.edit" /></view:a> | <view:a event="navigation.delete" p:id="#variables.link.getID()#" onClick="return confirm('Sure?')"><view:message key="links.nav.delete" /></view:a>
		</td>
	</tr>	
</cfloop> 
</table>

<p><view:a event="navigation.edit"><view:message key="links.nav.create"/></view:a></p>
</cfoutput>