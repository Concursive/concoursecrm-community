package com.darkhorseventures.utils;

import java.net.*;
import java.io.*;
import javax.net.ssl.*;
import java.security.*;
import javax.security.cert.X509Certificate;

/**
 *  Creates an SSLSocket connection to a remote SSL server, on the 
 *  specified port.
 *
 *@author     Matt Rajkowski
 *@created    March 15, 2002
 */
public class SSLMessage {

  private String url = null;
  private int port = -1;
  private String message = null;
  private String keystore = null;
  private String keystorePassword = null;

  /**
   *  Constructor for the SSLMessage object
   */
  public SSLMessage() { }


  /**
   *  Sets the url attribute of the SSLMessage object
   *
   *@param  tmp  The new url value
   */
  public void setUrl(String tmp) {
    url = tmp;
  }


  /**
   *  Sets the port attribute of the SSLMessage object
   *
   *@param  tmp  The new port value
   */
  public void setPort(int tmp) {
    port = tmp;
  }

  public void setKeystore(String tmp) { this.keystore = tmp; }
  public void setKeystorePassword(String tmp) { this.keystorePassword = tmp; }
  public String getKeystore() { return keystore; }
  public String getKeystorePassword() { return keystorePassword; }


  /**
   *  Sets the message attribute of the SSLMessage object
   *
   *@param  tmp  The new message value
   */
  public void setMessage(String tmp) {
    message = tmp;
  }


  /**
   *  Description of the Method
   *
   *@return                Description of the Returned Value
   *@exception  Exception  Description of Exception
   */
  public int send() throws Exception {

    if (url == null || port < 0 || message == null) {
      return 1;
    }

    try {
      //Prepare SSL... the host key needs to be in the keyring
      System.setProperty("java.protocol.handler.pkgs", 
        "com.sun.net.ssl.internal.www.protocol");
      Class classFactory = Class.forName("com.sun.net.ssl.internal.ssl.Provider");
      if( (null != classFactory) && (null == Security.getProvider("SunJSSE")) )
          Security.addProvider((Provider)classFactory.newInstance());
      if (System.getProperty("DEBUG") != null) {
        System.out.println("SSLMessage-> Keystore: " + keystore + ":" + keystorePassword);
      }
      
      SSLContext sslContext = SSLContext.getInstance("TLS");
      KeyManagerFactory keyManagerFactory = KeyManagerFactory.getInstance("SunX509");
      KeyStore keyStore = KeyStore.getInstance("JKS");
      char[] passphrase = keystorePassword.toCharArray();
      
      keyStore.load(new FileInputStream(keystore), passphrase);
      keyManagerFactory.init(keyStore, passphrase);
      sslContext.init(keyManagerFactory.getKeyManagers(), null, null);
      SSLSocketFactory factory = sslContext.getSocketFactory();
      
      /* SSLSocketFactory factory =
          (SSLSocketFactory) SSLSocketFactory.getDefault(); */
      if (System.getProperty("DEBUG") != null) {
        System.out.println("SSLMessage-> Opening SSLSocket");
      }
      SSLSocket socket = (SSLSocket) factory.createSocket(url, port);
      socket.startHandshake();
      if (System.getProperty("DEBUG") != null) {
        System.out.println("SSLMessage-> Sending Data");
      }
      PrintWriter out = new PrintWriter(
          new BufferedWriter(new OutputStreamWriter(socket.getOutputStream())));
      out.println(message);
      out.println();
      out.flush();

      //Receive response
      /*
       *  BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
       *  String inputLine;
       *  while ((inputLine = in.readLine()) != null && inputLine.indexOf("") == -1) {
       *  System.out.println(inputLine);
       *  }
       *  if (inputLine != null) {
       *  System.out.println(inputLine);
       *  }
       *  in.close();
       */
      out.close();
      socket.close();
      return 0;
    } catch (IOException io) {
      io.printStackTrace(System.out);
      return 1;
    }
  }
}

