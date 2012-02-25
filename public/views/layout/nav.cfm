<cfimport prefix="view" taglib="/MachII/customtags/view" />

<!--- SUBNAV FOR USERS --->
<cfif arguments.event.getArg('event') eq 'user.edit' OR arguments.event.getArg('event') eq 'user.list'  OR  arguments.event.getArg('event') eq 'user.search'>
	<ul class="nav nav-pills">
		<li <cfif arguments.event.getArg('event') eq 'user.edit'>class="active"</cfif>><view:a event="user.edit">Create User</view:a></li>
		<li <cfif arguments.event.getArg('event') eq 'user.list'>class="active"</cfif>><view:a event="user.list">List Users</view:a></li>
		<li <cfif arguments.event.getArg('event') eq 'user.search'>class="active"</cfif>><view:a event="user.search">Search Users</view:a></li>
	</ul>
</cfif>


<!--- SUBNAV FOR EVENTS --->
<cfif arguments.event.getArg('event') eq 'event.edit' OR  arguments.event.getArg('event') eq 'event.list'  OR  arguments.event.getArg('event') eq 'event.search'>
	<ul class="nav nav-pills">
		<li <cfif arguments.event.getArg('event') eq 'event.edit'>class="active"</cfif>><view:a event="event.edit">Create Event</view:a></li>
		<li <cfif arguments.event.getArg('event') eq 'event.list'>class="active"</cfif>><view:a event="event.list">List Events</view:a></li>
		<li <cfif arguments.event.getArg('event') eq 'event.search'>class="active"</cfif>><view:a event="event.search">Search Events</view:a></li>
	</ul>
</cfif>	

<!--- SUBNAV FOR ACTIVITES --->
<cfif arguments.event.getArg('event') eq 'activity.edit' OR  arguments.event.getArg('event') eq 'activity.list'  OR  arguments.event.getArg('event') eq 'activity.search'>
	<ul class="nav nav-pills">
		<li <cfif arguments.event.getArg('event') eq 'activity.edit'>class="active"</cfif>><view:a event="activity.edit">Create Activity</view:a></li>
		<li <cfif arguments.event.getArg('event') eq 'activity.list'>class="active"</cfif>><view:a event="activity.list">List Activities</view:a></li>
		<li <cfif arguments.event.getArg('event') eq 'activity.search'>class="active"</cfif>><view:a event="activity.search">Search Activities</view:a></li>
	</ul>
</cfif>

<!--- SUBNAV FOR CHAPTERS --->
<cfif arguments.event.getArg('event') eq 'chapter.edit' OR  arguments.event.getArg('event') eq 'chapter.list'>
	<ul class="nav nav-pills">
		<li <cfif arguments.event.getArg('event') eq 'chapter.edit'>class="active"</cfif>><view:a event="chapter.edit">Create Chapter</view:a></li>
		<li <cfif arguments.event.getArg('event') eq 'chapter.list'>class="active"</cfif>><view:a event="chapter.list">List Chapters</view:a></li>
	</ul>
</cfif>