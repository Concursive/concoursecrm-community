package org.aspcfs.modules.setup.actions;

import org.aspcfs.modules.actions.CFSModule;
import com.darkhorseventures.framework.actions.*;
import org.aspcfs.utils.XMLUtils;
import javax.xml.parsers.*;
import org.w3c.dom.*;
import org.xml.sax.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import org.aspcfs.modules.setup.beans.Zlib;
import org.aspcfs.modules.setup.base.*;
import java.sql.Connection;
import org.aspcfs.modules.login.base.AuthenticationItem;
import org.aspcfs.utils.StringUtils;

public class SetupServer extends CFSModule {

  /**
   *  A sample server action to receive the submitted registration form
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandSubmitRegistration(ActionContext context) {
    try {
      //Receive the xml from the request
      XMLUtils xml = new XMLUtils(context.getRequest());
      //Create the object from the serialized xml
      Zlib license = new Zlib(xml);
      //Prepare the response XML
      DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
      DocumentBuilder builder = dbf.newDocumentBuilder();
      Document document = builder.newDocument();
      Element app = document.createElement("aspcfs");
      document.appendChild(app);
      Element response = document.createElement("response");
      app.appendChild(response);
      //Append the status code
      Element status = document.createElement("status");
      //Append the error text
      Element errorText = document.createElement("errorText");
      if (license.isValid()) {
        //Store the license information in the database
        Connection db = null;
        try {
          //get a database connection using the vhost context info
          AuthenticationItem auth = new AuthenticationItem();
          db = auth.getConnection(context, false);
          //locate a previous registration to send back
          db.setAutoCommit(false);
          Registration previousRegistration = RegistrationList.locate(db, license.getEmail(), license.getProfile(), true);
          //If a previous registration matches, then set it to disabled and insert the new registration
          if (previousRegistration != null) {
            previousRegistration.setEnabled(false);
            previousRegistration.updateEnabled(db);
          } else {
            license.setEdition("Free Edition (5-seat binary)");
            license.setText2(StringUtils.randomString(5,5));
          }
          //save the registration
          Registration registration = new Registration();
          registration.setKeyFile(license.getKeyText());
          registration.setNameFirst(license.getNameFirst());
          registration.setNameLast(license.getNameLast());
          registration.setCompany(license.getCompany());
          registration.setEmail(license.getEmail());
          registration.setProfile(license.getProfile());
          registration.setText(license.getText());
          registration.setOs(license.getOs());
          registration.setJava(license.getJava());
          registration.setWebserver(license.getWebserver());
          registration.setIp(context.getIpAddress());
          if (previousRegistration == null) {
            registration.setEdition(license.getEdition());
            registration.setText2(license.getText2());
          } else {
            registration.setEdition(previousRegistration.getEdition());
            registration.setText2(previousRegistration.getText2());
          }
          registration.insert(db);
          status.appendChild(document.createTextNode("0"));
          errorText.appendChild(document.createTextNode("SUCCESS"));
          db.commit();
        } catch (Exception e) {
          status.appendChild(document.createTextNode("1"));
          errorText.appendChild(document.createTextNode("FAILURE"));
          db.rollback();
        } finally {
          if (db != null) {
            db.setAutoCommit(true);
          }
          freeConnection(context, db);
        }
        //Send the registration email
        license.sendEmailRegistration();
      } else {
        status.appendChild(document.createTextNode("1"));
        errorText.appendChild(document.createTextNode("FAILURE"));
      }
      response.appendChild(status);
      response.appendChild(errorText);
      context.getRequest().setAttribute("statusXML", XMLUtils.toString(document, "UTF-8"));
    } catch (Exception e) {
      e.printStackTrace(System.out);
    }
    return "SubmitProcessOK";
  }
}
