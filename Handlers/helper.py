import hashlib
import re
from twilio.rest import TwilioRestClient 
 
#reserved for twilio message usage
def send_message(toNumber, fromNumber, name):
    ACCOUNT_SID = "xxxx" 
    AUTH_TOKEN = "xxxx" 
     
    client = TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN) 
     
    client.messages.create(
        to=toNumber, 
        from_=fromNumber,
        body="Hello from "+ name + ": It's been three days since your last stay and our record found that you have not been moved to any of the shelters in the system, can we get any update to your status? Hope everything goes well.", 
    )



#md5 hash
def md5(s):
    m = hashlib.md5()
    m.update(s.encode("utf-8"))
    return m.hexdigest()

