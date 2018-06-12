package com.monkey.restapi.tool;

import java.lang.annotation.*;

/**
 * Created by huangjifei on 2016/10/27.
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface PersonalMethodDesc {
    String value() default "";
}
