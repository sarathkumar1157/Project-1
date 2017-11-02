<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Order_Schedule_Record_Lock</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Order_Schedule_Record_Lock</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Order Schedule Record Lock</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Order Schedule Record Lock</fullName>
        <actions>
            <name>Order_Schedule_Record_Lock</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Order_Booking_Schedule__c.SO_Number__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
