package org.motus

class Permission {
	
	Permission(){
		this.uuid = UUID.randomUUID().toString()
	}
	
	String uuid

   	Account account
   	String permission

	static constraints = {
		uuid(nullable:true)
		id generator: 'sequence', params:[sequence:'ID_PERMISSION_PK_SEQ']
	}
}

