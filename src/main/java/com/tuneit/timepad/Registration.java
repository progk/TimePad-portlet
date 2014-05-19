package com.tuneit.timepad;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Registration {

    private String qName;
    private String qType;
    private String qMandatory;
    private String[] qVariant;

    Registration(String qName, String qType, String qMandatory, String[] qVariant) {
        this.qName = qName;
        this.qMandatory = qMandatory;
        this.qType = qType;
        this.qVariant = qVariant;
    }

    Registration() {

        this.qName = "";
        this.qMandatory = "";
        this.qType = "";
        this.qVariant = null;
    }

    public String getqName() {
        return qName;
    }

    public void setqName(String qName) {
        this.qName = qName;
    }

    public String getqType() {
        return qType;
    }

    public void setqType(String qType) {
        this.qType = qType;
    }

    public String getqMandatory() {
        return qMandatory;
    }

    public void setqMandatory(String qMandatory) {
        this.qMandatory = qMandatory;
    }

    public String[] getqVariant() {
        return qVariant;
    }

    public void setqVariant(String[] qVarian) {
        this.qVariant = qVarian;
    }

    public String createRegistration(ArrayList<Registration> list) {
        String str = "";
        for (int i = 0; i < list.size(); i++) {
            try {
                str = str.concat("&q" + Integer.valueOf(i + 1) + "name=" + URLEncoder.encode(list.get(i).getqName(), "utf-8")
                        + "&q" + Integer.valueOf(i + 1) + "type=" + URLEncoder.encode(list.get(i).getqType(), "utf-8")
                        + "&q" + Integer.valueOf(i + 1) + "mandatory=" + URLEncoder.encode(list.get(i).getqMandatory(), "utf-8"));

                if (((list.get(i).getqType().equals("radio") || list.get(i).getqType().equals("multivar"))) && list.get(i).getqVariant() != null) {
                    for (int j = 1; j <= list.get(i).getqVariant().length - 1; j++) {
                        System.out.println(list.get(i).getqVariant().length);
                        str = str.concat("&q" + Integer.valueOf(i + 1) + "variant" + Integer.valueOf(j) + "=" + URLEncoder.encode(list.get(i).getqVariant()[j], "utf-8"));
                    }
                }
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(Registration.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        System.out.println("RegString: " + str);
        return str;
    }

    @Override
    public String toString() {
        return "Registration{" + "NAME=" + this.qName + ", type=" + this.qType + ", mandatory=" + qMandatory + ", variant=" + this.qVariant.toString() + '}';
    }

}
