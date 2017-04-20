<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.Map" %>
<!-- markerDisplayer.jsp -->
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
// url to link experiment report
String experimentURL = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getServletContext().getContextPath()+"/portal.do?class=GenotypingExperiment&externalids=";

// the experiments containing this marker, along with lines and values in their own map
Map<String,Map<String,String>> experimentMap = (Map<String,Map<String,String>>) request.getAttribute("experimentMap");

for (String experiment : experimentMap.keySet()) {
    Map<String,String> valuesMap = experimentMap.get(experiment);
%>
<div style="margin:2px 0;">
    <a href="<%=experimentURL+experiment%>"><%=experiment%></a>
</div>

<table id="<%=experiment%>" class="cell-border" cellspacing="0" width="100%">
    <thead>
        <tr>
            <% for (String line : valuesMap.keySet()) { %>
                <th><%=line.replace('-',' ')%></th>
            <% } %>
        </tr>
    </thead>
    <tbody>
        <tr>
            <% for (String value : valuesMap.values()) { %>
                <td><%=value%></td>
            <% } %>
        </tr>
    </tbody>
</table>

<script type="text/javascript"> 
 $(document).ready(function() {
     $('#<%=experiment%>').DataTable( {
         "scrollX": true,
         "autoWidth": false,
         "info": false,
         "paging": false,
         "searching": false,
         "columnDefs": [
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
         ]
     } );
 } ); 
</script> 
    
<%
} // loop over experiments
%>

<!-- /markerDisplayer.jsp -->
