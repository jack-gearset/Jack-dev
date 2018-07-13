trigger Apex_Trigger on Account_percentage__c (before insert) {
Account a = new Account(Name='Test Trigger');
insert a
;}