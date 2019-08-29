package org.motus.workouts

import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils
import org.motus.log.SkippedWorkoutLog
import org.motus.Account
import org.motus.BaseController
import org.motus.annotation.RolePermission
import org.motus.annotation.WorkoutPlanPermission
import org.motus.AppConstants

@Mixin( BaseController )
class ${CLASS_NAME}Controller {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]


    def index() {
        redirect(action: "list", params: params)
    }


	def entry(Long id){
		withPlannedWorkout { ${INSTANCE_NAME} ->
			request.plannedWorkout = ${INSTANCE_NAME}
			render(view : AppConstants.ENTRY_VIEW)
		}
	}
	

    def list(Integer max) {
		authenticated { subject -> 
       		params.max = Math.min(max ?: 10, 100)
        	[${INSTANCE_NAME}List : ${CLASS_NAME}.list(params), ${INSTANCE_NAME}Total: CLASS_NAME.count()]
		}
    }


    def show(Long id) {
		withPlannedWorkout { ${INSTANCE_NAME} ->
			request.plannedWorkout = ${INSTANCE_NAME}
			render(view : AppConstants.SHOW_VIEW)
		}
    }


	def confirmSkip(Long id){
		withPlannedWorkout { ${INSTANCE_NAME} ->
			request.plannedWorkout = ${INSTANCE_NAME}
			render(view : AppConstants.CONFIRM_SKIP_VIEW)
		}
	}
	
	
	def skip(Long id){
		withPlannedWorkoutSkipped { ${INSTANCE_NAME} ->
			flash.message = AppConstants.SKIP_SUCCESSFUL_MESSAGE
			redirect(controller:'account', action:'dashboard')
		}
	}

	
	def confirmRecover(Long id){
		withPlannedWorkout { ${INSTANCE_NAME} ->
			request.plannedWorkout = ${INSTANCE_NAME}
			render(view : AppConstants.CONFIRM_RECOVER_VIEW)
		}
	}
	
	
	def recover(Long id){
		withPlannedWorkoutRecovered { ${INSTANCE_NAME} ->
			flash.message = AppConstants.RECOVERY_SUCCESSFUL_MESSAGE
			redirect(controller:'account', action:'dashboard')
		}
	}
	

    def update(Long id, Long version) {
		withPlannedWorkoutUpdated { ${INSTANCE_NAME} ->
			flash.message = AppConstants.UPDATE_SUCCESS_MESSAGE
			request.plannedWorkout = ${INSTANCE_NAME}
			render(view : AppConstants.SHOW_VIEW)
		}
	}
	
}
