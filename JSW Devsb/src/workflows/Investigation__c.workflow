<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Detail_Investigation_Alert</fullName>
        <description>Detail Investigation Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Detail_Investigation_By__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Detail_Investigation_Alert</template>
    </alerts>
    <alerts>
        <fullName>Notify_CCRS_user</fullName>
        <description>Notify CCRS user</description>
        <protected>false</protected>
        <recipients>
            <recipient>bodhtree.admin@jsw.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Settlement_CreatedTemplate</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Detail_Investigation</fullName>
        <field>Detail_Investigation__c</field>
        <literalValue>1</literalValue>
        <name>Update Detail Investigation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Detail Investigation</fullName>
        <actions>
            <name>Update_Detail_Investigation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Investigation__c.Conclusion__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Investigation__c.Compensation__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Investigation__c.Acceptance_Remarks__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Investigation__c.Reason_for_Acceptance__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Detail Investigation Alert</fullName>
        <actions>
            <name>Detail_Investigation_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Investigation__c.Detail_Investigation__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Detail_Investigation_Alert</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Investigation__c.CreatedDate</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
