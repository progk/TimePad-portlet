<%@include file="init.jsp"%>
<%@page import="com.tuneit.timepad.Registration"%>

<%@ page import="javax.portlet.RenderRequest" %>

<portlet:defineObjects />

<portlet:actionURL name="saveQuestion" var="saveQuestionURL"/>
<portlet:actionURL name="removeQuestion" var="removeQuestionURL"/>



<%     
     String name;
     String type;
     String mandatory;
     
     ArrayList<Registration> registrationList;
     
     registrationList = (ArrayList<Registration>) request.getAttribute("registrationList");
     
     if (registrationList == null) {
     registrationList = new ArrayList<Registration>();
     System.out.println("reg list is null");
     }

%>


<script type="text/javascript">

    function saveCategory(str, data) {
        jQuery.ajax({
            type: "POST",
            data: str + "=" + data,
            url: "<%= saveQuestionURL.toString()%>",
            success: function() {
            }
        });
    }

    function removeQuestion(th) {
        var row = $(th).closest("tr").index();
        $(th).closest("tr").remove();
        console.info(row);
        jQuery.ajax({
            type: "POST",
            data: "row=" + row,
            url: "<%=removeQuestionURL.toString()%>",
            success: function() {

            }
        });
    }

    function radioClick(str) {

        if (str == '1') { //radio
            $("#addQuestion").show();
            $("#variant").show();
            document.getElementById("hiddenRadio").value = str;
            document.getElementById("hiddenRadioVal").value = 'radio';
        }
        else if (str == '2') { //checkbox
            $("#addQuestion").show();
            $("#variant").show();
            document.getElementById("hiddenRadio").value = str;
            document.getElementById("hiddenRadioVal").value = 'multivar';
        }
        else if (str == '3') { //text
            $("#addQuestion").hide();
            $("#variant").hide();
            $("#regTable tbody tr").remove();
            document.getElementById("hiddenRadio").value = str;
            document.getElementById("hiddenRadioVal").value = 'text';
        }
        else if (str == '4') { //longtext
            $("#addQuestion").hide();
            $("#variant").hide();
            $("#regTable tbody tr").remove();
            document.getElementById("hiddenRadio").value = str;
            document.getElementById("hiddenRadioVal").value = 'bigtext';
        }


    }

    function mandatoryClick(str) {
        document.getElementById("checkBoxClick").value = str;
    }

    $(function() {
        var name = $("#nameQuestion");
        var mandatory = $("#mandatoryQuestion");
        var type = $("#typeQuestion");
        var allFields = $([]).add(name).add(mandatory).add(type),
                tips = $(".validateReg");
        function updateTips(t) {
            tips
                    .text(t)
                    .addClass("ui-state-highlight");
            setTimeout(function() {
                tips.removeClass("ui-state-highlight", 1500);
            }, 500);
        }

        function checkLength(o, n, min, max) {
            console.info("length");
            if (o.val().length > max || o.val().length < min) {
                o.addClass("ui-state-error");
                updateTips("Length of " + n + " must be between " +
                        min + " and " + max + ".");
                return false;
            } else {
                return true;
            }
        }

        function checkRadio(type) {
            var str = document.getElementById("hiddenRadio").value;
            console.info("radio");
            console.info(str);
            if (str == '3' || str == '4') {
                return true;
            }
            else if (str == '1' || str == '2') {
                var len = $("#regTable tbody tr").length;
                if (len < 2) {
                    type.addClass("ui-state-error");
                    updateTips("Two Variant required");
                    return false;
                }
                var field = true;
                var text;
                for (var i = 1; i <= len; i++) {
                    text = document.getElementById("textAnswer" + i.toString()).value;
                    console.info(text);
                    if (text.length > 100 || text.length < 1) {
                        type.addClass("ui-state-error");
                        updateTips("Length of " + i.toString() + " Answer" + " must be between " + 1 + " and " + 100 + ".");
                        return false;
                    }
                }
                if (field) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                type.addClass("ui-state-error");
                updateTips("Type of question required");
                return false;
            }
        }


        $("#dialogReg").dialog({
            autoOpen: false,
            height: 600,
            width: 450,
            modal: true,
            buttons: {
                "Create Question": function() {
                    var bValid = true;
                    allFields.removeClass("ui-state-error");
                    bValid = bValid && checkLength(name, "Question", 1, 100);
                    bValid = bValid && checkRadio(type);
                    if (bValid) {
                        var len = $("#regTable tbody tr").length;
                        console.error("len = " + len);
                        var text;
                        var dialogData = "";
                        dialogData = dialogData.concat("nameQuestion=" + document.getElementById("nameQuestion").value);
                        dialogData = dialogData.concat("&mandatoryQuestion=" + document.getElementById("checkBoxClick").value);
                        dialogData = dialogData.concat("&typeQuestion=" + document.getElementById("hiddenRadioVal").value);
                        dialogData = dialogData.concat("&numberAnswers=" + len);
                        console.info(dialogData);
                        for (var i = 1; i <= len; i++) {
                            text = document.getElementById("textAnswer" + i.toString()).value;
                            dialogData = dialogData.concat("&variant" + i.toString() + "=" + text.toString());
                        }
                        console.info(dialogData);
                        jQuery.ajax({
                            type: "POST",
                            data: dialogData,
                            url: "<%=saveQuestionURL.toString()%>",
                            success: function() {

                            }
                        });
                        
                        $("#registrationTable tbody").append("<tr>" +
                                "<td>" + name.val() + "</td>" +
                                "<td>" + document.getElementById("hiddenRadioVal").value + "</td>" +
                                "<td>" + document.getElementById("checkBoxClick").value + "</td>" +
                                "<td>" + '<input type="button" id="removeQuestion" value="Remove" onclick="removeQuestion(this)"/>' + "</td>" +
                                "</tr>");
                        $(this).dialog("close");
                        console.info("all right");
                    }
                },
                Cancel: function() {
                    $(this).dialog("close");
                }
            },
            close: function() {
                $("#regTable tbody tr").remove();
                $("input:radio").attr("checked", false);
                document.getElementById("hiddenRadio").value = "0";
                document.getElementById("hiddenRadioVal").value = "0";
                document.getElementById("checkBoxClick").value = "false";
                allFields.val("").removeClass("ui-state-error");
            }
        });
        $("#addQuestion").click(function() {
            console.info("add");
            var intId = $("#regTable tbody tr").length + 1;
            var tableReg = $("#regTable tbody");
            var num = $("<td><label id=\"label" + intId + "\">" + intId + ".&nbsp&nbsp</label></td>");
            var fName = $("<td><input type=\"text\" id=\"textAnswer" + intId + "\" class=\"fieldname\" /></td>");
            var removeButton = $("<td><input type=\"button\" id=\"removeAnswer=" + intId + "\" class=\"remove\" value=\"-\" /></td>");
            var trTable = $("<tr> </tr>");
            removeButton.click(function() {
                $(this).parent().remove();
                var num = 0;
                var col = 1;
                $("#regTable tbody tr td input[type=text]").each(function() {
                        num++;
                        $(this).attr("id", "textAnswer" + num.toString());
                        col++;
                });
                num = 0;
                 $("#regTable tbody tr td label").each(function() {
                        num++;
                        var number = $("<label id=\"label" + num + "\">" + num + ".&nbsp&nbsp</label>");
                        $(this).replaceWith(number);
                });
            });
            trTable.append(num);
            trTable.append(fName);
            trTable.append(removeButton);
            tableReg.append(trTable);
        });
        $("#createQuestion").button().click(function() {
            $("#addQuestion").hide();
            $("#variant").hide();
            $("#dialogReg").dialog("open");
        });
    });

</script>



<div id="dialogReg" title="Create new Question">
    <p class="validateReg">All form fields are required.</p>
    <form>
        <fieldset>
            <label for="nameQuestion">Question</label>
            <input type="textarea" name="nameQuestion" id="nameQuestion" value=""><br><br>
            <aui:input type="checkbox" name="mandatoryQuestion" id="mandatoryQuestion" checked="false" onChange="mandatoryClick(this.checked)" label="Mandatory"/><br>
            <label for="priceQuestion">Type</label>
            <aui:input type="radio" id="radio" name="radioButton" label="radio" value="1" checked="false" onClick="radioClick(1);"/>
            <aui:input type="radio" id="checkbox" name="radioButton" label="multivariant" value="2" checked="false" onClick="radioClick(2);"/>
            <aui:input type="radio" id="text" name="radioButton" label="text" value="3" checked="false" onClick="radioClick(3);"/>
            <aui:input type="radio" id="longText" name="radioButton" label="longText" value="4" checked="false" onClick="radioClick(4);"/><br>
            <input type="hidden" id="hiddenRadio" value="0"/>
            <input type="hidden" id="hiddenRadioVal" value="0"/>
            <input type="hidden" id="checkBoxClick" value="false"/>
            <label for="answerform" id="variant">Variant</label>
            <div id="answerform">
                <label><input type="button" name="addQuestion" id="addQuestion" value="Add"></label>
                <table id="regTable">
                    <tbody>


                    </tbody> 
                </table>
            </div>
        </fieldset>
    </form>

</div>
<div id="users-contain" class="ui-widget">
    <table id="registrationTable">
        <thead>
            <tr class="ui-widget-header">
                <th>Questions</th>
                <th>Type</th>
                <th>Mandatory</th>
                <th>Action</th>
            </tr>
        </thead>  
        <tbody>
             <%for (Registration reg : registrationList) {
                    System.out.println(reg.toString());%>
            <tr>
                <td><%=reg.getqName()%></td>
                <td><%=reg.getqType()%></td>
                <td><%=reg.getqMandatory()%></td>
                <td><input type="button" id="removeQuestion" value="Remove" onclick="removeQuestion(this)"/></td>
            </tr>
            <% }%>
        </tbody> 
    </table>
</div>
<button id="createQuestion">Create new Question</button>
