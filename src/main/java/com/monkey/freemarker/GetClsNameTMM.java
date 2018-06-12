package com.monkey.freemarker;

import freemarker.template.TemplateMethodModelEx;
import freemarker.template.TemplateModelException;

import java.util.List;

public class GetClsNameTMM implements TemplateMethodModelEx {
    public Object exec(List list) throws TemplateModelException {
        if (list.size()!=1){
            return new TemplateModelException("wrong param number, must be 1!");
        }

        String name = list.get(0).getClass().getName();
        System.out.println("class name of '"+list.get(0)+"' is '"+name+"'");
        return name;
    }
}