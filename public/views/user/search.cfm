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
	
	$Id: search.cfm 182 2011-06-16 06:09:00Z peterjfarrell $
	
	Notes:
	--->
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfimport prefix="form" taglib="/MachII/customtags/form" />
	<cfimport prefix="tags" taglib="/customtags" />
	<cfset copyToScope("${event.chapters},states=${properties.usStates},roles=${properties.userRoles},statuses=${properties.userStatuses}") />
	<view:message key="links.user.search" var="variables.searchText" />
	<view:meta type="title" content="#variables.searchText#" />
</cfsilent>
<cfoutput>	

<h3>#variables.searchText#</h3><br>
	
<form:form actionEvent="user.doSearch" class="form-horizontal">
	<fieldset>
		<div class="control-group">
			<label class="control-label" for="firstName"><view:message key="form.user.label.firstname" /></label>
			<div class="controls">
				<form:input path="firstName" size="40" maxlength="200" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="lastName"><view:message key="form.user.label.lastname" /></label>
			<div class="controls">
				<form:input path="lastName" size="40" maxlength="200" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="identicaUsername"><view:message key="form.user.label.identica" /></label>
			<div class="controls">
				<form:input path="identicaUsername" size="40" maxlength="200" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="twitterUsername"><view:message key="form.user.label.twitter" /></label>
			<div class="controls">
				<form:input path="twitterUsername" size="40" maxlength="200" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="phone"><view:message key="form.user.label.phone" /></label>
			<div class="controls">
				<form:input path="phone" size="40" maxlength="40" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="address1"><view:message key="form.user.label.address" /></label>
			<div class="controls">
				<form:input path="address1" size="40" maxlength="200" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="address2"><view:message key="form.user.label.address2" /></label>
			<div class="controls">
				<form:input path="address2" size="40" maxlength="200" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="city"><view:message key="form.user.label.city" /></label>
			<div class="controls">
				<form:input path="city" size="40" maxlength="200" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="state"><view:message key="form.user.label.state" /> / <view:message key="form.user.label.postalcode" /></label>
			<div class="controls">
				<form:select path="state" items="#states#" labelKey="abbr" valueKey="abbr">
					<form:option value="" label="--" />
				</form:select>&nbsp;
				<form:input path="zip" size="11" maxlength="10" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="email"><view:message key="form.user.label.email" /></label>
			<div class="controls">
				<form:input path="email" size="40" maxlength="200" />
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
		<div class="control-group">
			<label class="control-label" for="status"><view:message key="form.user.label.status" /></label>
			<div class="controls">
				<form:select path="status" items="#statuses#">
					<form:option value="" label="" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="role"><view:message key="form.user.label.role" /></label>
			<div class="controls">
				<form:select path="role" items="#roles#">
					<form:option value="" label="" />
				</form:select>
			</div>
		</div>
		<div class="form-actions">
			<view:message key="" />
			<form:button type="submit" name="search" value="#variables.searchText#" class="btn btn-primary"  />
		</div>
	</fieldset>
</form:form>
</cfoutput>
