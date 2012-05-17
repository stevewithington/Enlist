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
	<cfimport prefix="tags" taglib="/Enlist/customtags" />
	<cfset copyToScope("${event.user},${event.chapters:arrayNew(1)},states=${properties.usStates},roles=${properties.userRoles},statuses=${properties.userStatuses}") />

	<cfif variables.user.getId() neq 0>
		<view:message key="buttons.user.save" var="variables.save" />
		<view:message key="meta.title.user.edit" var="variables.type" />
		<view:message key="meta.title.user.edit" var="variables.title" arguments="#variables.user.getDisplayName()#" />
		<view:meta type="title" content="#variables.title#" arguments="#variables.user.getDisplayName()#" />
	<cfelse>
		<view:message key="buttons.user.save" var="variables.save" />
		<view:message key="meta.title.user.add" var="variables.type" />
		<view:message key="meta.title.user.add" var="variables.title" />
		<view:meta type="title" content="#variables.title#"  />
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
	<h3>#variables.title#</h3><br />
</div>

<form:form actionEvent="user.save" bind="user" id="userForm">

	<fieldset>
		<div class="control-group">
			<label id="status">Status *</label>
			<div class="controls">
				<form:select path="status" items="#statuses#" class="required">
					<form:option value="" label="" />
				</form:select>
			</div>
		</div>

		<div class="control-group">
			<label id="role">Role *</label>
			<div class="controls">
				<form:select path="role" items="#roles#" class="required">
					<form:option value="" label="" />
				</form:select>
			</div>
		</div>

		<div class="control-group">
			<label id="firstName">First Name *</label>
			<div class="controls">
				<form:input path="firstName" size="40" maxlength="200" class="required" />
			</div>
		</div>

		<div class="control-group">
			<label id="lastName">Last Name *</label>
			<div class="controls">
				<form:input path="lastName" size="40" maxlength="200" class="required" />
			</div>
		</div>

		<div class="control-group">
			<label id="altEmail">Email *</label>
			<div class="controls">
				<form:input path="altEmail" size="40" maxlength="200" class="required" />
			</div>
		</div>

<label id="twitterUsername">Identi.ca</label></th>
			<td><form:input path="identicaUsername" size="40" maxlength="50" /></td>
		</tr>
		<tr>
			<th><label id="twitterUsername">Twitter</label></th>
			<td><form:input path="twitterUsername" size="40" maxlength="50" /></td>
		</tr>
		<tr>
			<th><label id="phone">Phone</label></th>
			<td><form:input path="phone" size="40" maxlength="40" /></td>
		</tr>
		<tr>
			<th><label id="address1">Address 1</label></th>
			<td><form:input path="address1" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th><label id="address2">Address 2</label></th>
			<td><form:input path="address2" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th><label id="city">City</label></th>
			<td><form:input path="city" size="40" maxlength="200" /></td>
		</tr>
		<tr>
			<th><label id="state">State / Zip</label></th>
			<td>
				<form:select path="state" items="#states#" labelKey="abbr" valueKey="abbr">
					<form:option value="" label="" />
				</form:select>&nbsp;
				<form:input path="zip" size="11" maxlength="10" />
			</div>
		</div>
		<cfif chapters.RecordCount GT 0>
			<div class="control-group">
				<label class="control-label" for="chapterId"><view:message key="form.user.label.chapter" /></label>
				<div class="controls">
					<form:select path="chapterId">
						<form:option value="" label="" />
						<cfloop query="chapters">
							<form:option value="#chapters.id#" label="#chapters.Name#" />
						</cfloop>
					</form:select>
				</div>
			</div>
		</cfif>

		<form:hidden name="id" path="id" />
		<div class="form-actions">
			<view:message key="" />
			<form:button type="submit" name="save" value="#variables.save#" class="btn btn-primary"  />
		</div>
	</fieldset>

</form:form>
</cfoutput>
