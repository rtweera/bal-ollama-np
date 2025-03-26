import ballerina/persist as _;
import ballerina/time;

public type EmailReport record {|
    readonly string id;
    string problemType;     // Type of problem (e.g., "Technical", "Billing", "General Inquiry")
    string priority;        // Priority level (e.g., "High", "Medium", "Low")
    string issueSummary;    // Short summary of the issue (e.g., "User cannot log in")
    string affectedUserName; // Name of the person with the issue (e.g., "John Doe")
    string affectedUserEmail;
    time:Utc createdAt; // Timestamp when the report was created
|};