<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Record_Lock</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Record_Lock</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Record Lock</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Record_Lock_So_Number</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Record_Lock</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Record LockSo Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Order_Request_Name</fullName>
        <field>Order_Request_Header__c</field>
        <formula>Name</formula>
        <name>Update Order Request Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Record Lock</fullName>
        <actions>
            <name>Record_Lock_So_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Order_Request__c.So_Number__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Record Lock aftre SO Number update</fullName>
        <actions>
            <name>Record_Lock</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Order_Request__c.So_Number__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Order Request Name</fullName>
        <actions>
            <name>Update_Order_Request_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Order_Request__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
