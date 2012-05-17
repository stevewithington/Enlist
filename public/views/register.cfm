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

$Id: register.cfm 186 2011-08-20 21:22:32Z peterjfarrell $

Notes:
--->
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfimport prefix="tags" taglib="/Enlist/customtags" />
	<view:message key="meta.title.register.home" var="variables.eventName"/>
	<view:meta type="title" content="#variables.eventName#" />
	
	<cfset copyToScope("states=${properties.usStates},${event.chapters},${event.user}") />
	
	<view:script>
	$(document).ready(function(){
		$("#registerForm").validate();
	});
</view:script>
</cfsilent>
<cfoutput>
<h2>#variables.eventName#</h2>

<tags:displaymessage />

<!--- Output any errors if we have some --->
<tags:displayerror />

<form:form actionEvent="register_process" bind="user" id="registerForm" class="form-horizontal" >
	<fieldset>
		<div class="control-group">
			<label class="control-label" for="firstName"><view:message key="common.fname" /> *</label>
			<div class="controls"><form:input path="firstName" maxlength="200"  class="required" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="lastName"><view:message key="common.lname" /> *</label>
			<div class="controls"><form:input path="lastName" maxlength="200" class="required" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="email"><view:message key="common.email" /> *</label>
			<div class="controls">
				<form:input path="email" maxlength="200" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="twitterUsername"><view:message key="common.twitter" /> *</label>
			<div class="controls">
				<form:input path="twitterUsername" maxlength="200" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="phone"><view:message key="common.phone" /></label>
			<div class="controls"><form:input path="phone" maxlength="40" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="address1"><view:message key="common.address1" /></label>
			<div class="controls"><form:input path="address1" maxlength="200" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="address2"><view:message key="common.address2" /></label>
			<div class="controls"><form:input path="address2" maxlength="200" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="city"><view:message key="common.city" /></label>
			<div class="controls"><form:input path="city" maxlength="200" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="state"><view:message key="common.state" /> / <view:message key="common.zip" /></label>
			<div class="controls">
				<form:select path="state" items="#states#" labelKey="abbr" valueKey="abbr">
					<form:option value="" label="" />
				</form:select>&nbsp;
				<form:input path="zip" size="11" maxlength="10" />
			</div>
		</div>
		<cfif chapters.RecordCount GT 0>
			<div class="control-group">
				<label class="control-label" for="chapterId"><view:message key="form.register.label.chapter" /></label>
				<div class="controls">
					<form:select path="chapterId">
						<cfloop query="chapters">
							<form:option value="#chapters.ID#" label="#chapters.Name#" />
						</cfloop>
					</form:select>
				</div>
			</div>
		</cfif>
		<div class="form-actions">
			<form:button type="submit" name="save" class="btn btn-primary" value="Save Registration Info" />
		</div>
	</fieldset>
</form:form>
</cfoutput>