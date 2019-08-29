package org.motus

import org.springframework.dao.DataIntegrityViolationException

class AccoladeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

	
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [accoladeInstanceList: Accolade.list(params), accoladeInstanceTotal: Accolade.count()]
    }

    def create() {
        [accoladeInstance: new Accolade(params)]
    }

    def save() {
        def accoladeInstance = new Accolade(params)
        if (!accoladeInstance.save(flush: true)) {
            render(view: "create", model: [accoladeInstance: accoladeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'accolade.label', default: 'Accolade'), accoladeInstance.id])
        redirect(action: "show", id: accoladeInstance.id)
    }

    def show(Long id) {
        def accoladeInstance = Accolade.get(id)
        if (!accoladeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'accolade.label', default: 'Accolade'), id])
            redirect(action: "list")
            return
        }

        [accoladeInstance: accoladeInstance]
    }

    def edit(Long id) {
        def accoladeInstance = Accolade.get(id)
        if (!accoladeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'accolade.label', default: 'Accolade'), id])
            redirect(action: "list")
            return
        }

        [accoladeInstance: accoladeInstance]
    }

    def update(Long id, Long version) {
        def accoladeInstance = Accolade.get(id)
        if (!accoladeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'accolade.label', default: 'Accolade'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (accoladeInstance.version > version) {
                accoladeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'accolade.label', default: 'Accolade')] as Object[],
                          "Another user has updated this Accolade while you were editing")
                render(view: "edit", model: [accoladeInstance: accoladeInstance])
                return
            }
        }

        accoladeInstance.properties = params

        if (!accoladeInstance.save(flush: true)) {
            render(view: "edit", model: [accoladeInstance: accoladeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'accolade.label', default: 'Accolade'), accoladeInstance.id])
        redirect(action: "show", id: accoladeInstance.id)
    }

    def delete(Long id) {
        def accoladeInstance = Accolade.get(id)
        if (!accoladeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'accolade.label', default: 'Accolade'), id])
            redirect(action: "list")
            return
        }

        try {
            accoladeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'accolade.label', default: 'Accolade'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'accolade.label', default: 'Accolade'), id])
            redirect(action: "show", id: id)
        }
    }
}
