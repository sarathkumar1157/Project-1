<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Issue_Tracker_Email_Alert</fullName>
        <description>Issue Tracker Email Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bodhtree.admin@jsw.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Issue_Tracker_Email_Alert</template>
    </alerts>
    <alerts>
        <fullName>Issue_status_changed</fullName>
        <description>Issue status changed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Issue_Tracker_Email_Alert</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_To_Assigned_User</fullName>
        <description>Send Email To Assigned User</description>
        <protected>false</protected>
        <recipients>
            <field>AssignedTo__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/CommunityChangePasswordEmailTemplate</template>
    </alerts>
    <fieldUpdates>
        <fullName>Record_Type_Update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Detail_Page</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Record Type Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Assigning created issues</fullName>
        <actions>
            <name>Issue_Tracker_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Issue_Tracker__c.OwnerId</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Issue_Tracker__c.Issue_Status__c</field>
            <operation>equals</operation>
            <value>Closed,In Testing,New,Open,Resolved,With Customer,With Developer</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Issue Tracker Record Type Update</fullName>
        <actions>
            <name>Record_Type_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Issue_Tracker__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Status Mail</fullName>
        <actions>
            <name>Issue_status_changed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Issue_Status__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
