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
	* caller passes in tableID and optional tableBodyID and rowLink if rows should be hyperlinked
--->
<cfif thisTag.ExecutionMode IS "start">

	<cfoutput>
		<script type="text/javascript" charset="utf-8">
			$(document).ready(function() {
		
				$('###attributes.tableID#').dataTable({"sPaginationType": "bootstrap",
				 "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
				 "sWrapper": "dataTables_wrapper form-inline"
				});

				$.extend( $.fn.dataTableExt.oStdClasses, {
		         "sWrapper": "dataTables_wrapper form-inline"} );
		
			<cfif StructKeyExists(attributes, "tableBodyID")>
				//link datatable rows if needed
				$('###attributes.tableBodyID# tr').live('click', function() {
					var thisId = $(this).find('td[id]').attr("id");
					<cfif StructKeyExists(attributes, "rowLink")>window.location = '#attributes.rowLink#&id=' + thisId;</cfif>
				});
			</cfif>
			} );
		</script>

		<style>
			###attributes.tableID#_length label {float:none;}
			###attributes.tableID#_filter {margin-bottom:10px;}
			###attributes.tableID#_length select {width:75px;}
			##statusSelector td {border:0px;border-collapse:collapse;}
			##statusSelector {border:0px;border-collapse:collapse;}	
			tr.odd { background-color: ##FFFFFF;}
			tr.even {background-color: ##FFFFFF;}
			tr.odd td.sorting_1 {background-color: ##FFFFFF;}
			tr.even td.sorting_1 {background-color: ##FFFFFF;}
			label input,label select {display: inline;}
			a.paginate.active{background-color: ##66CCFF;}
		</style>
	</cfoutput>
</cfif>