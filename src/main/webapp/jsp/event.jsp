<%@include file="init.jsp"%>
<%@page import="java.util.Calendar"%>

<%@ page import="javax.portlet.RenderRequest" %>

<portlet:defineObjects />

<portlet:actionURL name="saveEvent" var="saveEventURL"/>

<%
    Calendar calendar = Calendar.getInstance();
    String nameEvent = request.getAttribute("nameEvent").toString();
    String startDate = request.getAttribute("startDate").toString();
    String endDate = request.getAttribute("endDate").toString();
    String shortDesc = request.getAttribute("shortDesc").toString();
    String description = request.getAttribute("description").toString();

    boolean publicity = false;

    if (request.getAttribute("publicity") == "true") {
        publicity = true;
    } else {
        publicity = false;
    }

%>


<script type="text/javascript">

    $(function() {
        $("#datepickerStart").datepicker({
            dateFormat: 'dd-mm-yy',
            firstDay: 1,
            onSelect: function() {
                var dateObject = $(this).val();
                saveEvent("startDate", dateObject);
            }
        });
    });


    $(function() {
        $("#datepickerEnd").datepicker({
            dateFormat: 'dd-mm-yy',
            firstDay: 1,
            onSelect: function() {
                var dateObject = $(this).val();
                saveEvent("endDate", dateObject);
            }
        });
    });

    function saveEvent(str, data) {
        jQuery.ajax({
            type: "POST",
            data: str + "=" + data,
            url: "<%= saveEventURL.toString()%>",
            success: function() {
                //alert(data.toString());
            }

        });
    }

</script>

<div>

    <p>Name of Event:<br>
        <input name="nameEvent" label="Name of Event" type="text" value="<%=nameEvent%>" onChange="saveEvent('nameEvent', this.value);"/>
    </p>
    <br>
    <p>Start Date:<br>
        <input type="text" id="datepickerStart" placeholder="dd-mm-yyyy" value="<%=startDate%>" autocomplete="off" />
    </p>
    <br>
    <p>End Date:<br>
        <input type="text" id="datepickerEnd" placeholder="dd-mm-yyyy" value="<%=endDate%>" autocomplete="off" />
    </p>
    <br>
    <aui:input type="textarea" label="Short Description" name="shortDesc" value="<%=shortDesc%>" onChange="saveEvent('shortDesc',this.value);"/>
    <p>
        <aui:input type="textarea" label="Description" name="description" value="<%=description%>" onChange="saveEvent('description', this.value);"/>
    </p>
    <aui:input type="checkbox" label="Publicity" name="publicity" checked="<%=publicity%>" onChange="saveEvent('publicity', this.checked);"/>
</div>