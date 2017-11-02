<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Invoice_NSR_Processed</fullName>
        <field>Invoice_NSR_Processed__c</field>
        <literalValue>0</literalValue>
        <name>Invoice NSR Processed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Invoice NSR Update</fullName>
        <actions>
            <name>Invoice_NSR_Processed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>IF(ISCHANGED( Plant_Short_Form__c )||   ISCHANGED(Brand_Short_Form__c  ) ||  ISCHANGED( Sales_District__c ) ||  ISCHANGED(SLOC__c  ) ||  ISCHANGED( Distribution_Channel__c )   , True, False)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Test</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Invoice__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
