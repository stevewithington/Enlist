﻿<cfsilent>
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

	<cfset copyToScope("${event.chapters}") />
	<view:message key="links.chapter.list" var="variables.title" />
	<view:meta type="title" content="#variables.title#" />
</cfsilent>


<cfoutput>

<h3>#variables.title#</h3><br />
<cfif chapters.RecordCount gt 0>
	<tags:datatable tableID="chapters" tableBodyID="chaptersList" rowLink="/index.cfm?event=chapter.edit">
	<div class="content">	
		<div class="row">
			<div class="span12">
				<table id="chapters" class="table table-striped table-bordered">
					<thead>
						<tr>
							<th><view:message key="form.chapter.label.chapter"/></th>
							<th><view:message key="form.chapter.label.location"></th>
							<th><view:message key="form.chapter.label.status"></th>
						</tr>
					</thead>
					<tbody id="chaptersList">
						<cfloop query="chapters">
							<tr id="#chapters.id#">
								<td>#chapters.name#</td>
								<td>#chapters.location#</td>
								<td>#chapters.status#</td>
							</tr>
						</cfloop>
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