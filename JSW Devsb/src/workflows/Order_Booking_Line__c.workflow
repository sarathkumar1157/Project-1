<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Record_Lock_Line_Item</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Order_Line_Record_Lock</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Record Lock Line Item</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Order request Line Item Record Lock</fullName>
        <actions>
            <name>Record_Lock_Line_Item</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Order_Booking_Line__c.SO_Number__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
