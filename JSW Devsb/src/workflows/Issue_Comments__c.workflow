<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Issue_comments_created</fullName>
        <description>Issue comments created</description>
        <protected>false</protected>
        <recipients>
            <recipient>bodhtree.admin@jsw.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Issue_Comments_Created_By_User</template>
    </alerts>
    <alerts>
        <fullName>Issue_comments_created_by_Admin</fullName>
        <description>Issue comments created by Admin</description>
        <protected>false</protected>
        <recipients>
            <field>Issue_Tracker_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Issue_Comments_Created_By_Admin</template>
    </alerts>
    <fieldUpdates>
        <fullName>Issue_Tracker_Owner_Email</fullName>
        <field>Issue_Tracker_Owner_Email__c</field>
        <formula>Issue_overview__r.CreatedBy.Email</formula>
        <name>Issue Tracker Owner Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Issue Comments Created By Admin</fullName>
        <actions>
            <name>Issue_comments_created_by_Admin</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Issue_Tracker_Owner_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Issue_Comments__c.CreatedById</field>
            <operation>equals</operation>
            <value>Bodhtree Admin</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Issue Comments Created By User</fullName>
        <actions>
            <name>Issue_comments_created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Issue_Comments__c.CreatedById</field>
            <operation>notEqual</operation>
            <value>Bodhtree Admin</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
