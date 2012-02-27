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

$Id: search.cfm 181 2011-06-16 04:56:27Z peterjfarrell $

Notes:
--->
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfset copyToScope("${event.events}") />
	<view:message key="event.activity" var="variables.activityName"/>
	<view:message key="links.event.search" var="variables.string" arguments="#variables.activityName#"/>

	<view:meta type="title" content="#variables.string#" />

	<view:script>
		$(function() {
			$( "#startDate" ).datepicker();
			$( "#endDate" ).datepicker();
		});
	</view:script>
</cfsilent>
<cfoutput>	
	
<h3>#variables.string#</h3>
<form:form actionEvent="activity.doSearch" class="form-horizontal" >
	<fieldset>
		<div class="control-group">
			<label class="control-label" for="eventID"><view:message key="form.activity.label.event" /></label>
			<div class="controls">
				<view:message key="form.activity.label.select" var="variables.labelSelect"/>
				<form:select path="eventId" items="#variables.events#">
					<form:option value="" label="#variables.labelSelect#" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="title"><view:message key="form.activity.label.title" /></label>
			<div class="controls"><form:input path="title" maxlength="200" /></div>
		</div>
 		<div class="control-group">
			<label class="control-label" for="description"><view:message key="form.activity.label.description" /></label>
			<div class="controls"><form:input path="description" maxlength="200" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="numPeople"><view:message key="form.activity.label.number" /></label>
			<div class="controls"><form:input path="numPeople" maxlength="4" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="startate"><view:message key="form.activity.label.startdate" /></label>
			<div class="controls"><form:input path="startDate" maxlength="10" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="endDate"><view:message key="form.activity.label.enddate" /></label>
			<div class="controls"><form:input path="endDate" maxlength="10" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="pointHours"><view:message key="form.activity.label.hours" /></label>
			<div class="controls"><form:input path="pointHours" maxlength="4" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="location"><view:message key="form.activity.label.location" /></label>
			<div class="controls"><form:input path="location" maxlength="20" /></div>
		</div>
		<view:message key="buttons.save" var="variables.save" arguments="#variables.activityName#" />
		<div class="form-actions">
			<form:button type="submit" name="search" value="#variables.save#" class="btn btn-primary"/>
		</div>
	</fieldset>
</form:form>
</cfoutput>