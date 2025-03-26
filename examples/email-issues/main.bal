import ballerina/io;
import ballerinax/ollama.np;
import ballerina/time;
import email_issues.store;
import ballerina/uuid; 

store:Client db = check new();
public isolated function main() returns error? {
    store:EmailReportInsert email = {
        id: uuid:createRandomUuid(),
        problemType: "Spam",
        priority: "High",
        issueSummary: "Spam email detected",
        affectedUserName: "John Doe",
        affectedUserEmail: "jd@example.com",
        createdAt: time:utcNow()
    };

    string[] email_ids = check db->/emailreports.post([email]);
    io:println("Inserted email report with ID: ", email_ids[0]);
}

