package fit2

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

		"/" {
		    controller = "content"
		    action = "home"
		}
		
		"/public/dashboard/$username" {
			controller = "account"
			action = "dashboard"
		}
		
		"/public/schedule/$username" {
			controller = "workoutPlan"
			action = "schedule"
		}
		
		"/public/history/$username" {
			controller = "workoutPlan"
			action = "history"
		}
		
		"/public/photos/$username" {
			controller = "workoutPlan"
			action = "photos"
		}
		
		"/public/competition/$username" {
			controller = "competition"
			action = "index"
		}
		
		
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
