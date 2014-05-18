<%@include file="init.jsp"%>
<%@page import="java.util.Calendar"%>

<%@ page import="javax.portlet.RenderRequest" %>

<portlet:defineObjects />

<portlet:actionURL name="saveCategory" var="saveCategoryURL"/>
<portlet:actionURL name="removeCategory" var="removeCategoryURL"/>



<%
    String name;
    String startDate;
    String endDate;
    String price;
    String count;
    ArrayList<Category> categoryList;

    categoryList = (ArrayList<Category>) request.getAttribute("categoryList");

    if (categoryList == null) {
        categoryList = new ArrayList<Category>();
        System.out.println("this is null");
    }

%>


<script type="text/javascript">

    function saveCategory(str, data) {
        jQuery.ajax({
            type: "POST",
            data: str + "=" + data,
            url: "<%= saveCategoryURL.toString()%>",
            success: function() {
            }
        });
    }

    $(function() {
        var name = $("#nameCategory");
        var price = $("#priceCategory");
        var count = $("#countCategory");
        var startDate = $("#datepickerStartCategory");
        var endDate = $("#datepickerEndCategory");
        var allFields = $([]).add(name).add(price).add(count).add(startDate).add(endDate),
                tips = $(".validateTips");

        function updateTips(t) {
            tips
                    .text(t)
                    .addClass("ui-state-highlight");
            setTimeout(function() {
                tips.removeClass("ui-state-highlight", 1500);
            }, 500);
        }

        function checkLength(o, n, min, max) {
            if (o.val().length > max || o.val().length < min) {
                o.addClass("ui-state-error");
                updateTips("Length of " + n + " must be between " +
                        min + " and " + max + ".");
                return false;
            } else {
                return true;
            }
        }

        function checkRegexp(o, regexp, n) {
            if (!(regexp.test(o.val()))) {
                o.addClass("ui-state-error");
                updateTips(n);
                return false;
            } else {
                return true;
            }
        }


        $("#dialog-form").dialog({
            autoOpen: false,
            height: 500,
            width: 450,
            modal: true,
            buttons: {
                "Create Category": function() {
                    var bValid = true;
                    allFields.removeClass("ui-state-error");
                    bValid = bValid && checkLength(name, "name", 1, 100);
                    bValid = bValid && checkRegexp(price, /^([0-9])+$/i, "Price may consist only 0-9.");
                    bValid = bValid && checkRegexp(count, /^([0-9])+$/i, "Count may consist only 0-9.");
                    bValid = bValid && checkRegexp(startDate, /^([0-9][0-9])\-([0-9][0-9])\-([[0-9][0-9][0-9][0-9])$/i, "Date format: dd-mm-yyyy.");
                    bValid = bValid && checkRegexp(endDate, /^([0-9][0-9])\-([0-9][0-9])\-([[0-9][0-9][0-9][0-9])$/i, "Date format: dd-mm-yyyy.");


                    if (bValid) {
                        jQuery.ajax({
                            type: "POST",
                            data: {nameCategory: name.val(), priceCategory: price.val(),
                                countCategory: count.val(), startDateCategory: startDate.val(),
                                endDateCategory: endDate.val()},
                            url: "<%=saveCategoryURL.toString()%>",
                            success: function() {

                            }
                        });

                        var trTable = $("<tr> </tr>");
                        trTable.append("<td>" + name.val() + "</td>" +
                                "<td>" + price.val() + "</td>" +
                                "<td>" + count.val() + "</td>" +
                                "<td>" + startDate.val() + "</td>" +
                                "<td>" + endDate.val() + "</td>");
                        trTable.append("<td>" + '<input type="button" id="removeCategory" onclick="removeCategory(this)" value="Remove"/>' + "</td>");

                        $("#categoryTable tbody").append(trTable);
                        $(this).dialog("close");
                    }
                },
                Cancel: function() {
                    $(this).dialog("close");
                }
            },
            close: function() {
                allFields.val("").removeClass("ui-state-error");
            }
        });

        $(function() {
            $("#datepickerStartCategory").datepicker({
                dateFormat: 'dd-mm-yy',
                firstDay: 1
            });
        });


        $(function() {
            $("#datepickerEndCategory").datepicker({
                dateFormat: 'dd-mm-yy',
                firstDay: 1
            });
        });

        $("#createCategory").button().click(function() {
            $("#dialog-form").dialog("open");
        });

        $("#removeCategory").click(function() {

        });

    });
    function removeCategory(th) {
        var row = $(th).closest("tr").index();
        $(th).closest("tr").remove();
        console.info(row);
        jQuery.ajax({
            type: "POST",
            data: "row=" + row,
            url: "<%=removeCategoryURL.toString()%>",
            success: function() {

            }
        });
    }


</script>



<div id="dialog-form" title="Create new Category">
    <p class="validateTips">All form fields are required.</p>
    <form>
        <fieldset>
            <label for="name">Name of Category</label>
            <input type="text" name="nameCategory" id="nameCategory" value="" class="text ui-widget-content ui-corner-all"/>
            <label for="price">Price</label>
            <input type="number" name="priceCategory" id="priceCategory" min="0" value="0" class="text ui-widget-content ui-corner-all"/>
            <label for="count">Count</label>
            <input type="number" name="countCategory" id="countCategory" min="1" value="1" class="text ui-widget-content ui-corner-all"/>
            <label for="password">Start Date</label>
            <input type="text" name="startDateCategory" id="datepickerStartCategory" placeholder="dd-mm-yyyy" autocomplete="off" class="text ui-widget-content ui-corner-all"/>
            <label for="password">End Date</label>
            <input type="text" name="endDateCategory" id="datepickerEndCategory" placeholder="dd-mm-yyyy" autocomplete="off" class="text ui-widget-content ui-corner-all"/>
            <input type="hidden" id="cat" value="0"/>
        </fieldset>
    </form>
</div>

<div id="users-contain" class="ui-widget">
    <table id="categoryTable" class="ui-widget ui-widget-content">
        <thead>
            <tr class="ui-widget-header">
                <th>Name of Category</th>
                <th>Price</th>
                <th>Ticket</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%for (Category category : categoryList) {
                    System.out.println(category.toString());%>
            <tr>
                <td><%=category.getrName()%></td>
                <td><%=category.getrPrice()%></td>
                <td><%=category.getrCount()%></td>
                <td><%=category.getrStartDate()%></td>
                <td><%=category.getrEndDate()%></td>
                <td><input type="button" id="removeCategory" onclick="removeCategory(this)" value="Remove" ></td>
            </tr>
            <% }%>
        </tbody>
    </table>
</div>

<button id="createCategory">Create new Category</button>
