package com.monkey.restapi.tool;


import java.lang.annotation.*;

/**
 * Created by huangjifei on 2016/10/27.
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface PersonalClassDesc {
    String value() default "";
}

