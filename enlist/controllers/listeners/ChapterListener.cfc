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

$Id$

Notes:
--->
<cfcomponent
	displayname="ChapterListener"
	extends="MachII.framework.Listener"
	output="false"
	depends="chapterService">

	<!---
	PROPERTIES
	--->

	<!---
	CONFIGURATION / INITIALIZATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the listener.">
		<!--- Put custom configuration for this listener here. --->
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getChapter" access="public" output="false" returntype="enlist.model.chapter.Chapter">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<cfscript>
			if (not arguments.event.isArgDefined("chapter")) {
				return getChapterService().getChapter(arguments.event.getArg("id", 0));
			} else {
				return arguments.event.getArg("chapter");
			}
		</cfscript>
	</cffunction>

	<cffunction name="saveChapter" access="public" returntype="void" output="false"
		hint="Processes the chapter forms (registration, admin new/edit chapter) and saves the chapter">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<cfscript>
			var chapter = arguments.event.getArg("chapter");
			var errors = getChapterService().saveChapter(chapter);

			if (not StructIsEmpty(errors)) {
				arguments.event.setArg("message", "Please correct the following errors:");
				arguments.event.setArg("errors", errors);
				redirectEvent("fail", "", true);
			} else {
				arguments.event.setArg("message", "Chapter Saved");
				arguments.event.removeArg("chapter");
				redirectEvent("pass", "", true);
			}
		</cfscript>
	</cffunction>
</cfcomponent>