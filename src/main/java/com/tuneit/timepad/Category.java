
package com.tuneit.timepad;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Category {
    
    private String rName;
    private String rPrice;
    private String rCount;
    private String rStartDate;
    private String rEndDate;

    
    Category() {
        this.rCount = "";
        this.rEndDate = "";
        this.rName = "";
        this.rPrice = "";
        this.rStartDate = "";
        
    }
    
     Category(String rName, String rPrice, String rCount, String rStartDate, String rEndDate) {
         
        this.rCount = rCount;
        this.rEndDate = rEndDate;
        this.rName = rName;
        this.rPrice = rPrice;
        this.rStartDate = rStartDate;
        
        
    }

    public String getrName() {
        return rName;
    }

    public void setrName(String rName) {
        this.rName = rName;
    }

    public String getrPrice() {
        return rPrice;
    }

    public void setrPrice(String rPrice) {
        this.rPrice = rPrice;
    }

    public String getrCount() {
        return rCount;
    }

    public void setrCount(String rCount) {
        this.rCount = rCount;
    }

    public String getrStartDate() {
        return rStartDate;
    }

    public void setrStartDate(String rStartDate) {
        this.rStartDate = rStartDate;
    }

    public String getrEndDate() {
        return rEndDate;
    }

    public void setrEndDate(String rEndDate) {
        this.rEndDate = rEndDate;
    }
    
    public String createCategory(ArrayList<Category> list) {
        String str = "";
        
        for ( int i = 0; i < list.size(); i++)
            try {
                str = str.concat("&r" + String.valueOf(i+1) + "name=" + URLEncoder.encode(list.get(i).getrName(), "utf-8") +
                        "&r" + String.valueOf(i+1) + "price=" + URLEncoder.encode(list.get(i).getrPrice(), "utf-8") +
                        "&r" + String.valueOf(i+1) + "count=" + URLEncoder.encode(list.get(i).getrCount(), "utf-8") +
                        "&r" + String.valueOf(i+1) + "start_date=" + URLEncoder.encode(list.get(i).getrStartDate(), "utf-8") +
                        "&r" + String.valueOf(i+1) + "end_date=" + URLEncoder.encode(list.get(i).getrEndDate(), "utf-8"));
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(Category.class.getName()).log(Level.SEVERE, null, ex);
            }

        System.out.println(str);
        return str;
    }

    @Override
    public String toString() {
        return "Category{" + "NAME=" + rName + ", price=" + rPrice + ", count=" + rCount + ", startDate=" + rStartDate + ", endDate=" + rEndDate + '}';
    }

    
   
    
    
}
