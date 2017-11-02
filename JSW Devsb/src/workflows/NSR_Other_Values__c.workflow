<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Unique_Duplicate</fullName>
        <field>Unique_for_Duplicates__c</field>
        <formula>District_Code__c +&apos;:&apos;+ Product__c+&apos;:&apos;+distribution_Channel__c
+&apos;:&apos;+ TEXT(From_Date__c)</formula>
        <name>Unique Duplicate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Duplicate</fullName>
        <actions>
            <name>Unique_Duplicate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>NSR_Other_Values__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
