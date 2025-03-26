import ballerinax/ollama.np as ollamanp;
import ballerinax/np;

public isolated function analyzeEmail(
    Email email,
    np:Context context = {
        model: check new ollamanp:OllamaModel()
    },
    np:Prompt prompt = `
        You are an expert email issue reviewer for a tech company that 
        categorizes issues under the following categories: ${categories}

        Your tasks are:
        1. Identify the type of problem according to the categories provided
        2. Determine the priority level (High, Medium, Low)
        3. Provide a short summary of the issue
        4. Identify the name of the person affected
        5. Identify the email of the person affected

        Return the analysis as a structured response.

        Here's the email you need to analyze:
        From: ${email.fromName} <${email.fromEmail}>
        To: ${email.toEmail}
        Subject: ${email.subject}
        Sent: ${email.sentDateTime}
        Body: ${email.body}
    `) returns EmailAnalysis|error = @np:NaturalFunction external;