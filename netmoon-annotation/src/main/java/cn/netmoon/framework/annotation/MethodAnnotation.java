package cn.netmoon.framework.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface MethodAnnotation {
    String value();

    MethodAnnotation.logType type() default MethodAnnotation.logType.query;

    String ruleFlowName() default "";

    public static enum logType {
        login,
        query,
        insert,
        update,
        delete,
        serviceInterface,
        manager;

        private logType() {
        }
    }
}
