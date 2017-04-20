<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.intermine.metadata.Model" %>
<%@ page import="org.intermine.pathquery.Constraints, org.intermine.pathquery.OrderDirection, org.intermine.pathquery.PathQuery" %>
<%@ page import="org.intermine.webservice.client.core.ServiceFactory, org.intermine.webservice.client.services.QueryService, org.intermine.webservice.client.results.Page" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.util.Comparator, java.util.Map, java.util.LinkedHashMap, java.util.List, java.util.Set, java.util.TreeSet, java.util.ArrayList, java.util.Arrays" %>
<%
// initialization - ought to be a better way!
String serviceRoot = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getServletContext().getContextPath()+"/service";

ServiceFactory factory = new ServiceFactory(serviceRoot);
QueryService service = factory.getQueryService();
Model model = factory.getModel();

// DataTables request parameters
int draw = Integer.parseInt(request.getParameter("draw"));     // increases monotonically on each page draw
int start = Integer.parseInt(request.getParameter("start"));   // starting row, zero-based: 0, 25, 50, ...
int length = Integer.parseInt(request.getParameter("length")); // number of rows: 25
// search[value]
// search[regex]
// order[i][column]
// order[i][dir]
// columns[i][data]
// columns[i][name]
// columns[i][searchable]
// columns[i][orderable]
// columns[i][search][value]
// columns[i][search][regex]

// passed in using the ajax.data object
String experimentID = request.getParameter("experimentID");

Map<String,Object> jsonMap = new LinkedHashMap<String,Object>();
    
try {
        
    // paging
    Page markerPage = new Page(start, length);
        
    // query markers and their IDs for this page for values query
    PathQuery markerQuery = new PathQuery(model);
    markerQuery.addViews("GeneticMarker.primaryIdentifier", "GeneticMarker.id");
    markerQuery.addConstraint(Constraints.eq("GeneticMarker.experiments.primaryIdentifier", experimentID));
    List<List<String>> markerResults = service.getResults(markerQuery, markerPage);
    List<String> markers = new ArrayList<String>();
    List<Integer> markerIDs = new ArrayList<Integer>();
    for (List<String> result : markerResults) {
        markers.add(result.get(0));
        markerIDs.add(Integer.parseInt(result.get(1)));
    }
    int recordsTotal = service.getCount(markerQuery);
        
    // query values for this list of markers
    PathQuery valueQuery = new PathQuery(model);
    valueQuery.addViews("Genotype.value", "Genotype.line.primaryIdentifier", "Genotype.marker.primaryIdentifier");
    valueQuery.addConstraint(Constraints.eq("Genotype.experiment.primaryIdentifier", experimentID));
    valueQuery.addConstraint(Constraints.inIds("Genotype.marker", markerIDs));
    valueQuery.addOrderBy("Genotype.marker.primaryIdentifier", OrderDirection.ASC);
    valueQuery.addOrderBy("Genotype.line.primaryIdentifier", OrderDirection.ASC);
    List<List<String>> valueResults = service.getAllResults(valueQuery);
    List<String> values = new ArrayList<String>();
    for (List<String> result : valueResults) {
        values.add(result.get(0));
    }
            
    // unwrap the values into data rows with marker on either end
    int n = 0;
    int numLines = values.size()/markers.size();
    List<Object> dataList = new ArrayList<Object>();
    for (String marker : markers) {
        List<String> valueList = new ArrayList<String>();
        valueList.add(marker); // marker in first column
        for (int i=0; i<numLines; i++) {
            valueList.add(values.get(n++));
        }
        valueList.add(marker); // marker in last column
        dataList.add(valueList.toArray());
    }

    // create the JSON response using the Map to JSON utility
    jsonMap.put("draw", draw);
    jsonMap.put("recordsTotal", recordsTotal);
    jsonMap.put("recordsFiltered", recordsTotal); // FIX THIS
    jsonMap.put("data", dataList.toArray());

} catch (Exception ex) {

    jsonMap.put("error", ex.toString());

}

// write the JSON to the response
try {
    JSONObject json = new JSONObject(jsonMap);
    json.write(response.getWriter());
} catch (Exception ex) {
    throw new RuntimeException(ex);
}
%>
