package org.motus

class ContentController {

    def index() { 
		redirect(action:'home')
	}
	
	def home(){
		def view = "/content/home"
		
		withMobileDevice { device ->
			view = "/content/home_mobile"
		}
		render(view : view)
	}
	
	def about(){}
	
	def privacy(){}
	
	private def withMobileDevice(Closure c){
		if( request.currentDevice.isMobile()){
			c.call request.currentDevice
		}
	}
}
