<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.List, java.util.ArrayList" %>
<!-- genotypeDisplayer.jsp -->
<html:xhtml />
<tiles:importAttribute />
<style>
 body { font-family:sans-serif;  font-size:12px; }
 table.dataTable thead th, table.dataTable thead td {
     padding:2px; vertical-align:bottom; background-color:gray; color:white; font-size:8px; width:30px; border-right:1px solid #ddd; border-bottom:1px solid #ddd; border-top:0;
 }
 table.dataTable tfoot th, table.dataTable tfoot td {
     padding:2px; vertical-align:bottom; background-color:gray; color:white; font-size:8px; width:30px; border-right:1px solid #ddd; border-bottom:0; border-top:0;
 }
 table.dataTable tbody td {
     padding:2px; font-size:8px; color:white; background-color: gray;
 }
 table.dataTable tbody tr:hover {background-color:gray !important; color:white !important; }
 .highlight { background-color:gray !important; color:white !important; }
 .b { font-weight: bold; }
 .markers a { background-color:gray; color:white; font-size:8px; text-decoration:none; }
</style>
<%
// the genotyping experiment
String experimentID = (String) request.getAttribute("experimentID");

// the portal URL for links to genetic markers
String markerURL = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getServletContext().getContextPath()+"/portal.do?class=GeneticMarker&externalids=";

// the genotyping lines for this experiment
List<String> lines = (List<String>) request.getAttribute("lines");
%>

<table id="genotypes" class="cell-border" cellspacing="0" width="100%">
    <thead>
        <tr>
            <th></th>
            <% for (String line : lines) { %><th><%=line.replace('-',' ')%></th><% } %>
            <th></th>
        </tr>
    </thead>
    <tfoot>
        <tr>
            <th></th>
            <% for (String line : lines) { %><th><%=line.replace('-',' ')%></th><% } %>
            <th></th>
        </tr>
    </tfoot>
</table>

<script type="text/javascript"> 
 $(document).ready(function() {
     
     var table = $('#genotypes').DataTable( {
         "deferRender": true,
         "processing": true, 
         "serverSide": true,
         "scrollX": true,
         "autoWidth": false,
         "searching": false,
         "pageLength": 10,
         "columnDefs": [
             {
                 "targets": [0,-1],
                 "className": 'markers b',
                 "orderable": false,
                 "createdCell": function (td, cellData, rowData, row, col) {
                     $(td).html("<a href='<%=markerURL%>"+cellData+"'>"+cellData+"</a>");
                 }
             },
             {
                 "targets": '_all',
                 "className": 'dt-center b',
                 "orderable": false,
                 "createdCell": function (td, cellData, rowData, row, col) {
                     if ( cellData == 'A' ) {
                         $(td).css('background-color', 'red')
                     } else if ( cellData == 'B' ) {
                         $(td).css('background-color', 'green')
                     } else if ( cellData == 'a' ) {
                         $(td).css('background-color', 'darkred')
                     } else if ( cellData == 'b' ) {
                         $(td).css('background-color', 'darkgreen')
                     }
                 }
             }
         ],
         "ajax": {
             "url": "model/genotypeJSON.jsp",
             "type": "POST",
             "data": {
                 "experimentID": '<%=experimentID%>'
             }
         }
     } );
     
 } ); 
</script> 
<!-- /genotypeDisplayer.jsp -->
