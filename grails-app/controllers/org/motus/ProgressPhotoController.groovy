package org.motus

import org.motus.BaseController
import org.motus.ProgressPhoto

import java.awt.image.BufferedImage
import grails.util.Environment
import javax.imageio.ImageIO
import java.awt.Graphics2D
import java.util.UUID


@Mixin( BaseController )
class ProgressPhotoController {

    def index() { }
	
	def add_photo(Integer id){
		authenticatedAccount{ account ->
			if(id){
				def workoutPlan = WorkoutPlan.get(id)
				if(workoutPlan){
    				
					def progressPhotos = ProgressPhoto.findAllByWorkoutPlan(workoutPlan)
					
					[ workoutPlan: workoutPlan, progressPhotos : progressPhotos ]
					
				}else{
					flash.message = "Workout Plan cannot be found..."
					redirect(controller:'account', action:'profile')
				}
			}else{
				flash.message = "Unable to continue adding photos.  Please try again"
				redirect(controller:'account', action:'profile')
			}
		}
	}
	
	
	def remove_photo(Integer id){
		authenticatedAccount{ account ->
			def progressPhoto = ProgressPhoto.get(id)
			
			if(progressPhoto){
				def workoutPlan = progressPhoto.workoutPlan
				progressPhoto.delete(flush:true)
				
				/**
				def absolutePath = grailsApplication.mainContext.servletContext.getRealPath('images')
				absolutePath = absolutePath.endsWith("/") ? absolutePath : absolutePath + "/"

				def imageFileLocation = absolutePath + progressPhoto.imageFileName
				def thumbFileLocation = absolutePath + progressPhoto.thumbImageFileName
				println "thumbpath : ${thumbFileLocation}"
				
				def imageFile = new File(imageFileLocation)
				def thumbImage = new File(thumbFileLocation)
				
				imageFile.delete();
				thumbImage.delete();
				**/
				
				
				flash.message = "Successfully deleted photo"
				redirect(action:"add_photo", id: workoutPlan.id)
			}
		}
	}
	
	
	
	
	def upload_photo(){
		authenticatedAccount{ account ->
		
			if(params.id && params.type){
				
				def workoutPlan = WorkoutPlan.get(params.id)
				
				if(workoutPlan){
					def imageFile = request.getFile('image')
					def fileName = UUID.randomUUID()
					
					BufferedImage originalImage = null;
					
					try {
						
						originalImage = ImageIO.read(imageFile.getInputStream());
		 			   	
						if(originalImage){
						
		 			    	int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB : originalImage.getType();
							def baseUrl = "images/"
							
							def absolutePath = grailsApplication.mainContext.servletContext.getRealPath('images')
							absolutePath = absolutePath.endsWith("/") ? absolutePath : absolutePath + "/"
							def baseDirectory = "${absolutePath}"
							
							println "\n\nSAVING FILE : ${baseDirectory}\n\n"
							
							new File(baseDirectory).mkdirs();
							
							def thumbImageFileName = "${fileName}_thumb.jpg"
							def thumbImageUrl = "${baseUrl}${thumbImageFileName}"
							BufferedImage thumbImageJpg = resizeImage(originalImage, type, 80, 64);
							def thumbImageLocation = "${baseDirectory}${fileName}_thumb.jpg"
							ImageIO.write(thumbImageJpg, "jpg", new File(thumbImageLocation));
							
							
							def imageFileName = "${fileName}.jpg"
							def imageUrl = "${baseUrl}${imageFileName}"
							BufferedImage imageJpg = resizeImage(originalImage, type, 300, 240);
							def imageLocation = "${baseDirectory}${imageFileName}"
							ImageIO.write(imageJpg, "jpg", new File(imageLocation));
							
							
	    					def progressPhoto = new ProgressPhoto();
							progressPhoto.type = params.type
							
							progressPhoto.thumbImageUrl = thumbImageUrl
							progressPhoto.thumbImageFileName = thumbImageFileName
							
							progressPhoto.imageUrl = imageUrl
							progressPhoto.imageFileName = imageFileName
							
							progressPhoto.workoutPlan = workoutPlan
							progressPhoto.save(flush:true)
							
							flash.message = "Successfully added photo"
	       			 		redirect(action: "add_photo", id: workoutPlan.id)
							
						}else{
							flash.message = "please provide product image & image name"
	       			 		redirect(action: "additional_photos", id: productInstance.id)
						}
						
		    		} catch (IOException e) {
		    			e.printStackTrace();
						flash.message = "Something went wrong, please try again"
	       			 	redirect(action: "additional_photos", id: productInstance.id)
		    		}
					
				}else{
					flash.message = "Workout Plan cannot be found"
					redirect(controller : 'account', action: 'profile')
				}
			}else{
				flash.message = "Workout Plan cannot be found"
				redirect(controller : 'account', action: 'profile')
			}
		}
	}
	
	private def resizeImage(BufferedImage originalImage, int type, int height, int width){
		BufferedImage resizedImage = new BufferedImage(width, height, type);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(originalImage, 0, 0, width, height, null);
		g.dispose();
 
		return resizedImage;
	}
	
	
}
