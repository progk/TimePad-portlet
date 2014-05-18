/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tuneit.timepad;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.util.bridges.mvc.MVCPortlet;
import javax.portlet.*;
import java.io.*;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.logging.Logger;

public class TimePad extends MVCPortlet {

    private static Logger log = Logger.getLogger(TimePad.class.getName());
    public static ArrayList<Category> categoryList = new ArrayList<Category>();
    public static ArrayList<Registration> registrationList = new ArrayList<Registration>();
    public static Event event = new Event();
    public static boolean newEvent = false;
    
    @Override
    public void doView(RenderRequest renderRequest,
            RenderResponse renderResponse) throws IOException, PortletException {
        log.info("doView");
        renderRequest.setAttribute("apiKey", event.getApiCode());
        renderRequest.setAttribute("id", event.getId());
        renderRequest.setAttribute("description", event.getDescription());
        renderRequest.setAttribute("shortDesc", event.getShortDesc());
        renderRequest.setAttribute("nameEvent", event.getName());
        renderRequest.setAttribute("startDate", event.getStartDate());
        renderRequest.setAttribute("endDate", event.getEndDate());
        renderRequest.setAttribute("categoryList", categoryList);
        renderRequest.setAttribute("registrationList", registrationList);
        
        if (event.isPublicity()) {
            renderRequest.setAttribute("publicity", "true");
        } else {
            renderRequest.setAttribute("publicity", "false");
        }
        super.doView(renderRequest, renderResponse);
    }

    @ProcessAction(name = "saveGeneral")
    public void saveGeneral(ActionRequest actionRequest,
            ActionResponse actionResponse) throws IOException, PortletException,
            PortalException, SystemException {
         actionRequest.setCharacterEncoding("UTF-8");
        log.info("saveGeneral");
        String api = actionRequest.getParameter("apiKey");
        String id = actionRequest.getParameter("companyId");
        String evt = actionRequest.getParameter("newEvent");
        
        if (api == null) {
            api = event.getApiCode();
        }

        if (id == null) {
            id = event.getId();
        }
        
        try {
        if (evt.equals("true"))
            newEvent = true;
        else
            newEvent = false;
        }
        catch ( NullPointerException e){
            newEvent = false;
        }
        
        event.setApiCode(api);
        event.setId(id);
        
        log.info("newEvent= " + evt);
        log.info("api = " + api.toString());
        log.info("id = " + id.toString());
        log.info(event.toString());

    }

    @ProcessAction(name = "saveEvent")
    public void saveEvent(ActionRequest actionRequest,
            ActionResponse actionResponse) throws IOException, PortletException,
            PortalException, SystemException {

        log.info("readEvent");

        String desc = actionRequest.getParameter("description");
        String shortDesc = actionRequest.getParameter("shortDesc");
        String nameEvent = actionRequest.getParameter("nameEvent");
        String startDate = actionRequest.getParameter("startDate");
        String endDate = actionRequest.getParameter("endDate");
        String publicity = actionRequest.getParameter("publicity");

        if (desc == null) {
            desc = event.getDescription();
        }
        if (shortDesc == null) {
            shortDesc = event.getShortDesc();
        }
        if (nameEvent == null) {
            nameEvent = event.getName();
        }
        if (startDate == null) {
            startDate = event.getStartDate();
        }
        if (endDate == null) {
            endDate = event.getEndDate();
        }
        if (publicity != null) {
            if (publicity.equals("true")) {
                event.setPublicity(true);
            } else {
                event.setPublicity(false);
            }
        }

        event.setDescription(desc);
        event.setShortDesc(shortDesc);
        event.setName(nameEvent);
        event.setStartDate(startDate);
        event.setEndDate(endDate);

        log.info("readEvent");
        log.info(event.toString());
    }

    @ProcessAction(name = "saveCategory")
    public void saveCategory(ActionRequest actionRequest,
            ActionResponse actionResponse) throws IOException, PortletException,
            PortalException, SystemException {

        log.info("\n\n");
        log.info("saveCategory");

       //Category newCategory = (Category) actionRequest.getAttribute("newCategory");
        String nameCategory = (String) actionRequest.getParameter("nameCategory");
        String priceCategory = (String) actionRequest.getParameter("priceCategory");
        String countCategory = (String) actionRequest.getParameter("countCategory");
        String startDateCategory = (String) actionRequest.getParameter("startDateCategory");
        String endDateCategory = (String) actionRequest.getParameter("endDateCategory");

        Category category = new Category(nameCategory, priceCategory, countCategory, startDateCategory, endDateCategory);

        categoryList.add(category);

        log.info(category.toString());
        log.info("saveCategory");
        log.info("\n\n");

    }

    @ProcessAction(name = "removeCategory")
    public void removeCategory(ActionRequest actionRequest,
            ActionResponse actionResponse) throws IOException, PortletException,
            PortalException, SystemException {
        log.info("\n\n");
        log.info("removeCategory");

        int i = Integer.parseInt(actionRequest.getParameter("row"));
        System.out.println("row= " + i);
            try {
            categoryList.remove(i);
            }
            catch ( IndexOutOfBoundsException e) {
                log.info("out");
            }

        for (Category cat : categoryList) {
            System.out.println(cat.toString());
        }

        log.info("removeCategory");
        log.info("\n\n");

    }

    @ProcessAction(name = "saveQuestion")
    public void saveQuestion(ActionRequest actionRequest,
            ActionResponse actionResponse) throws IOException, PortletException,
            PortalException, SystemException {
        String qName = (String) actionRequest.getParameter("nameQuestion");
        String qMandatory = (String) actionRequest.getParameter("mandatoryQuestion");
        String qType = (String) actionRequest.getParameter("typeQuestion");
        String numberAnswers = (String) actionRequest.getParameter("numberAnswers");
        String[] qVariant = null;
        String variant;
        if ( !numberAnswers.equals("null") ) {
            int number = Integer.parseInt(numberAnswers);
            qVariant = new String[number + 1];
            for ( int i = 1; i <= number; i++  ) {
                variant = (String) actionRequest.getParameter("variant" + String.valueOf(i));
                log.info(variant.toString());
                qVariant[i] = variant;
            }  
        }
        if ( qMandatory.equals("true"))
            qMandatory = "1";
        else
            qMandatory = "0";
        Registration registration = new Registration(qName, qType, qMandatory, qVariant);
        registrationList.add(registration);
        log.info("saveQuestion");
        log.info(registration.toString());
       
        log.info("\n\n");

    }

    @ProcessAction(name = "removeQuestion")
    public void removeQuestion(ActionRequest actionRequest,
            ActionResponse actionResponse) throws IOException, PortletException,
            PortalException, SystemException {
        
         log.info("\n\n");
        log.info("removeQuestion");

        int i = Integer.parseInt(actionRequest.getParameter("row"));
        System.out.println("row= " + i);
            try {
            registrationList.remove(i);
            }
            catch ( IndexOutOfBoundsException e) {
                log.info("out");
            }

        for (Registration cat : registrationList) {
            System.out.println(cat.toString());
        }
        
        log.info("\n\n");
        log.info("removeQuestion");


    }

    @ProcessAction(name = "publicEvent")
    public void publicEvent(ActionRequest actionRequest,
            ActionResponse actionResponse) throws IOException, PortletException,
            PortalException, SystemException {

        HttpClient client = new HttpClient();
        String url = "";
        String output = "";
        String category;
        String registration;
        String eventNumber;
        String domain;
        String str[];
      log.info("new = " + newEvent);
      log.info("eventID = " + event.getEventID());
      
        if ( newEvent || event.getEventID().equals("")  )
        {
            url = event.createEventURL(event);
            log.info("create");
        }
        else {
            log.info("edit");
            url = event.updateEventURL(event);
        }
        category = new Category().createCategory(categoryList);
        registration = new Registration().createRegistration(registrationList);
        url = url.concat(category);
        url = url.concat(registration);
        output = client.connectToTimePad(url);
       
        log.info(output);
        if ( output.contains("{\"id\":") ) {
            
        str = output.split("\"");
        eventNumber = str[3];
        log.info("eventID = " + eventNumber);
         
        str = str[7].split("/");
        str = str[2].split("\\.");
        domain = str[0];
        log.info("domain = " + domain);
        event.setEventID(eventNumber);
        event.setDomain(domain);
         }
        log.info(url);
        log.info("publicEvent");
        log.info(output);

    }

}
