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
	
	$Id: list.cfm 182 2011-06-16 06:09:00Z peterjfarrell $
	
	Notes:
	--->
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfimport prefix="tags" taglib="/enlist/customtags" />

	<cfset copyToScope("${event.chapters}") />
	
	<view:meta type="title" content="List Chapters" />
</cfsilent>


<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {

		$('#chapters').dataTable( {
			"sPaginationType": "full_numbers",
			"sType":"title-numeric"
		} );

		//link datable rows to chapter.edit
		$('#chaptersList tr').live('click', function() {
			var thisId = $(this).find('td[id]').attr("id");
			window.location = '/index.cfm/?event=chapter.edit&id=' + thisId;
		});
	} );
</script>



<cfoutput>
<p><view:a event="chapter.edit">Create a new chapter</view:a></p>
<div>
	<table id="chapters">
		<thead>
			<tr>
				<th>Chapter</th>
				<th>Location</th>
				<th>Status</th>
			</tr>
		</thead>
		<tbody id="chaptersList">
			<cfloop query="chapters">
				<tr>
					<td id="#id#">#name#</td>
					<td>#location#</td>
					<td>#StatusCode#</td>
				</tr>
			</cfloop>
		</tbody>
		<tfoot>
			<tr>
				<th>Chapter</th>
				<th>Location</th>
				<th>Status</th>
			</tr>
		</tfoot>
	</table>
</div>
<p><view:a event="chapter.edit">Create a new chapter</view:a></p>
</cfoutput>