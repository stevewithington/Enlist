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
	<cfimport prefix="tags" taglib="/enlist/customtags" />
	<cfset copyToScope("${event.events}") />

	<cfif event.getName() EQ "event.doSearch">
		<view:message key="links.event.search" var="variables.title" arguments="Events" />
	<cfelse>
		<view:message key="links.event.list" var="variables.title" arguments="Events"/>
	</cfif>
	<view:meta type="title" content="#variables.title#" />
</cfsilent>

<cfoutput>
<h3>#variables.title#</h3><br />
<cfif events.RecordCount GT 0>
	<tags:datatable tableID="events" tableBodyID="eventsList" rowLink="/index.cfm?event=event.view">
	<div class="content">
		<div class="row">
			<div class="span12">
				<table id="events" class="table table-striped table-bordered">
					<thead>
						<tr>
							<th><view:message key="form.event.label.status" /></th>
							<th><view:message key="form.event.label.event" /></th>
							<th><view:message key="form.event.label.startdate" /></th>
							<th><view:message key="form.event.label.enddate" /></th>
							<th><view:message key="form.event.label.location" /></th>
							<th><view:message key="form.label.actions" /></th>
						</tr>
					</thead>
					<tbody id="eventsList">
						<cfoutput query="events">
							<tr id="#events.id#">
								<td>#events.status#</td>
								<td>#events.name#</td>
								<td>#dateFormat(events.startDate, "mm/dd/yyyy")# #timeFormat(events.startDate, "hh:mm tt")#</td>
								<td>#dateFormat(events.endDate, "mm/dd/yyyy")# #timeFormat(events.endDate, "hh:mm tt")#</td>
								<td>#events.location#</td>
								<td>
									<view:a event="event.edit" p:id="#id#"><view:message key="links.edit"/></view:a> |
									<view:a event="activity.doSearch" p:eventId="#events.id#"><view:message key="sideBar.Activity"/></view:a>
								</td>
							</tr>
						</cfoutput>
					</tbody>
				</table>
			</div>
		</div>
		<div class="clear"><br><br></div>
	</div>
	</tags:datatable>
<cfelse>
	<div><view:message key="message.noRecords" /></div>
</cfif>
</cfoutput>
