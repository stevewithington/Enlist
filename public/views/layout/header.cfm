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

$Id: header.cfm 181 2011-06-16 04:56:27Z peterjfarrell $

Notes:
--->
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfset copyToScope("eventName=${event.getName()},${properties.udfs}") />
</cfsilent>

<view:script src="/bootstrap/js/bootstrap.js">
	$('.dropdown-toggle').dropdown();
	jQuery.validator.setDefaults({errorPlacement: function(errormsg, element)
			{
				// Set positioning based on the elements position in the form
				var elem = $(element),
					corners = ['right center', 'left center'],
					flipIt = elem.parents('span.left').length > 0;

				// Check we have a valid error message
				if(!errormsg.is(':empty')) {
					// Apply the tooltip only if it isn't valid
					elem.filter(':not(.valid)').qtip({
						overwrite: false,
						content: errormsg,
						position: {
							my: corners[ flipIt ? 0 : 1 ],
							at: corners[ flipIt ? 1 : 0 ],
							viewport: $(window)
						},
						show: {
							event: false,
							ready: true
						},
						hide: false,
						style: {
							classes: 'ui-tooltip-red' // Make it red... the classic error colour!
						}
					})

					// If we have a tooltip on this element already, just update its content
					.qtip('option', 'content.text', errormsg);
				}

				// If the error is empty, remove the qTip
				else { elem.qtip('destroy'); }
			},
			success: $.noop,});
</view:script>

<div class="row">
	<div class="span12"><img alt="" width="172" height="70" src="/img/Enlist_Logo.png"/></div>
</div>

<div class="row" style="margin-top:12px;">
	<div class="clear"></div>
</div>

<div class="row">
	<div class="navbar">
	  <div class="navbar-inner">
	    <div class="container">
	     <ul class="nav nav-tabs">
				<li <cfif arguments.event.getArg('event') eq 'home'>class="active"</cfif> ><view:a event="home" ><view:message key="nav.home" /></view:a></li>
			<!--- <cfif variables.googleUserService.isUserLoggedIn()> --->
			   <li  <cfif arguments.event.getArg('event') eq 'user.edit' OR  arguments.event.getArg('event') eq 'user.list' OR arguments.event.getArg('event') eq 'user.search' >class="dropdown active"<cfelse >class="dropdown"</cfif>  id="menu1">
				    <a href="#"
				          class="dropdown-toggle"
				          data-toggle="dropdown">
				          Users
				          <b class="caret"></b>
				    </a>
				    <ul class="dropdown-menu">
				     <li><view:a event="user.edit" ><view:message key="links.event.new" arguments="User" /></view:a></li>
				     <li><view:a event="user.list" ><view:message key="links.event.list" arguments="Users" /></view:a></li>
				     <li><view:a event="user.search" ><view:message key="links.event.search" arguments="Users" /></view:a></li>
				    </ul>
				</li>
			   <li <cfif arguments.event.getArg('event') eq 'event.edit' OR  arguments.event.getArg('event') eq 'event.list' OR arguments.event.getArg('event') eq 'event.search' >class="dropdown active"<cfelse >class="dropdown"</cfif>  id="menu2">
				    <a href="#menu2"
				          class="dropdown-toggle"
				          data-toggle="dropdown">
				          Events
				          <b class="caret"></b>
				    </a>
				    <ul class="dropdown-menu">
				     <li><view:a event="event.edit" ><view:message key="links.event.new" arguments="Event" /></view:a></li>
				     <li><view:a event="event.list" ><view:message key="links.event.list" arguments="Events" /></view:a></li>
				     <li><view:a event="event.search" ><view:message key="links.event.search" arguments="Events" /></view:a></li>
				    </ul>
				</li>
			    <li <cfif arguments.event.getArg('event') eq 'activity.edit' OR  arguments.event.getArg('event') eq 'activity.list' OR arguments.event.getArg('event') eq 'activity.search' >class="dropdown active"<cfelse >class="dropdown"</cfif>  id="menu3">
				    <a href="#menu3"
				          class="dropdown-toggle"
				          data-toggle="dropdown">
				          Activities
				          <b class="caret"></b>
				    </a>
				    <ul class="dropdown-menu">
				     <li><view:a event="activity.edit" ><view:message key="links.event.new" arguments="Activity" /></view:a></li>
				     <li><view:a event="activity.list" ><view:message key="links.event.list" arguments="Activities" /></view:a></li>
				     <li><view:a event="activity.search" ><view:message key="links.event.search" arguments="Activities" /></view:a></li>
				    </ul>
				</li>

			    <li <cfif arguments.event.getArg('event') eq 'chapter.edit' OR  arguments.event.getArg('event') eq 'chapter.list' OR arguments.event.getArg('event') eq 'chapter.search' >class="dropdown active"<cfelse >class="dropdown"</cfif>  id="menu4">
				    <a href="#menu4"
				          class="dropdown-toggle"
				          data-toggle="dropdown">
				          Chapters
				          <b class="caret"></b>
				    </a>
				    <ul class="dropdown-menu">
				     <li><view:a event="chapter.edit" ><view:message key="links.event.new" arguments="Chapter" /></view:a></li>
				     <li><view:a event="chapter.list" ><view:message key="links.event.list" arguments="Chapters" /></view:a></li>
				    </ul>
				</li>
				<li><view:a event="activityvolunteer.list"><view:message key="nav.activities"/></view:a></li>
				<li><view:a event="register"><view:message key="nav.registration"/></view:a></li>
				<li><a href="" id="logout"><view:message key="nav.logout"/></a></li>
			<!--- <cfelse> --->
				<li><a href=""><view:message key="nav.login"/></a></li>
			<!--- </cfif> --->
			</ul>
	    </div>
	  </div>
	</div>
</div>


