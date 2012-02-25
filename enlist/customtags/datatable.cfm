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
<cfif thisTag.ExecutionMode IS "start">
	<script type="text/javascript" charset="utf-8">
		$(document).ready(function() {
	
			$('#chapters').dataTable({"sPaginationType": "bootstrap",
			 "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
			 "sWrapper": "dataTables_wrapper form-inline"
			});
			
			$.extend( $.fn.dataTableExt.oStdClasses, {
	         "sWrapper": "dataTables_wrapper form-inline"} );
	
			//link datatable rows to chapter.edit
			$('#chaptersList tr').live('click', function() {
				var thisId = $(this).find('td[id]').attr("id");
				window.location = '/index.cfm/?event=chapter.edit&id=' + thisId;
			});
			
		} );
	</script>
	
	 <style>
		#chapters_length label {float:none;}
		#chapters_filter {margin-bottom:10px;}
		#chapters_length select {width:75px;}
		#statusSelector td {border:0px;border-collapse:collapse;}
		#statusSelector {border:0px;border-collapse:collapse;}	
		tr.odd { background-color: #FFFFFF;}
		tr.even {background-color: #FFFFFF;}
		tr.odd td.sorting_1 {background-color: #FFFFFF;}
		tr.even td.sorting_1 {background-color: #FFFFFF;}
		label input,label select {display: inline;}
		a.paginate.active{background-color: #66CCFF;}
	</style> 
</cfif>