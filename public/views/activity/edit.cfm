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
	<cfimport prefix="tags" taglib="/Enlist/customtags" />
	<view:message key="event.activity" var="request.event"/>

	<cfset copyToScope("${event.activity},${event.theEvents}") />
		
	<cfif NOT Len(variables.activity.getId())>
		<view:message key="buttons.activity.save" var="variables.save" />
		<view:message key="meta.title.activity.add" var="variables.type" />
		<view:meta type="title" content="#variables.activity.getTitle()#" />
	<cfelse>
		<view:message key="buttons.save" var="variables.save" arguments="request.event" />
		<view:message key="meta.title.activity.edit" var="variables.type" arguments="#variables.activity.getTitle()#" />
		<view:meta type="title" content="#variables.save#"  />
	</cfif>

	<view:script>
		$(function() {
			$( "#startDate" ).datetimepicker({
				ampm:true
			});
			$( "#endDate" ).datetimepicker({
				ampm:true
			});
		});
		
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
	</view:script>
</cfsilent>
<cfoutput>	

<!---<tags:displaymessage />
<tags:displayerror />--->

<h3>#variables.type#</h3>

<form:form actionEvent="activity.save" name="actForm" id="actForm" class="form-horizontal">
	<fieldset>
		<div class="control-group">
			<label class="control-label" for="eventId"><view:message key="form.activity.label.event" /></label>
			<div class="controls">
				<form:select name="eventId" checkValue="#activity.getEvent().getId()#" items="#theEvents#" class="required">
					<form:option value="" label="" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="title"><view:message key="form.activity.label.title" /></label>
			<div class="controls">
				<form:input name="title" id="title" maxlength="200" class="required" value="#activity.getTitle()#" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="description"><view:message key="form.activity.label.description" /></label>
			<div class="controls">
				<form:textarea name="description" id="description">#activity.getDescription()#</form:textarea>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="numPeople"><view:message key="form.activity.label.number" /></label>
			<div class="controls">
				<form:input name="numPeople" id="numPeople" maxlength="4" class="required" value="#activity.getNumPeople()#" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="startDate"><view:message key="form.activity.label.startdate" /></label>
			<div class="controls">
				<form:input path="startDate" maxlength="200" class="required" style="cursor: pointer;" value="#activity.getStartDate()#" />
				<a href="javascript:void(0);" onclick="javascript:$('##startDate').datepicker( 'show' )"><span class="icon-calendar"></span></a>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="endDate"><view:message key="form.activity.label.enddate" /></label>
			<div class="controls">
				<form:input path="endDate" maxlength="200" class="required" style="cursor: pointer;" value="#activity.getEndDate()#" />
				<a href="javascript:void(0);" onclick="javascript:$('##endDate').datepicker( 'show' )"><span class="icon-calendar"></span></a>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="pointHours"><view:message key="form.activity.label.hours" /></label>
			<div class="controls">
				<form:input name="pointHours" id="pointHours" maxlength="4" class="required" value="#activity.getPointHours()#" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="location"><view:message key="form.activity.label.location" /></label>
			<div class="controls">
				<form:input id="location" name="location" maxlength="20" class="required" value="#activity.getLocation()#" />
			</div>
		</div>
		<view:message key="buttons.activity.save" var="variables.save" arguments="request.event" />
		<div class="form-actions">
			<form:button type="submit" name="save" value="#variables.save#" class="btn btn-primary" />
		</div>
	</fieldset>
	
	<form:hidden name="id" id="id" value="#activity.getId()#" />
</form:form>
</cfoutput>