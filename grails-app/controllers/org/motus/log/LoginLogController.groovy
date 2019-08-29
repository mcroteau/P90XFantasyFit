package org.motus.log

import org.springframework.dao.DataIntegrityViolationException

class LoginLogController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [loginLogInstanceList: LoginLog.list(params), loginLogInstanceTotal: LoginLog.count()]
    }

    def create() {
        [loginLogInstance: new LoginLog(params)]
    }

    def save() {
        def loginLogInstance = new LoginLog(params)
        if (!loginLogInstance.save(flush: true)) {
            render(view: "create", model: [loginLogInstance: loginLogInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'loginLog.label', default: 'LoginLog'), loginLogInstance.id])
        redirect(action: "show", id: loginLogInstance.id)
    }

    def show(Long id) {
        def loginLogInstance = LoginLog.get(id)
        if (!loginLogInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loginLog.label', default: 'LoginLog'), id])
            redirect(action: "list")
            return
        }

        [loginLogInstance: loginLogInstance]
    }

    def edit(Long id) {
        def loginLogInstance = LoginLog.get(id)
        if (!loginLogInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loginLog.label', default: 'LoginLog'), id])
            redirect(action: "list")
            return
        }

        [loginLogInstance: loginLogInstance]
    }

    def update(Long id, Long version) {
        def loginLogInstance = LoginLog.get(id)
        if (!loginLogInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loginLog.label', default: 'LoginLog'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (loginLogInstance.version > version) {
                loginLogInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'loginLog.label', default: 'LoginLog')] as Object[],
                          "Another user has updated this LoginLog while you were editing")
                render(view: "edit", model: [loginLogInstance: loginLogInstance])
                return
            }
        }

        loginLogInstance.properties = params

        if (!loginLogInstance.save(flush: true)) {
            render(view: "edit", model: [loginLogInstance: loginLogInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'loginLog.label', default: 'LoginLog'), loginLogInstance.id])
        redirect(action: "show", id: loginLogInstance.id)
    }

    def delete(Long id) {
        def loginLogInstance = LoginLog.get(id)
        if (!loginLogInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loginLog.label', default: 'LoginLog'), id])
            redirect(action: "list")
            return
        }

        try {
            loginLogInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'loginLog.label', default: 'LoginLog'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'loginLog.label', default: 'LoginLog'), id])
            redirect(action: "show", id: id)
        }
    }
}
