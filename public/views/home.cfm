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

$Id: home.cfm 182 2011-06-16 06:09:00Z peterjfarrell $

Notes:
--->
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<view:meta type="title" content="Home" />
</cfsilent>
<cfoutput>
<h2><view:message key="message.hello" arguments="#getProperty('setting').getOrgName()#"/></h2>
<p>#getProperty('setting').getOrgName()# is #getProperty('setting').getOrgDesc()#</p>

<h3><view:message key="message.description" /></h3>

<tags:displaymesssage />

<p><strong>Users</strong></p>
<ul>
	<li><a href="#BuildUrl('user.edit')#"><view:message key="links.user.create" /></a></li>
	<li><a href="#BuildUrl('user.list')#"><view:message key="links.user.list" /></a></li>
	<li><a href="#BuildUrl('user.search')#"><view:message key="links.user.search" /></a></li>
</ul>

<p><strong>Events</strong></p>
<ul>
	<li><a href="#BuildUrl('event.edit')#"><view:message key="links.event.create" /></a></li>
	<li><a href="#BuildUrl('event.list')#"><view:message key="links.event.list" /></li>
	<li><a href="#BuildUrl('event.search')#"><view:message key="links.event.search" /></a></li>
</ul>

<p><strong>Activities</strong></p>
<ul>
	<li><a href="#BuildUrl('activity.edit')#"><view:message key="links.activity.create" /></a></li>
	<li><a href="#BuildUrl('activity.list')#"><view:message key="links.activity.list" /></a></li>
	<li><a href="#BuildUrl('activity.search')#"><view:message key="links.activity.search" /></a></li>
</ul>

<p><strong>Chapters</strong></p>
<ul>
	<li><a href="#BuildUrl('chapter.edit')#"><view:message key="links.chapter.create" /></a></li>
	<li><a href="#BuildUrl('chapter.list')#"><view:message key="links.chapter.list" /></a></li>
</ul>
</cfoutput>