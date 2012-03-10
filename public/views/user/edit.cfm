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

$Id: edit.cfm 186 2011-08-20 21:22:32Z peterjfarrell $

Notes:
--->
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfimport prefix="tags" taglib="/Enlist/customtags" />
	<cfset copyToScope("${event.user},${event.chapters:arrayNew(1)},states=${properties.usStates},roles=${properties.userRoles},statuses=${properties.userStatuses}") />

	<cfif NOT Len(variables.user.getId())>
		<view:message key="links.event.new" var="variables.save" />
		<view:message key="meta.title.user.add" var="variables.type" />
		<view:meta type="title" content="#variables#" />
	<cfelse>
		<view:message key="buttons.save" var="variables.save" arguments="request.event" />
		<view:message key="meta.title.activity.edit" var="variables.type" arguments="#variables.user.getDisplayName()#" />
		<view:meta type="title" content="#variables.save#"  />
	</cfif>
	
	<view:meta type="title" content="#variables.title#" />

	<view:script>
		$(document).ready(function(){
			$("#userForm").validate();
		});
	</view:script>
</cfsilent>
<cfoutput>		

<div>
	<h3>#variables.title#</h3><br>
</div>

<form:form actionEvent="user.save" bind="user" id="userForm">
	<table>
		<tr>
			<th><label id="status"><view:message key="form.user.label.status" /> *</label></th>
			<td>
				<form:select path="status" items="#statuses#" class="required">
					<form:option value="" label="" />
				</form:select>
			</td>
		</tr>
		<tr>
			<th><label id="role"><view:message key="form.user.label.role" /> *</label></th>
			<td>
				<form:select path="role" items="#roles#" class="required">
					<form:option value="" label="" />
				</form:select>
			</td>
		</tr>	
		<tr>
			<th><label id="firstName"><view:message key="form.user.label.firstname" /> *</label></th>
			<td><form:input path="firstName" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th><label id="lastName"><view:message key="form.user.label.lastname" /> *</label></th>
			<td><form:input path="lastName" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th><label id="altEmail"><view:message key="form.user.label.email" /> *</label></th>
			<td><form:input path="altEmail" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th><label id="twitterUsername"><view:message key="form.user.label.identica" /></label></th>
			<td><form:input path="identicaUsername" size="40" maxlength="50" /></td>
		</tr>
		<tr>
			<th><label id="twitterUsername"><view:message key="form.user.label.twitter" /></label></th>
			<td><form:input path="twitterUsername" size="40" maxlength="50" /></td>
		</tr>
		<tr>
			<th><label id="phone"><view:message key="form.user.label.phone" /></label></th>
			<td><form:input path="phone" size="40" maxlength="40" /></td>
		</tr>
		<tr>
			<th><label id="address1"><view:message key="form.user.label.address1" /> 1</label></th>
			<td><form:input path="address1" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th><label id="address2"><view:message key="form.user.label.address2" /></label></th>
			<td><form:input path="address2" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th><label id="city"><view:message key="form.user.label.city" /></label></th>
			<td><form:input path="city" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th><label id="state"><view:message key="form.user.label.state" /> / <view:message key="form.user.label.postalcode" /></label></th>
			<td>
				<form:select path="state" items="#states#" labelKey="abbr" valueKey="abbr">
					<form:option value="" label="" />
				</form:select>&nbsp;
				<form:input path="zip" size="11" maxlength="10" />
			</td>
		</tr>
		<cfif chapters.RecordCount GT 0>
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
		</cfif>
		<tr>
			<td><form:hidden name="id" path="id" /></td>
			<td colspan="3"><form:button type="submit" name="save" value="#variables.save#" class="btn-primary" /></td>
		</tr>
	</table>
</form:form>
</cfoutput>
