<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_email_when_record_created_in_order_booking_informatn</fullName>
        <ccEmails>pulimi.sivakanth@gmail.com</ccEmails>
        <description>Send email when record created in order booking informatn</description>
        <protected>false</protected>
        <recipients>
            <field>Account_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Send_Email_To_So</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Account_Owner_Email</fullName>
        <field>Account_Owner_Email__c</field>
        <formula>Account__r.Owner.Email</formula>
        <name>Update Account Owner Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Send emial to SO</fullName>
        <actions>
            <name>Send_email_when_record_created_in_order_booking_informatn</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Account_Owner_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Order_Booking_Information__c.Dealer__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
