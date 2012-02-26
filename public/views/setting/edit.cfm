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

	$Id: edit.cfm 184 2011-06-16 06:54:39Z peterjfarrell $

	Notes:
	--->
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfimport prefix="tags" taglib="/customtags" />
	
	<view:message key="event.setting" var="variables.activityName"/>
	<view:message key="links.event.edit" var="variables.title" arguments="#variables.activityName#" />
	<view:meta type="title" content="#variables.title#" />
	
	<view:script>
		$(document).ready(function(){
			$("#settingForm").validate();
		});
	</view:script>
</cfsilent>
<cfoutput>
<tags:displaymessage />
<tags:displayerror />

<h3>#variables.title#</h3>

<form:form actionEvent="setting.save" bind="setting" id="settingForm">
	<table>
		<tr>
			<th><view:message key="form.setting.label.orgname" />:</th>
			<td><form:input path="orgName" size="40" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th><view:message key="form.setting.label.description" />:</th>
			<td><form:textarea path="orgDesc" class="required" /></td>
		</tr>
		<tr>
			<th nowrap="nowrap"><view:message key="form.setting.label.address" />:</th>
			<td><form:textarea path="orgAddress" class="required" /></td>
		</tr>
		<tr>
			<th nowrap="nowrap"><view:message key="form.setting.label.pointname" />:</th>
			<td><form:input path="pointName" size="10" maxlength="200"  class="required" /></td>
		</tr>
		<tr>
			<th nowrap="nowrap"><view:message key="form.setting.label.pointvalue" />:</th>
			<td><form:input path="defaultPointValue" size="10" maxlength="200" class="required" /></td>
		</tr>
		<tr>
			<th nowrap="nowrap"><view:message key="form.setting.label.email" />:</th>
			<td>
				<form:select path="sendEmail">
					<form:option value="true" label="Yes" />
					<form:option value="false" label="No" />
				</form:select>
			</td>
		</tr>
		<tr>
			<td><form:hidden name="id" path="id" /></td>
			<view:message key="buttons.save" var="variables.save" arguments="#variables.activityName#"/>
			<td colspan="3"><form:button type="submit" name="save" value="#variables.activityName#" /></td>
		</tr>
	</table>
</form:form>
</cfoutput>