package fit2

import grails.testing.web.interceptor.InterceptorUnitTest
import spock.lang.Specification

class BaseInterceptorSpec extends Specification implements InterceptorUnitTest<BaseInterceptor> {

    def setup() {
    }

    def cleanup() {

    }

    void "Test base interceptor matching"() {
        when:"A request matches the interceptor"
            withRequest(controller:"base")

        then:"The interceptor does match"
            interceptor.doesMatch()
    }
}
