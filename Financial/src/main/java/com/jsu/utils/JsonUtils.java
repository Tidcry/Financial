package com.jsu.utils;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.List;

public class JsonUtils<T> {
    /**
     * 将对象集合包装成JSON格式
     * @param list    对象集合
     * @return    JSON格式字符串
     */
    public String setList2ToJson(List<T> list){
        StringBuffer msg=new StringBuffer("[");
        for(T obj:list){
            msg.append(setObject2Json(obj));
        }
        msg.deleteCharAt(msg.length()-1);
        msg.append("\n]");
        return msg.toString();
    }
    /**
     * 将类对象包装成JSON格式 ： {'name':'a','value':'b'},
     * @param obj
     * @return    JSON格式字符串
     */
    public String setObject2Json(T obj){
        StringBuffer sb=new StringBuffer("\n{'");
        Field[] fields=obj.getClass().getDeclaredFields();
        for(Field f:fields){
            String fieldName=f.getName();

            //成员变量是否序列化
            if(!fieldName.equals("serialVersionUID")){
                Object methodValue=getFieldValue(fieldName, obj);
                sb.append(fieldName);

                Class<?> cls=f.getType();
                /** 判断该成员变量是否自定义类对象 **/
                if(!cls.getName().equals("java.lang.String") && !cls.getName().equals("java.lang.Integer")
                        && !cls.getName().equals("java.util.Date") && !cls.getName().equals("long")){
                    sb.append("':");
                    /** 返回对象 **/
                    T o=(T)getFieldValue(f.getName(),obj) ;
                    String str=setObject2Json(o);
                    sb.append(str);
                    sb.append("\n'");
                }else{
                    sb.append("':'");
                    sb.append(methodValue.toString());
                    sb.append("',\n'");
                }
            }
        }
        sb.delete(sb.length()-4,sb.length()-1);
        sb.append("},");
        return sb.toString();
    }
    /**
     * 获取类所有属性名
     * @param obj 对象
     * @return    属性数组
     */
    public String[] getFieldNames(T obj){
        Field[] fields=obj.getClass().getDeclaredFields();
        String[] fnames=new String[fields.length];
        for(int i=0;i<fnames.length;i++){
            fnames[i]=fields[i].getName();
        }
        return fnames;
    }
    /**
     * 获取属性返回值
     * @param methodName
     * @param t
     * @return
     */
    public Object getFieldValue(String fieldName,T obj){
        /** 得到类属性值 **/
        Object methodValue=null;
        /** 组织GET方法名 **/
        String methodName="get"+fieldName.substring(0, 1).toUpperCase()+fieldName.substring(1);
        try {
            Method method=obj.getClass().getMethod(methodName, null);
            methodValue=(Object) method.invoke(obj, null);
            if(methodValue==null) methodValue="";
        }catch(Exception e){
            e.printStackTrace();
        }
        return methodValue;
    }
}
