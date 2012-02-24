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
<cfoutput>
<script charset="javascript">
	$('.dropdown-toggle').dropdown()
</script>	

<div class="row">
	<div class="span12"><img alt="" width="172" height="70" src="/img/Enlist_Logo.png"/></div>
</div>	

<div class="row">	
	<div class="navbar">
	  <div class="navbar-inner">
	    <div class="container">
	     <ul class="nav nav-tabs">
				<li class="active"><view:a event="home" ><view:message key="nav.home" /></view:a></li>
			<!--- <cfif variables.googleUserService.isUserLoggedIn()> --->	
			   <li class="dropdown">
				    <a href="index.cfm?event=event.list"
				          class="dropdown-toggle"
				          data-toggle="dropdown">
				          Users
				          <b class="caret"></b>
				    </a>
				    <ul class="dropdown-menu">
				     <li><view:a event="user.add" >Add User</view:a></li>
				     <li><view:a event="user.list" >List Users</view:a></li>
				     <li><view:a event="user.search" >Search User</view:a></li>
				    </ul>
				</li>		
			   <li class="dropdown">
				    <a href="index.cfm?event=event.list"
				          class="dropdown-toggle"
				          data-toggle="dropdown">
				          Events
				          <b class="caret"></b>
				    </a>
				    <ul class="dropdown-menu">
				     <li><view:a event="event.add" >Add Event</view:a></li>
				     <li><view:a event="event.list" >List Events</view:a></li>
				     <li><view:a event="event.search" >Search Events</view:a></li>
				    </ul>
				</li>
			    <li class="dropdown">
				    <a href="index.cfm?event=event.list"
				          class="dropdown-toggle"
				          data-toggle="dropdown">
				          Actvites
				          <b class="caret"></b>
				    </a>
				    <ul class="dropdown-menu">
				     <li><view:a event="activity.edit" >Add Activity</view:a></li>
				     <li><view:a event="activity.list" >List Activity</view:a></li>
				     <li><view:a event="activity.search" >Search Activity</view:a></li>
				    </ul>
				</li>
			    <li class="dropdown">
				    <a href="index.cfm?event=event.list"
				          class="dropdown-toggle"
				          data-toggle="dropdown">
				          Chapters
				          <b class="caret"></b>
				    </a>
				    <ul class="dropdown-menu">
				     <li><view:a event="chapter.add" >Add Chapter</view:a></li>
				     <li><view:a event="chapter.list" >List Chapters</view:a></li>
				    </ul>
				</li>
			    <li class="dropdown">
				    <a href="index.cfm?event=event.list"
				          class="dropdown-toggle"
				          data-toggle="dropdown">
				          Navigation
				          <b class="caret"></b>
				    </a>
				    <ul class="dropdown-menu">
				     <li>Add Navigation Item</li>
				     <li>Edit Navigation Item</li>
				     <li>Remove Navigation Item</li>
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
</cfoutput>