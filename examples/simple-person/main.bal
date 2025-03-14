import ballerinax/ollama.np as ollama;
import ballerinax/np;
import ballerina/io;


// Expected return type for the prompt
type Person record {|
    string name;
    int age;
|};

// Sample NP function to get user details (Note the annotation @np:NaturalFunction to make it a natural function)
// NOTE: context, prompt are required parameters for the function. You are free to use any other parameters as per your requirement.
public isolated function getPersonInfo(
        np:Context context,
        np:Prompt prompt
) returns Person|error = @np:NaturalFunction external;

// Run the function with default Ollama model (e.g., llama3.2:3B)
public function main() returns error? {
    final np:Context ollamaContext = {
        model: check new ollama:OllamaModel()
    };
    final np:Prompt prompt = `John is a 30-year-old software engineer from San Francisco. Give me his details.`;
    Person person = check getPersonInfo(ollamaContext, prompt);
    io:println("Name: ", person.name);
    io:println("Age: ", person.age);
}