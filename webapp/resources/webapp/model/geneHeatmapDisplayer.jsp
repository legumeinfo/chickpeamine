<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.net.URLEncoder" language="java" %>

<!-- geneHeatmapDisplayer.jsp -->
<html:xhtml />

<tiles:importAttribute />

<div id="gene-heatmap-displayer" style="display:block; margin:10px 0;">
    <h3>${WEB_PROPERTIES['geneHeatmapDisplayer.heading']}</h3>
    <c:if test="${WEB_PROPERTIES['geneHeatmapDisplayer.subheading']!=''}">
        <p>${WEB_PROPERTIES['geneHeatmapDisplayer.subheading']}</p>
    </c:if>
    <c:if test="${WEB_PROPERTIES['geneHeatmapDisplayer.pmid']!=''}">
        <p><a target="_blank" href="https://ncbi.nlm.nih.gov/pubmed/${WEB_PROPERTIES['heatmap.pmid']}">View article on PubMed</a></p>
    </c:if>
    <canvas id="canvasx" width="${WEB_PROPERTIES['geneHeatmapDisplayer.width']}" height="${WEB_PROPERTIES['geneHeatmapDisplayer.height']}"></canvas>
</div>

<script type="text/javascript">
 var cx = new CanvasXpress("canvasx",
                           ${expressionValueJSON},
                           {
                               "graphType": "Heatmap",
                               "title": "${WEB_PROPERTIES['geneHeatmapDisplayer.title']}",
                               "titleScaleFontFactor": ${WEB_PROPERTIES['geneHeatmapDisplayer.titleScaleFontFactor']},
                               "xAxisTitle": "",
                               "fontName": "Arial",
                               "canvasBox": true,
                               "heatmapCellBox": true,
                               "smpLabelScaleFontFactor": ${WEB_PROPERTIES['geneHeatmapDisplayer.smpLabelScaleFontFactor']},
                               "smpLabelFontStyle": "${WEB_PROPERTIES['geneHeatmapDisplayer.smpLabelFontStyle']}",
                               "smpLabelFontColor": "${WEB_PROPERTIES['geneHeatmapDisplayer.smpLabelFontColor']}",
                               "varLabelScaleFontFactor": ${WEB_PROPERTIES['geneHeatmapDisplayer.varLabelScaleFontFactor']},
                               "varLabelFontStyle": "${WEB_PROPERTIES['geneHeatmapDisplayer.varLabelFontStyle']}",
                               "varLabelFontColor": "${WEB_PROPERTIES['geneHeatmapDisplayer.varLabelFontColor']}",
                               "varLabelRotate": ${WEB_PROPERTIES['geneHeatmapDisplayer.varLabelRotate']},
                               "colorSpectrum": [ ${WEB_PROPERTIES['heatmap.colorSpectrum']} ],
                               "colorSpectrumBreaks": [ ${WEB_PROPERTIES['heatmap.colorSpectrumBreaks']} ],
                               "isLogData": ${WEB_PROPERTIES['heatmap.isLogData']},
                               "heatmapCellBox": true,
                               "showHeatMapIndicator": true,
                               "heatmapIndicatorPosition": "top",
                               "heatmapIndicatorHistogram": ${WEB_PROPERTIES['geneHeatmapDisplayer.heatmapIndicatorHistogram']},
                               "heatmapIndicatorWidth": ${WEB_PROPERTIES['geneHeatmapDisplayer.heatmapIndicatorWidth']},
                               "heatmapIndicatorHeight": ${WEB_PROPERTIES['geneHeatmapDisplayer.heatmapIndicatorHeight']},
                               "samplesKmeaned": false,
                               "variablesKmeaned": false,
                               "samplesClustered": false,
                               "variablesClustered": false,
                               "showSmpDendrogram": false,
                               "showVarDendrogram": false
                           },
                           {
                               click: function(o) {
                                   // do nothing
                                   var featureId = o.y.smps;
                                   var condition = o.y.vars;
                               }
                           }
 );
</script>
<!-- /geneHeatmapDisplayer.jsp -->

<div class="clear"></div>
