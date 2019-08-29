package org.motus.log

import org.motus.Account

class ResetPasswordLog {

	Date date
	Account account
	boolean completed
	String originalPassword
	String newPassword

    static constraints = {
		completed(nullable:false)
		originalPassword(nullable:false)
		newPassword(nullable:true)
		id generator: 'sequence', params:[sequence:'ID_RESET_PASSWORD_LOG_PK_SEQ']
    }
	
}
