<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Approved_Email_Alert</fullName>
        <description>Approved Email Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Conversion_Quantity_Approved</template>
    </alerts>
    <alerts>
        <fullName>COnversion_Rejection_Alert</fullName>
        <description>COnversion Rejection Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Conversion_Quantity_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approved_Picklist_Update</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved Picklist Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Conversion_Status</fullName>
        <field>Status__c</field>
        <literalValue>Pending</literalValue>
        <name>Conversion Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Conversion_Status_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Conversion Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejection_Field_Update</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Rejection Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
