public type Email record {
    string fromName;        // Sender's name (e.g., "John Doe")
    string fromEmail;       // Sender's email address (e.g., "john.doe@gmail.com")
    string toEmail;         // Recipient's email address (e.g., "support@company.com")
    string subject;         // Email subject line (e.g., "Urgent: Login Issue")
    string body;            // Main content of the email
    string sentDateTime;    // Timestamp when the email was sent (e.g., "2025-03-24T10:30:00Z")
};

public type EmailAnalysis record {
    string problemType;     // Type of problem (e.g., "Technical", "Billing", "General Inquiry")
    string priority;        // Priority level (e.g., "High", "Medium", "Low")
    string issueSummary;    // Short summary of the issue (e.g., "User cannot log in")
    string affectedUserName; // Name of the person with the issue (e.g., "John Doe")
    string affectedUserEmail; // Email of the person with the issue (e.g., "john.doe@gmail.com")
};