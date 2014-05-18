
<%--
/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@include file="init.jsp"%>
<%@ page import="javax.portlet.*"%>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>

<portlet:defineObjects />

<%
    String tabs1 = ParamUtil.getString(request, "tabs1", "General Settings");

    PortletURL portletURL = renderResponse.createRenderURL();

    portletURL.setWindowState(WindowState.NORMAL);

    portletURL.setParameter("tabs1", tabs1);

    String tabNames = "General Settings,Event,Category,Registration";

%>

<liferay-ui:tabs
names="<%= tabNames%>"
url="<%= portletURL.toString()%>"
refresh="<%= false%>"
    >

    <liferay-ui:section>
        <%@include file="/jsp/general.jsp" %>
    </liferay-ui:section>

    <liferay-ui:section>
        <%@include file="/jsp/event.jsp" %>
    </liferay-ui:section>

    <liferay-ui:section>
        <%@include file="/jsp/category.jsp" %>
    </liferay-ui:section>
    
    <liferay-ui:section>
        <%@include file="/jsp/registration.jsp" %>
    </liferay-ui:section>

    <!--liferay-ui:section-->
        <!--%@include file="/jsp/participants.jsp" %-->
    <!--/liferay-ui:section-->

</liferay-ui:tabs>