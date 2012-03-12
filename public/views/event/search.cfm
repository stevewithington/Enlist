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
	<cfset copyToScope("statuses=${properties.eventStatuses}") />
	<view:message key="links.event.search" var="variables.searchText" />
	<view:meta type="title" content="#variables.searchText#" />

	<view:script>
		$(function() {
			$( "#startDate" ).datetimepicker({
				ampm: true
			});
			$( "#endDate" ).datetimepicker({
				ampm: true
			});
		});
	</view:script>	
</cfsilent>
<cfoutput>		

<h3>#variables.searchText#</h3>

<form:form actionEvent="event.doSearch" class="form-horizontal">
	<fieldset>
		<div class="control-group">
			<label class="control-label" for="name"><view:message key="form.event.label.name" /></label>
			<div class="controls"><form:input path="name" maxlength="200" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="location"><view:message key="form.event.label.location" /></label>
			<div class="controls"><form:input path="location" maxlength="200" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="startDate"><view:message key="form.event.label.startdate" /></label>
			<div class="controls">
				<form:input path="startDate" maxlength="200" class="required" style="cursor: pointer;" />
				<a href="javascript:void(0);" onclick="javascript:$('##startDate').datepicker( 'show' )"><span class="icon-calendar"></span></a>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="endDate"><view:message key="form.event.label.enddate" /></label>
			<div class="controls">
				<form:input path="endDate" id="endDate" maxlength="200" class="required" style="cursor: pointer;" />
				<a href="javascript:void(0);" onclick="javascript:$('##endDate').datepicker( 'show' )"><span class="icon-calendar"></span></a>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="status"><view:message key="form.event.label.status" /></label>
			<div class="controls">
				<form:select path="status" items="#statuses#">
					<form:option label="Any" value="" />
				</form:select>
			</div>
		</div>

		<div class="form-actions">
			<form:button type="submit" name="search" value="#variables.searchText#" class="btn btn-primary" />
		</div>
	</fieldset>
</form:form>
</cfoutput>