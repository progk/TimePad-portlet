<%@include file="init.jsp"%>

<%
    String eventID = TimePad.event.getEventID();
    String domain = TimePad.event.getDomain();
    String org = TimePad.event.getId();
    String nameOfEvent = TimePad.event.getName();
    String startDate = TimePad.event.getStartDate();
    String endDate = TimePad.event.getEndDate();
    String longDesc = TimePad.event.getDescription();
    String shortDesc = TimePad.event.getShortDesc();

%>


<input type="hidden" id="eventID" value="<%=eventID%>"/>
<input type="hidden" id="domain" value="<%=domain%>"/>
<input type="hidden" id="org" value="<%=org%>"/>


<div id="mainForm">
    <div class="event">
        <h2><%=nameOfEvent%></h2>
        <p><i><%=startDate%> - <%=endDate%></i></p>
    </div>
    <br>
    <div class="shortDescription">

        <p><%=shortDesc%></p>
    </div>
    <br>
    <br>
    <div class="description">
        <p> <%=longDesc%> </p>
    </div>
    
    <hr size="7" color="black" align="left">

</div>

<script defer="defer" data-timepad-widget-v2="event_register" data-timepad-customized="2835" src="//timepad.ru/js/tpwf/loader/min/loader.js">

    var eventID = document.getElementById("eventID").value;
    var domain = document.getElementById("domain").value;
    var org = document.getElementById("org").value;
    
    if ( eventID != "" )
        document.getElementById("mainForm").style.display = "block";
    else
        document.getElementById("mainForm").style.display = "none";

    (function() {
        return {"event": {"id": eventID.toString(), "org": org.toString(), "subdomain": domain.toString()}};
    })();


</script>



