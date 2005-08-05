/*
 *  Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. DARK HORSE
 *  VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package org.aspcfs.modules.mycfs.base;

import org.aspcfs.modules.troubletickets.base.TicketList;

/**
 * Description of the Class
 *
 * @author Mathur
 * @version $id:exp$
 * @created July 16, 2004
 */
public class TicketEventList {
  public final static int OPEN_PRODUCT_TICKET = 1;
  public final static int OPEN_TICKET = 2;
  public final static int OPEN_PROJECT_TICKET = 3;

  TicketList openProductTickets = new TicketList();
  TicketList openTickets = new TicketList();
  TicketList openProjectTickets = new TicketList();
  int size = 0;


  /**
   * Sets the size attribute of the TaskEventList object
   *
   * @param size The new size value
   */
  public void setSize(Integer size) {
    this.size = size.intValue();
  }


  /**
   * Gets the size attribute of the TicketEventList object
   *
   * @return The size value
   */
  public int getSize() {
    return size;
  }


  /**
   * Sets the openProductTickets attribute of the TicketEventList object
   *
   * @param tmp The new openProductTickets value
   */
  public void setOpenProductTickets(TicketList tmp) {
    this.openProductTickets = tmp;
  }


  /**
   * Gets the openProductTickets attribute of the TicketEventList object
   *
   * @return The openProductTickets value
   */
  public TicketList getOpenProductTickets() {
    return openProductTickets;
  }


  /**
   * Gets the openTickets attribute of the TicketEventList object
   *
   * @return The openTickets value
   */
  public TicketList getOpenTickets() {
    return openTickets;
  }


  /**
   * Gets the openProjectTickets attribute of the TicketEventList object
   *
   * @return The openProjectTickets value
   */
  public TicketList getOpenProjectTickets() {
    return openProjectTickets;
  }


  /**
   * Sets the openTickets attribute of the TicketEventList object
   *
   * @param tmp The new openTickets value
   */
  public void setOpenTickets(TicketList tmp) {
    this.openTickets = tmp;
  }


  /**
   * Sets the openProjectTickets attribute of the TicketEventList object
   *
   * @param tmp The new openProjectTickets value
   */
  public void setOpenProjectTickets(TicketList tmp) {
    this.openProjectTickets = tmp;
  }


  /**
   * Gets the sizeString attribute of the TaskEventList object
   *
   * @return The sizeString value
   */
  public String getSizeString() {
    return String.valueOf(size);
  }
}

