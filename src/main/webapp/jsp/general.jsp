
<%@include file="init.jsp"%>
<portlet:actionURL name="saveGeneral" var="saveGeneralURL"/>
<portlet:actionURL name="publicEvent" var="publicEventURL"/>

<%
    String apiKey = "";
    String id = "";
    if (!request.getAttribute("apiKey").toString().isEmpty()) {
        apiKey = (String) request.getAttribute("apiKey");
    }
    if (!request.getAttribute("id").toString().isEmpty()) {
        id = (String) request.getAttribute("id");
    }
%>


<script type="text/javascript">
    function saveGeneral(str, data) {
        jQuery.ajax({
            type: "POST",
            data: str + "=" + data,
            url: "<%= saveGeneralURL.toString()%>",
        });
    }

    function publicEvnt() {
        jQuery.ajax({
            type: "POST",
            url: "<%= publicEventURL.toString()%>",
        });
    }

</script>

<div>
    <p>
        <aui:input name="id" type="text" label="Company ID" value="<%=id%>" onChange="saveGeneral('companyId', this.value);"/>
    </p><p>
        <aui:input name="apiKey" type="text" label="Api Key" value="<%=apiKey%>" onChange="saveGeneral('apiKey', this.value);"/>
    </p>
    <table>
        <tr>
            <td>
                <aui:input type="checkbox" label="New event" name="newEvent" checked="false" onChange="saveGeneral('newEvent', this.checked);"/>
                <aui:input name="public" type="submit" value="Save note" label="" onclick="publicEvnt();"/>
            </td>
        </tr>
    </table>
</div>