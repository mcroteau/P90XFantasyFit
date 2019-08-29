package org.motus

import com.twilio.sdk.TwilioRestClient;
import com.twilio.sdk.TwilioRestException;
import com.twilio.sdk.resource.factory.MessageFactory;
import com.twilio.sdk.resource.instance.Message;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
 
import java.util.ArrayList;
import java.util.List;

class TextMessageService {

    public static final String ACCOUNT_SID = "ACc1ed3af82b268fa173adad3fd605dd0e";
    public static final String AUTH_TOKEN = "b3dbac4b7ca092b2f0fa503cd4ee5fff";
	public static final String CELL_PHONE_NUMBER = "+13016797292" 
	
	def send(recipient, body){
		try{
			TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
 
			List<NameValuePair> params = new ArrayList<NameValuePair>();
			params.add(new BasicNameValuePair("Body", body));
			params.add(new BasicNameValuePair("To", recipient));
			params.add(new BasicNameValuePair("From", CELL_PHONE_NUMBER));
 
			MessageFactory messageFactory = client.getAccount().getMessageFactory();
			Message message = messageFactory.create(params);
			println "** sent message : ${message.getSid()} **";
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
