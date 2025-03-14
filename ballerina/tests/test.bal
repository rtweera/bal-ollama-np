import ballerina/test;
import ballerinax/np;

type Person record {| 
    string name; 
    int age; 
|};

type Country record {| 
    string name; 
    string capital; 
    string[] languages; 
|};

public isolated function getPersonInfo(np:Context context, np:Prompt prompt) returns Person|error = @np:NaturalFunction external;
public isolated function getCountryInfo(np:Context context, np:Prompt prompt) returns Country|error = @np:NaturalFunction external;

np:Prompt canadaPrompt = `Canada is a country in North America. The capital city is Ottawa. The 
official languages are English and French, and there are also many indigenous languages spoken. 
Canada is known for its vast landscapes, multicultural cities, and friendly people. Provide the 
name, capital, and languages of this country in a structured format.`;

np:Prompt johnPrompt = `John is a 30-year-old software engineer from San Francisco. He lives at 
123 Main St, San Francisco, CA 94105. His hobbies include hiking, reading, and coding. He has 
worked at Google as a Senior Software Engineer from 2015 to 2020 and at Facebook as a Tech Lead 
from 2020 to present. He graduated from Stanford University with a Bachelor's degree in Computer 
Science in 2014. He has worked on projects such as a social media platform, a machine learning 
library, and a cloud computing service. Give me his details.`;

@test:Config {}
function testGetPersonInfo() returns error? {
    np:Context context = { model: check new OllamaModel() };
    var result = getPersonInfo(context, johnPrompt);
    if result is Person {
        test:assertEquals(result.name, "John");
        test:assertEquals(result.age, 30);
    } else {
        test:assertFail(msg = result.toString());
    }
}

@test:Config {}
function testGetCountryInfo() returns error? {
    np:Context context = { model: check new OllamaModel() };
    var result = getCountryInfo(context, canadaPrompt);
    if result is Country {
        test:assertEquals(result.name, "Canada");
        test:assertEquals(result.capital, "Ottawa");
        test:assertTrue(result.languages.length() > 0);
    } else {
        test:assertFail(msg = result.toString());
    }
}

@test:Config {}
function testGetPersonInfoWithDifferentModel() returns error? {
    np:Context context = { model: check new OllamaModel(model="mistral") };
    var result = getPersonInfo(context, johnPrompt);
    if result is Person {
        test:assertEquals(result.name, "John");
        test:assertEquals(result.age, 30);
    } else {
        test:assertFail(msg = result.toString());
    }
}

@test:Config {}
function testGetCountryInfoWithDifferentModel() returns error? {
    np:Context context = { model: check new OllamaModel(model="mistral") };
    var result = getCountryInfo(context, canadaPrompt);
    if result is Country {
        test:assertEquals(result.name, "Canada");
        test:assertEquals(result.capital, "Ottawa");
        test:assertTrue(result.languages.length() > 0);
    } else {
        test:assertFail(msg = result.toString());
    }
}

@test:Config {}
function testGetPersonIncorrectModel() returns error? {
    np:Context context = { model: check new OllamaModel(model="invalid_model") };
    var result = getPersonInfo(context, johnPrompt);
    test:assertTrue(result is error, msg = "Expected an error but got a Person");
}