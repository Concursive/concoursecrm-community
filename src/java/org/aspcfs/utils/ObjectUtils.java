package com.darkhorseventures.utils;

import java.lang.reflect.*;

public class ObjectUtils {

  public static boolean setParam(Object target, String param, Object value) {
    try {
      param = param.substring(0, 1).toUpperCase() + param.substring(1);
      Class[] argTypes = new Class[]{value.getClass()};
      Method method = target.getClass().getMethod("set" + param, argTypes);
      method.invoke(target, new Object[]{value});
    } catch (Exception e) {
      return false;
    }
    return true;
  }
  
  public static String getParam(Object target, String param) {
    try {
      param = param.substring(0, 1).toUpperCase() + param.substring(1);
      Method method = target.getClass().getDeclaredMethod("get" + param, null);
      Object result = method.invoke(target, null);
      if (result == null) {
        return null;
      } else if (result instanceof String) {
        return (String) result;
      } else {
        return String.valueOf(result);
      }
    } catch (Exception e) {
      return null;
    }
  }
  
  public static Object getObject(Object target, String param) {
    try {
      param = param.substring(0, 1).toUpperCase() + param.substring(1);
      Method method = target.getClass().getDeclaredMethod("get" + param, null);
      Object result = method.invoke(target, null);
      return result;
    } catch (Exception e) {
      return null;
    }
  }
}
