<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Market_Information_Alert</fullName>
        <description>Market Information Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Market_Information_Alert</template>
    </alerts>
    <alerts>
        <fullName>test</fullName>
        <ccEmails>skalva@bodhtree.com</ccEmails>
        <description>test</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/CommunityChangePasswordEmailTemplate</template>
    </alerts>
    <fieldUpdates>
        <fullName>Change_to_Business_Partner_Check_Out</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Business_Partner_Check_Out</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change to Business Partner Check Out</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_to_Check_Out</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Account_Check_Out</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change to Account Check Out</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_to_InfluencerCheck_Out</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Influencer_Check_Out</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change to Influencer Check Out</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_to_Master_Account</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Account_Master</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change to Master Account</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_to_Project_Site_Check_Out</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Project_Site_Check_Out</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change to Project Site Check Out</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_to_Project_Site_Master</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Project_Site_Master</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change to Project Site Master</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_to_lead_Check_Out</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Lead_Check_Out</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change to lead Check Out</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Record_Type_to_Account</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Account</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Record Type to Account</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Record_Type_to_Business_Partner</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Business_Partner</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Record Type to Business Partner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Record_Type_to_Influencer</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Influencer</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Record Type to Influencer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Record_Type_to_Lead</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Lead</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Record Type to Lead</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Record_Type_to_Project_Site</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Project_Site</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Record Type to Project Site</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Business_Partner_Master</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Business_Partner_Master</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Business Partner Master</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Depot_Checkin_Layout</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Depot</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Depot Checkin Layout</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Depot_Checkout_Layout</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Depot_Check_Out</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Depot Checkout Layout</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Depot_Master_Layout</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Depot_Master</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Depot Master Layout</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Influencer_Master_Layout</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Influencer_Master</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Influencer Master Layout</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Lead_Master_Layout</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Lead_Master</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Lead Master Layout</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Visit_Completed</fullName>
        <field>Visit_Completed__c</field>
        <literalValue>1</literalValue>
        <name>Update Visit Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Visited_Check</fullName>
        <field>Visited__c</field>
        <literalValue>1</literalValue>
        <name>Visited Check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Account Checkin Layout</fullName>
        <actions>
            <name>Change_to_Check_Out</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(Check_In__c != null , Type__c = &apos;Account&apos;, ISNULL(Check_Out__c) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Account Checkout Layout</fullName>
        <actions>
            <name>Change_to_Master_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(Check_Out__c != null, Type__c  = &apos;Account&apos;, Check_In__c != null )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Business Partner Checkin Layout</fullName>
        <actions>
            <name>Change_to_Business_Partner_Check_Out</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED( Check_In__c ) , Type__c = &apos;Business Partner&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Business Partner Checkout Layout</fullName>
        <actions>
            <name>Update_Business_Partner_Master</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED( Check_Out__c ), Type__c  = &apos;Business Partner&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Checkout Layout</fullName>
        <actions>
            <name>Change_to_Master_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISCHANGED( Check_Out__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Depot Checkin Layout</fullName>
        <actions>
            <name>Update_Depot_Checkout_Layout</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED( Check_In__c ) , Type__c = &apos;Depot&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Depot Checkout Layout</fullName>
        <actions>
            <name>Update_Depot_Master_Layout</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED( Check_Out__c ), Type__c  = &apos;Depot&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Influencer Checkin Layout</fullName>
        <actions>
            <name>Change_to_InfluencerCheck_Out</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED( Check_In__c ) , Type__c = &apos;Influencer&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Influencer Checkout Layout</fullName>
        <actions>
            <name>Update_Influencer_Master_Layout</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED( Check_Out__c ), Type__c  = &apos;Influencer&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Lead Checkin Layout</fullName>
        <actions>
            <name>Change_to_lead_Check_Out</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED( Check_In__c ) , Type__c = &apos;Lead&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Lead Checkout Layout</fullName>
        <actions>
            <name>Update_Lead_Master_Layout</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED( Check_Out__c ), Type__c  = &apos;Lead&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Project Site CheckOut Layout</fullName>
        <actions>
            <name>Change_to_Project_Site_Master</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED( Check_Out__c ) , Type__c = &apos;Project Site&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Project Site Checkin Layout</fullName>
        <actions>
            <name>Change_to_Project_Site_Check_Out</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED( Check_In__c ) , Type__c = &apos;Project Site&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Visit Account Record Type</fullName>
        <actions>
            <name>Record_Type_to_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Visit__c.Type__c</field>
            <operation>equals</operation>
            <value>Account</value>
        </criteriaItems>
        <criteriaItems>
            <field>Visit__c.Check_In__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Visit__c.Check_Out__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Visit Business Partner Record Type</fullName>
        <actions>
            <name>Record_Type_to_Business_Partner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Visit__c.Type__c</field>
            <operation>equals</operation>
            <value>Business Partner</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Visit Completed Event</fullName>
        <actions>
            <name>Update_Visit_Completed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( Check_Out__c != null, ISCHANGED(Check_Out__c), Visit_Completed__c = false, Planned_Date__c = TODAY(), Planned__c = true)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Visit Depot Record Type</fullName>
        <actions>
            <name>Update_Depot_Checkin_Layout</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Visit__c.Type__c</field>
            <operation>equals</operation>
            <value>Depot</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Visit Influencer Record Type</fullName>
        <actions>
            <name>Record_Type_to_Influencer</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Visit__c.Type__c</field>
            <operation>equals</operation>
            <value>Influencer</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Visit Lead Record Type</fullName>
        <actions>
            <name>Record_Type_to_Lead</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Visit__c.Type__c</field>
            <operation>equals</operation>
            <value>Lead</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Visit Project Site Record Type</fullName>
        <actions>
            <name>Record_Type_to_Project_Site</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Visit__c.Type__c</field>
            <operation>equals</operation>
            <value>Project Site</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Visited Event</fullName>
        <actions>
            <name>Visited_Check</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  Check_Out__c != null,IF(Distance__c &lt; 0.5 , true, false))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
