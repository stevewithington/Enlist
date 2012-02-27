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

$Id: edit.cfm 182 2011-06-16 06:09:00Z peterjfarrell $

Notes:
--->
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfimport prefix="tags" taglib="/enlist/customtags" />
	<view:message key="event.activity" var="request.event"/>

	<cfset copyToScope("${event.activity},${event.events}") />

	<cfif NOT Len(variables.activity.getId())>
		<view:message key="buttons.activity.save" var="variables.save" />
		<view:message key="meta.title.activity.add" var="variables.type" />
		<view:meta type="title" content="#variables.activity.getTitle()#" />
	<cfelse>
		<view:message key="buttons.activity.save" var="variables.save" arguments="request.event" />
		<view:message key="meta.title.activity.edit" var="variables.type" arguments="#variables.activity.getTitle()#" />
		<view:meta type="title" content="#variables.activity.getTitle()#"  />
	</cfif>

	<view:script>
		$(document).ready(function(){
			jQuery.validator.addMethod("greaterThanEqual", function(value, element, params) {
				if (!/Invalid|NaN/.test(new Date(value))) {
					return new Date(value) >= new Date($(params).val());
				}
				return isNaN(value) && isNaN($(params).val()) || (parseFloat(value) > parseFloat($(params).val()));
			},'Must be greater than or equal to {0}.');
			$("#actForm").validate();
			$("#endDate").rules("add", {greaterThanEqual: "#startDate"});
		});

		$(function() {
			$( "#startDate" ).datepicker();
			$( "#endDate" ).datepicker();
		});
	</view:script>
</cfsilent>
<cfoutput>	

<!---
	Commenting this out for now. Blows up pretty hardcore in OpenBD.
	- Adam
<tags:displaymessage />
<tags:displayerror />
--->

<h3>#variables.type# Activity</h3><br>

<h3>#variables.type# Activity</h3>
<form:form actionEvent="activity.save" bind="activity" id="actForm" class="form-horizontal">
	<fieldset>
		<div class="control-group">
			<label class="control-label" for="eventId"><view:message key="form.activity.label." /></label>
			<div class="controls">
				<form:select path="eventId" items="#variables.events#" bind="#variables.activity.getEvent().getId()#" class="required">
					<form:option value="" label="Choose an event" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="title"><view:message key="form.activity.label.title" /></label>
			<div class="controls"><form:input path="title" maxlength="200" class="required" /></div>
		</div>
 		<div class="control-group">
			<label class="control-label" for="description"><view:message key="form.activity.label.description" /></label>
			<div class="controls"><form:textarea path="description" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="numPeople"><view:message key="form.activity.label.number" /></label>
			<div class="controls"><form:input path="numPeople" maxlength="4" class="required" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="startDate"><view:message key="form.activity.label.startdate" /></label>
			<div class="controls"><form:input path="startDate" maxlength="10" class="required date" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="endDate"><view:message key="form.activity.label.enddate" /></label>
			<div class="controls"><form:input path="endDate" maxlength="10" class="required date" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="pointHours"><view:message key="form.activity.label.hours" /></label>
			<div class="controls"><form:input path="pointHours"  maxlength="4" class="required" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="location"><view:message key="form.activity.label.location" /></label>
			<div class="controls"><form:input path="location" maxlength="20" class="required" /></div>
		</div>
		
		<form:hidden path="id" />
		<view:message key="button.save" var="variables.save" arguments="request.event" />
		<div class="form-actions">
			<form:button type="submit" name="save" value="#variables.save#" class="btn btn-primary" />
		</div>
	
	</fieldset>
</form:form>
</cfoutput>