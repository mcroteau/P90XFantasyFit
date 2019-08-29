package org.motus.log

import org.springframework.dao.DataIntegrityViolationException

class SkippedWorkoutLogController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [skippedWorkoutLogInstanceList: SkippedWorkoutLog.list(params), skippedWorkoutLogInstanceTotal: SkippedWorkoutLog.count()]
    }

    def create() {
        [skippedWorkoutLogInstance: new SkippedWorkoutLog(params)]
    }

    def save() {
        def skippedWorkoutLogInstance = new SkippedWorkoutLog(params)
        if (!skippedWorkoutLogInstance.save(flush: true)) {
            render(view: "create", model: [skippedWorkoutLogInstance: skippedWorkoutLogInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'skippedWorkoutLog.label', default: 'SkippedWorkoutLog'), skippedWorkoutLogInstance.id])
        redirect(action: "show", id: skippedWorkoutLogInstance.id)
    }

    def show(Long id) {
        def skippedWorkoutLogInstance = SkippedWorkoutLog.get(id)
        if (!skippedWorkoutLogInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'skippedWorkoutLog.label', default: 'SkippedWorkoutLog'), id])
            redirect(action: "list")
            return
        }

        [skippedWorkoutLogInstance: skippedWorkoutLogInstance]
    }

    def edit(Long id) {
        def skippedWorkoutLogInstance = SkippedWorkoutLog.get(id)
        if (!skippedWorkoutLogInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'skippedWorkoutLog.label', default: 'SkippedWorkoutLog'), id])
            redirect(action: "list")
            return
        }

        [skippedWorkoutLogInstance: skippedWorkoutLogInstance]
    }

    def update(Long id, Long version) {
        def skippedWorkoutLogInstance = SkippedWorkoutLog.get(id)
        if (!skippedWorkoutLogInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'skippedWorkoutLog.label', default: 'SkippedWorkoutLog'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (skippedWorkoutLogInstance.version > version) {
                skippedWorkoutLogInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'skippedWorkoutLog.label', default: 'SkippedWorkoutLog')] as Object[],
                          "Another user has updated this SkippedWorkoutLog while you were editing")
                render(view: "edit", model: [skippedWorkoutLogInstance: skippedWorkoutLogInstance])
                return
            }
        }

        skippedWorkoutLogInstance.properties = params

        if (!skippedWorkoutLogInstance.save(flush: true)) {
            render(view: "edit", model: [skippedWorkoutLogInstance: skippedWorkoutLogInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'skippedWorkoutLog.label', default: 'SkippedWorkoutLog'), skippedWorkoutLogInstance.id])
        redirect(action: "show", id: skippedWorkoutLogInstance.id)
    }

    def delete(Long id) {
        def skippedWorkoutLogInstance = SkippedWorkoutLog.get(id)
        if (!skippedWorkoutLogInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'skippedWorkoutLog.label', default: 'SkippedWorkoutLog'), id])
            redirect(action: "list")
            return
        }

        try {
            skippedWorkoutLogInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'skippedWorkoutLog.label', default: 'SkippedWorkoutLog'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'skippedWorkoutLog.label', default: 'SkippedWorkoutLog'), id])
            redirect(action: "show", id: id)
        }
    }
}
