// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/time;

public type EmailReport record {|
    readonly string id;
    string problemType;
    string priority;
    string issueSummary;
    string affectedUserName;
    string affectedUserEmail;
    time:Utc createdAt;
|};

public type EmailReportOptionalized record {|
    string id?;
    string problemType?;
    string priority?;
    string issueSummary?;
    string affectedUserName?;
    string affectedUserEmail?;
    time:Utc createdAt?;
|};

public type EmailReportTargetType typedesc<EmailReportOptionalized>;

public type EmailReportInsert EmailReport;

public type EmailReportUpdate record {|
    string problemType?;
    string priority?;
    string issueSummary?;
    string affectedUserName?;
    string affectedUserEmail?;
    time:Utc createdAt?;
|};

