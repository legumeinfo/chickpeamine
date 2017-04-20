<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.List, java.util.ArrayList" %>
<!-- genotypeMap.jsp -->
<html:xhtml />
<tiles:importAttribute />
<%
// the genotyping experiment
String experimentID = (String) request.getAttribute("experimentID");

// the genotyping lines for this experiment
List<String> lines = (List<String>) request.getAttribute("lines");
%>

<h3><%=experimentID%></h3>

<table id="example" class="cell-border" cellspacing="0" width="100%">
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
     
     var table = $('#example').DataTable( {
         "deferRender": true,
         "processing": true, 
         "serverSide": true,
         "scrollX": true,
         "autoWidth": false,
         "pageLength": 25,
         "columnDefs": [
             {
                 "targets": [0,-1],
                 "className": 'markers b',
                 "orderable": false
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
             "url": "http://datil:8081/datatables/jsonGenerator.jsp",
             "type": "POST",
             "data": {
                 "experimentID": '<%=experimentID%>'
             }
         }
     } );
     
 } ); 
</script> 



<!-- /genotypeMap.jsp -->
