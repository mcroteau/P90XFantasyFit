package org.motus

class CompetitionInvite {

	String status
	String message
	boolean acknowledged
	
	Date dateInvited
	Date dateAccepted
	Date dateDeclined
	
	Date dateAcknowledged
	
	Date dateCreated
	Date lastUpdated
	
	Account account
	Account organizer
	
	static belongsTo = [ competition : Competition]
		
    static constraints = {
		status(nullable:false)
		message(nullable:false)
		organizer(nullable:false)
		acknowledged(nullable:true)
		dateInvited(nullable:false)
		dateAccepted(nullable:true)
		dateDeclined(nullable:true)
		dateAcknowledged(nullable:true)
		id generator: 'sequence', params:[sequence:'ID_COMPETITION_INVITE_SEQ']
    }
	
}
