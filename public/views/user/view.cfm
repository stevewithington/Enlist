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
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfset copyToScope("${event.user}") />

	<view:message key="buttons.user.edit" var="variables.edit" />
	<view:message key="meta.title.user.add" var="variables.type" />
	<view:message key="meta.title.user.view" var="variables.title" arguments="#variables.user.getDisplayName()#" />
	<view:meta type="title" content="#variables.title#" arguments="#variables.user.getDisplayName()#" />
</cfsilent>

<cfoutput>
<div>
	<h3>#variables.title#</h3><br />
</div>

<table>
	<tr>
		<th><view:message key="form.user.label.status" /></th>
		<td>#variables.user.getStatus()#</td>
	</tr>
	<tr>
		<th><view:message key="form.user.label.role" /></th>
		<td>#variables.user.getRole()#</td>
	</tr>	
	<tr>
		<th><view:message key="form.user.label.firstname" /></th>
		<td>#variables.user.getFirstName()#</td>
	</tr>
	<tr>
		<th><view:message key="form.user.label.lastname" /></th>
		<td>#variables.user.getLastName()#</td>
	</tr>
	<tr>
		<th><view:message key="form.user.label.email" /></th>
		<td><a href="mailto:#variables.user.getEmail()#">#variables.user.getEmail()#</a></td>
	</tr>
	<cfif variables.user.getIdenticaUsername() neq ''>
		<tr>
			<th><view:message key="form.user.label.identica" /></th>
			<td><a href="http://identi.ca/#variables.user.getIdenticaUsername()#">#variables.user.getIdenticaUsername()#</a></td>
		</tr>
	</cfif>
	<cfif variables.user.getTwitterUsername() neq ''>
		<tr>
			<th><view:message key="form.user.label.twitter" /></th>
			<td><a href="http://twitter.com/#variables.user.getTwitterUsername()#">#variables.user.getTwitterUsername()#</a></td>
		</tr>
	</cfif>
	<tr>
		<th><view:message key="form.user.label.phone" /></th>
		<td>#variables.user.getPhone()#</td>
	</tr>
	<tr>
		<th><view:message key="form.user.label.address" /></th>
		<td>#variables.user.getAddress1()#</td>
	</tr>
	<cfif variables.user.getAddress2() neq ''>
		<tr>
			<th><view:message key="form.user.label.address2" /></th>
			<td>#variables.user.getAddress2()#</td>
		</tr>
	</cfif>
	<tr>
		<th><view:message key="form.user.label.city" /></th>
		<td>#variables.user.getCity()#</td>
	</tr>
	<tr>
		<th><view:message key="form.user.label.state" /> / <view:message key="form.user.label.postalcode" /></th>
		<td>#variables.user.getState()# #variables.user.getZip()#</td>
	</tr>
	<!---<cfif chapters.RecordCount GT 0>
		<tr>
			<th><label id="chapterId"><view:message key="form.user.label.chapter" /></label></th>
			<td>
				<form:select path="chapterId">
					<cfloop query="chapters">
						<form:option value="#chapters.id#" label="#chapters.Name#" />
					</cfloop>
				</form:select>
			</td>
		</tr>
	</cfif>--->
</table>
<form:form actionEvent="user.edit">
	<form:hidden name="id" value="#variables.user.getId()#" />
	<div class="form-actions">
		<form:button type="submit" name="save" value="#variables.edit#" class="btn btn-primary"  />
	</div>
</form:form>
</cfoutput>
