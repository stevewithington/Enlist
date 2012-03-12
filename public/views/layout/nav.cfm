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
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
</cfsilent>
<cfoutput>
	<!--- SUBNAV FOR USERS --->
	<cfif event.getArg('event') eq 'user.edit' OR event.getArg('event') eq 'user.list' OR event.getArg('event') eq 'user.search' OR event.getArg('event') eq 'user.view'>
		<view:message key="links.user.create" var="variables.createLinkText" />
		<view:message key="links.user.list" var="variables.listLinkText" />
		<view:message key="links.user.search" var="variables.searchLinkText" />
		<ul class="nav nav-pills">
			<li <cfif event.getArg('event') eq 'user.edit' and event.getArg('user').getId() eq 0>class="active"</cfif>><view:a event="user.edit">#variables.createLinkText#</view:a></li>
			<li <cfif event.getArg('event') eq 'user.list'>class="active"</cfif>><view:a event="user.list">#variables.listLinkText#</view:a></li>
			<li <cfif event.getArg('event') eq 'user.search'>class="active"</cfif>><view:a event="user.search">#variables.searchLinkText#</view:a></li>
		</ul>
	</cfif>

	<!--- SUBNAV FOR EVENTS --->
	<cfif event.getArg('event') eq 'event.edit' OR event.getArg('event') eq 'event.list' OR event.getArg('event') eq 'event.search' OR event.getArg('event') eq 'event.view'>
		<view:message key="links.event.create" var="variables.createLinkText" />
		<view:message key="links.event.list" var="variables.listLinkText" />
		<view:message key="links.event.search" var="variables.searchLinkText" />
		<ul class="nav nav-pills">
			<li <cfif event.getArg('event') eq 'event.edit' and event.getArg('theEvent').getId() eq 0>class="active"</cfif>><view:a event="event.edit">#variables.createLinkText#</view:a></li>
			<li <cfif event.getArg('event') eq 'event.list'>class="active"</cfif>><view:a event="event.list">#variables.listLinkText#</view:a></li>
			<li <cfif event.getArg('event') eq 'event.search'>class="active"</cfif>><view:a event="event.search">#variables.searchLinkText#</view:a></li>
		</ul>
	</cfif>	

	<!--- SUBNAV FOR ACTIVITES --->
	<cfif event.getArg('event') eq 'activity.edit' OR event.getArg('event') eq 'activity.list' OR event.getArg('event') eq 'activity.search'>
		<view:message key="links.activity.create" var="variables.createLinkText" />
		<view:message key="links.activity.list" var="variables.listLinkText" />
		<view:message key="links.activity.search" var="variables.searchLinkText" />
		<ul class="nav nav-pills">
			<li <cfif event.getArg('event') eq 'activity.edit' and event.getArg('activity').getId() eq 0>class="active"</cfif>><view:a event="activity.edit">#variables.createLinkText#</view:a></li>
			<li <cfif event.getArg('event') eq 'activity.list'>class="active"</cfif>><view:a event="activity.list">#variables.listLinkText#</view:a></li>
			<li <cfif event.getArg('event') eq 'activity.search'>class="active"</cfif>><view:a event="activity.search">#variables.searchLinkText#</view:a></li>
		</ul>
	</cfif>

	<!--- SUBNAV FOR CHAPTERS --->
	<cfif event.getArg('event') eq 'chapter.edit' OR  event.getArg('event') eq 'chapter.list'>
		<view:message key="links.chapter.create" var="variables.createLinkText" />
		<view:message key="links.chapter.list" var="variables.listLinkText" />
		<view:message key="links.chapter.search" var="variables.searchLinkText" />
		<ul class="nav nav-pills">
			<li <cfif event.getArg('event') eq 'chapter.edit'>class="active"</cfif>><view:a event="chapter.edit">#variables.createLinkText#</view:a></li>
			<li <cfif event.getArg('event') eq 'chapter.list'>class="active"</cfif>><view:a event="chapter.list">#variables.listLinkText#</view:a></li>
		</ul>
	</cfif>
</cfoutput>