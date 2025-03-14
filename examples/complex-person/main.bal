import ballerina/io;
import ballerinax/np;
import ballerinax/ollama.np as ollamanp;

type Address record {|
    string street;
    string city;
    string state;
    string zip;
|};

type WorkExperience record {|
    string company;
    string position;
    string startDate;
    string endDate?;
|};

type Education record {|
    string institution;
    string degree;
    string graduationYear;
|};

type Project record {|
    string name;
    string description;
    string[] technologies;
|};

type Person record {|
    string name;
    int age;
    Address address;
    string[] hobbies;
    WorkExperience[] workExperience;
    Education[] education;
    Project[] projects;
|};

# This function prompts the LLM to get detailed information about a person.
#
# + context - model information  
# + prompt - prompt to be sent to the model
# + return - return in Person type
public isolated function getPersonDetails(
        np:Context context,
        np:Prompt prompt
) returns Person|error = @np:NaturalFunction external;

public function main() returns error? {
    final np:Context ollamaContext = {
        model: check new ollamanp:OllamaModel(model="gemma3")
    };
    final np:Prompt prompt = `John is a 30-year-old software engineer from San Francisco. He lives at 123 Main St, San Francisco, CA 94105. His hobbies include hiking, reading, and coding. He has worked at Google as a Senior Software Engineer from 2015 to 2020 and at Facebook as a Tech Lead from 2020 to present. He graduated from Stanford University with a Bachelor's degree in Computer Science in 2014. He has worked on projects such as a social media platform, a machine learning library, and a cloud computing service. Give me his details.`;
    Person person = check getPersonDetails(ollamaContext, prompt);
    io:println(person);
}
