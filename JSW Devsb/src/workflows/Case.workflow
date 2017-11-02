<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>After_First_Investigation</fullName>
        <description>After First Investigation</description>
        <protected>false</protected>
        <recipients>
            <field>SO__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/First_Investigation_Alert</template>
    </alerts>
    <alerts>
        <fullName>Alert_on_Detailed_Investigation</fullName>
        <description>Alert on Detailed Investigation</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bodhtree.admin@jsw.in</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>SO__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>TSO__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Issue_Tracker_Email_Alert</template>
    </alerts>
    <alerts>
        <fullName>Complaint_Register_Email</fullName>
        <description>Complaint Register Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Case_Assignment_Template</template>
    </alerts>
    <fieldUpdates>
        <fullName>Owner_1_Field_Update</fullName>
        <field>Case_Owner_1__c</field>
        <formula>Owner:User.FirstName +  Owner:User.LastName</formula>
        <name>Owner 1 Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Owner_2_Field_Update</fullName>
        <field>Case_Owner_2__c</field>
        <formula>Owner:User.FirstName + Owner:User.LastName</formula>
        <name>Owner 2 Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>First Investigation Alert</fullName>
        <actions>
            <name>After_First_Investigation</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.First_Investigation__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>After_First_Investigation</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.CreatedDate</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Registration Mail</fullName>
        <actions>
            <name>Complaint_Register_Email</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
