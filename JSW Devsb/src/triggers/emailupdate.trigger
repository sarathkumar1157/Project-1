trigger emailupdate on Account (after insert) {
    id recid = [select id,developername,SobjectType from recordtype where SobjectType='Account' and developername='Non_Trade'].id;
    for(Account opp : trigger.new){
        if(opp.RecordTypeId != recid){
            if(opp.Email_Sent__c == False){
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                List<Messaging.EmailFileAttachment> attachmentList = new List<Messaging.EmailFileAttachment>();
                if(opp.Id != null){
                    opp = [SELECT id, Name, ownerid, owner.email FROM Account WHERE Id = :opp.Id];  
                }                  

                // create email content
                String Name = opp.Name; 
                String subject = 'New Proposal ';
                email.setSubject(subject);

                String line1 = 'Name:'+Name;
                String body = line1; 
                //String mail = UserInfo.getUserEmail();
                String mail = opp.owner.email;
                email.setPlainTextBody(body);
                email.setToAddresses(new String[]{mail});
                
                if(email != null){
                    //opp.Email_Sent__c = True; 
                    // fetch attachments for Account
                    List<Attachment> nwal = new List<Attachment>();
                    nwal = [SELECT id, Name, body, ContentType FROM Attachment WHERE ParentId =: opp.id];
                    system.debug('===att===='+nwal.size());
                    
                    // List of attachments handler
                    // Create the email attachment
                    for(Attachment at : nwal){
                            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                            efa.setFileName(at.Name);
                            efa.setBody(at.body);
                            efa.setContentType(at.ContentType);
                            attachmentList.add(efa);
                            
                            // Attach files to email instance
    
    
                    }
                }
                email.setFileAttachments(attachmentList);
                Messaging.sendEmail(new Messaging.singleEmailMessage[] {email});
            }
        }else{
            if(opp.Mail_to_SAP__c){
                if(opp.Email_Sent__c==False){
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    List<Messaging.EmailFileAttachment> attachmentList = new List<Messaging.EmailFileAttachment>();

                    opp = [SELECT id, Name, ownerid, owner.email FROM Account WHERE Id = :opp.Id];                    
                    
                    // create email content
                    String Name = opp.Name; 
                    String subject = 'New Proposal ';
                    email.setSubject(subject);
                    
                    
                    String line1 = 'Name:'+Name;
                    String body = line1; 
                    String mail = opp.owner.email;
                    email.setPlainTextBody(body);
                    email.setToAddresses(new String[]{mail});
                    if(email != null){
                        //opp.Email_Sent__c = True; 
                        
                        // fetch attachments for Account
                        List<Attachment> nwal = new List<Attachment>();
                        nwal = [SELECT id, Name, body, ContentType FROM Attachment WHERE ParentId =:opp.id];
                        
                        system.debug('===att===='+nwal.size());
                        
                        // List of attachments handler
                        
                        
                        // Create the email attachment
                        for(Attachment at : nwal){
                            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                            efa.setFileName(at.Name);
                            efa.setBody(at.body);
                            efa.setContentType(at.ContentType);
                            attachmentList.add(efa);
                            
                            // Attach files to email instance
    
    
                        }
                    }
                    email.setFileAttachments(attachmentList);
                    Messaging.sendEmail(new Messaging.singleEmailMessage[] {email});
                }
            }
        }
    }
}