
package com.tuneit.timepad;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Event {
    
    private final String CREATE_URL = "http://timepad.ru/api/event_create/?";
    private final String EDIT_URL = "http://timepad.ru/api/event_edit/?";
    private String eventID;
    private String domain;
    private String id;
    private String apiCode;
    private String name;
    private String startDate;
    private String endDate;
    private String shortDesc;
    private String description;
    private boolean publicity;
    
    
    Event() {
        this.id = "";
        this.apiCode = "";
        this.name = "";
        this.startDate = "";
        this.endDate = "";
        this.shortDesc = "";
        this.description = "";
        this.eventID = "";
        this.domain = "";
        this.publicity = false;
        
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getApiCode() {
        return apiCode;
    }

    public void setApiCode(String apiCode) {
        this.apiCode = apiCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isPublicity() {
        return publicity;
    }

    public void setPublicity(boolean publicity) {
        this.publicity = publicity;
    }

    public String getEventID() {
        return eventID;
    }

    public void setEventID(String eventID) {
        this.eventID = eventID;
    }
    
    public String getDomain() {
        return domain;
    }

    public void setDomain(String domain) {
        this.domain = domain;
    }
    
    public String createEventURL(Event event)
    {
        String url = "";
        try {
            url = url.concat(CREATE_URL + "code=" + URLEncoder.encode(this.apiCode, "utf-8") + "&id=" + URLEncoder.encode(this.id, "utf-8") +
                    "&name=" + URLEncoder.encode(this.name, "utf-8") + "&start_date=" + URLEncoder.encode(this.startDate, "utf-8") +
                    "&end_date=" + URLEncoder.encode(this.endDate, "utf-8") + "&shortdescription=" + URLEncoder.encode(this.shortDesc, "utf-8") +
                    "&description=" + URLEncoder.encode(this.description, "utf-8"));
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(Event.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        if (event.isPublicity())
            url += "&public=1";
        else 
            url += "&public=0";
        System.out.println(url);
        return url;
    }
    
     public String updateEventURL(Event event)
    {
        String url = "";
        try {
            url = url.concat(EDIT_URL + "code=" + URLEncoder.encode(this.apiCode, "utf-8") + "&id=" + URLEncoder.encode(this.id, "utf-8") +
                    "&e_id=" + URLEncoder.encode(this.eventID, "utf-8") + "&name=" + URLEncoder.encode(this.name, "utf-8") + "&start_date=" + URLEncoder.encode(this.startDate, "utf-8") +
                    "&end_date=" + URLEncoder.encode(this.endDate, "utf-8") + "&shortdescription=" + URLEncoder.encode(this.shortDesc, "utf-8") +
                    "&description=" + URLEncoder.encode(this.description, "utf-8"));
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(Event.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        if (event.isPublicity())
            url += "&public=1";
        else 
            url += "&public=0";
        System.out.println(url);
        return url;
    }

    @Override
    public String toString() {
        return "Event{" + "MAIN_URL=" + CREATE_URL + ", apiCode=" + apiCode + ", name=" + name + ", startDate=" + startDate + ", endDate=" + endDate + ", shortDesc=" + shortDesc + ", description=" + description + ", publicity=" + publicity + ", id=" + id + '}';
    }
    
    public void abc(){
        System.out.println("abc");
    }
    
}
