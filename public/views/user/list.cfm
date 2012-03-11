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

$Id: list.cfm 186 2011-08-20 21:22:32Z peterjfarrell $

Notes:
--->
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfimport prefix="tags" taglib="/enlist/customtags" />
	<cfset copyToScope("${event.users}") />
	
	<cfif event.getName() EQ "user.doSearch">
		<cfset variables.title = "Users Search Results" />
	<cfelse>
		<cfset variables.title = "List Users" />
	</cfif>
	<view:meta type="title" content="#variables.title#" />
</cfsilent>
<cfoutput>
<!--- <p><view:a event="user.search" class="btn">Search Users</view:a>&nbsp;<view:a event="user.edit" class="btn">Create a new user</view:a></p> --->

<h3>#variables.title#</h3><br />
<cfif users.recordcount gte 1>
	<tags:datatable tableID="users" tableBodyID="usersList" rowLink="/index.cfm?event=user.view">
	<div class="content">	
		<div class="row">
			<div class="span12">
				<table id="users" class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>First Name</th>
							<th>Last Name</th>
							<th>Role</th>
							<th>Status</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody id="usersList">
						<cfloop query="users">
							<tr>
								<td>#users.FirstName#</td>
								<td>#users.LastName#</td>
								<td>#users.Role#</td>
								<td>#users.Status#</td>
								<view:message key="links.edit" var="variables.edit" />
								<td><view:a event="user.edit" p:id="#users.id#" label="#variables.edit#" /></td>
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
