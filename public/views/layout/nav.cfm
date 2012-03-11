<cfimport prefix="view" taglib="/MachII/customtags/view" />

<cfoutput>
	<!--- SUBNAV FOR USERS --->
	<cfif arguments.event.getArg('event') eq 'user.edit' OR arguments.event.getArg('event') eq 'user.list'  OR  arguments.event.getArg('event') eq 'user.search'>
		<view:message key="links.user.create" var="variables.createLinkText" />
		<view:message key="links.user.list" var="variables.listLinkText" />
		<view:message key="links.user.search" var="variables.searchLinkText" />
		<ul class="nav nav-pills">
			<li <cfif arguments.event.getArg('event') eq 'user.edit' and arguments.event.getArg('user').getId() eq ''>class="active"</cfif>><view:a event="user.edit">#variables.createLinkText#</view:a></li>
			<li <cfif arguments.event.getArg('event') eq 'user.list'>class="active"</cfif>><view:a event="user.list">#variables.listLinkText#</view:a></li>
			<li <cfif arguments.event.getArg('event') eq 'user.search'>class="active"</cfif>><view:a event="user.search">#variables.searchLinkText#</view:a></li>
		</ul>
	</cfif>

	<!--- SUBNAV FOR EVENTS --->
	<cfif arguments.event.getArg('event') eq 'event.edit' OR  arguments.event.getArg('event') eq 'event.list'  OR  arguments.event.getArg('event') eq 'event.search'>
		<view:message key="links.event.create" var="variables.createLinkText" />
		<view:message key="links.event.list" var="variables.listLinkText" />
		<view:message key="links.event.search" var="variables.searchLinkText" />
		<ul class="nav nav-pills">
			<li <cfif arguments.event.getArg('event') eq 'event.edit'>class="active"</cfif>><view:a event="event.edit">#variables.createLinkText#</view:a></li>
			<li <cfif arguments.event.getArg('event') eq 'event.list'>class="active"</cfif>><view:a event="event.list">#variables.listLinkText#</view:a></li>
			<li <cfif arguments.event.getArg('event') eq 'event.search'>class="active"</cfif>><view:a event="event.search">#variables.searchLinkText#</view:a></li>
		</ul>
	</cfif>	

	<!--- SUBNAV FOR ACTIVITES --->
	<cfif arguments.event.getArg('event') eq 'activity.edit' OR  arguments.event.getArg('event') eq 'activity.list'  OR  arguments.event.getArg('event') eq 'activity.search'>
		<view:message key="links.activity.create" var="variables.createLinkText" />
		<view:message key="links.activity.list" var="variables.listLinkText" />
		<view:message key="links.activity.search" var="variables.searchLinkText" />
		<ul class="nav nav-pills">
			<li <cfif arguments.event.getArg('event') eq 'activity.edit'>class="active"</cfif>><view:a event="activity.edit">#variables.createLinkText#</view:a></li>
			<li <cfif arguments.event.getArg('event') eq 'activity.list'>class="active"</cfif>><view:a event="activity.list">#variables.listLinkText#</view:a></li>
			<li <cfif arguments.event.getArg('event') eq 'activity.search'>class="active"</cfif>><view:a event="activity.search">#variables.searchLinkText#</view:a></li>
		</ul>
	</cfif>

	<!--- SUBNAV FOR CHAPTERS --->
	<cfif arguments.event.getArg('event') eq 'chapter.edit' OR  arguments.event.getArg('event') eq 'chapter.list'>
		<view:message key="links.chapter.create" var="variables.createLinkText" />
		<view:message key="links.chapter.list" var="variables.listLinkText" />
		<view:message key="links.chapter.search" var="variables.searchLinkText" />
		<ul class="nav nav-pills">
			<li <cfif arguments.event.getArg('event') eq 'chapter.edit'>class="active"</cfif>><view:a event="chapter.edit">#variables.createLinkText#</view:a></li>
			<li <cfif arguments.event.getArg('event') eq 'chapter.list'>class="active"</cfif>><view:a event="chapter.list">#variables.listLinkText#</view:a></li>
		</ul>
	</cfif>
</cfoutput>