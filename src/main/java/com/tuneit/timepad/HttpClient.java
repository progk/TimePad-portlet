package com.tuneit.timepad;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

public class HttpClient {

    public String connectToTimePad(String str) {

        URLConnection connection = null;
        BufferedReader input = null;
        String outputValue = null;
        try {
            URL url = new URL(str);
            connection = url.openConnection();
            input = new BufferedReader(new InputStreamReader(
                                    connection.getInputStream()));
            outputValue = input.readLine();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return outputValue;
    }

}
