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
	<cfimport prefix="tags" taglib="/enlist/customtags" />

	<cfset copyToScope("${event.chapter},statuses=${properties.chapterStatuses}") />

	<cfif variables.chapter.getId() neq 0>
		<view:message key="buttons.chapter.save" var="variables.save" />
		<view:message key="meta.title.chapter.edit" var="variables.type" />
		<view:message key="meta.title.chapter.edit" var="variables.title" arguments="#variables.chapter.getName()#" />
		<view:meta type="title" content="#variables.title#" arguments="#variables.chapter.getName()#" />
	<cfelse>
		<view:message key="buttons.chapter.save" var="variables.save" />
		<view:message key="meta.title.chapter.add" var="variables.type" />
		<view:message key="meta.title.chapter.add" var="variables.title" />
		<view:meta type="title" content="#variables.title#"  />
	</cfif>

	<view:script>
		$(document).ready(function(){
			$("#chapterForm").validate();
		});
	</view:script>
</cfsilent>
<cfoutput>
	
<tags:displaymessage />
<tags:displayerror />

<h3>#variables.title#</h3><br>

<form:form actionEvent="chapter.save" bind="chapter" id="chapterForm">
	<fieldset>
		<div class="control-group">
			<label class="control-label" for="name"><view:message key="form.chapter.label.name" /> *</label>
			<div class="controls">
				<form:input path="name" size="40" maxlength="200" class="required" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="location"><view:message key="form.chapter.label.location" /> *</label>
			<div class="controls">
				<form:input path="location" size="40" maxlength="200" class="required" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="location"><view:message key="form.chapter.label.status" /> *</label>
			<div class="controls">
				<form:select path="status" items="#statuses#" class="required">
					<form:option value="" label="" />
				</form:select>
			</div>
		</div>
		<form:hidden name="id" path="id" />
		<div class="form-actions">
			<view:message key="" />
			<form:button type="submit" name="save" value="#variables.save#" class="btn btn-primary"  />
		</div>
	</fieldset>
</form:form>
</cfoutput>