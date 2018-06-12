package com.monkey.db;

import freemarker.template.TemplateMethodModel;
import freemarker.template.TemplateModelException;

import java.util.List;

/**
 * Created by Administrator on 2017/4/17.
 */

public class BuildMethodSuffixName implements TemplateMethodModel {

    public Object exec(List arguments) throws TemplateModelException {
        String[] items = arguments.get(0).toString().toLowerCase().split("_");
        String fieldName = "";
        int i = 0;
        for(String item : items){
            fieldName+=captureName(item);
        }
        return fieldName.trim();

    }
    //首字母大写
    public static String captureName(String name) {
        char[] cs=name.toCharArray();
        cs[0]-=32;
        return String.valueOf(cs);

    }
    public static void main(String[] args){
        System.out.println(captureName("sdlkds_fklfd"));
    }
}
