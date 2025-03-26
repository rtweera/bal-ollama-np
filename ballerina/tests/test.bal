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

// Additional record types for testing complex structures
type Address record {|
    string street;
    string city;
    string state;
    string zipCode;
|};

type Employee record {|
    string name;
    int age;
    Address address;
    string[] skills;
    float salary;
|};

type Book record {|
    string title;
    string author;
    int year;
    string[] genres;
    float rating;
|};

# This function is used to extract information about a person from a given prompt.
# 
# + context - model context information
# + prompt - function body as a natural language prompt
# + return - a Person object or an error
public isolated function getPersonInfo(np:Context context, np:Prompt prompt) returns Person|error = @np:NaturalFunction external;

# This function is used to extract information about a country from a given prompt.
# 
# + context - model context information 
# + prompt - function body as a natural language prompt
# + return - a Country object or an error
public isolated function getCountryInfo(np:Context context, np:Prompt prompt) returns Country|error = @np:NaturalFunction external;


# This function is used to extract information about an employee from a given prompt.
#
# + context - model context information 
# + prompt - function body as a natural language prompt
# + return - an Employee object or an error
public isolated function getEmployeeDetails(np:Context context, np:Prompt prompt) returns Employee|error = @np:NaturalFunction external;

# This function is used to extract information about a book from a given prompt.
#
# + context - model context information 
# + prompt - function body as a natural language prompt
# + return - a Book object or an error
public isolated function getBookInfo(np:Context context, np:Prompt prompt) returns Book|error = @np:NaturalFunction external;

# This function is used to extract multiple persons from a given prompt.
#
# + context - model context information 
# + prompt - function body as a natural language prompt
# + return - an array of Person objects or an error
public isolated function extractMultiplePersons(np:Context context, np:Prompt prompt) returns Person[]|error = @np:NaturalFunction external;

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

// Additional prompts for testing
np:Prompt emptyPrompt = ``;
np:Prompt employeePrompt = `Jane Doe is a 35-year-old software architect from Seattle. 
She lives at 456 Tech Avenue, Seattle, WA 98101. 
Her technical skills include Java, Python, Kubernetes, and Cloud Architecture. 
She currently earns $150,000 per year. Provide her details in a structured format.`;

np:Prompt bookPrompt = `"The Great Gatsby" is a novel written by F. Scott Fitzgerald, published in 1925. 
It's considered a classic of American literature and falls under the genres of tragedy, social criticism, 
and fiction. On average, readers rate it 4.2 out of 5 stars.`;

np:Prompt multiplePersonsPrompt = `Alice is 25 years old. Bob is 30 years old. Charlie is 40 years old. Give me these people's details in a structured format.`;

np:Prompt nonEnglishPrompt = `María tiene 28 años y vive en Madrid. Ella trabaja como ingeniera.`;

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

@test:Config {}
function testEmptyPrompt() returns error? {
    np:Context context = { model: check new OllamaModel() };
    var result = getPersonInfo(context, emptyPrompt);
    test:assertTrue(result is error, msg = "Expected an error for empty prompt");
}

@test:Config {}
function testComplexTypeEmployee() returns error? {
    np:Context context = { model: check new OllamaModel() };
    var result = getEmployeeDetails(context, employeePrompt);
    if result is Employee {
        test:assertEquals(result.name, "Jane Doe");
        test:assertEquals(result.age, 35);
        test:assertEquals(result.address.city, "Seattle");
        test:assertEquals(result.address.state, "WA");
        test:assertTrue(result.skills.length() > 0, "Expected skills array to be non-empty");
        test:assertEquals(result.salary, 150000.0);
    } else {
        test:assertFail(msg = result.toString());
    }
}

@test:Config {}
function testBookInfoExtraction() returns error? {
    np:Context context = { model: check new OllamaModel() };
    var result = getBookInfo(context, bookPrompt);
    if result is Book {
        test:assertEquals(result.title, "The Great Gatsby");
        test:assertEquals(result.author, "F. Scott Fitzgerald");
        test:assertEquals(result.year, 1925);
        test:assertTrue(result.genres.length() > 0, "Expected genres array to be non-empty");
        test:assertEquals(result.rating, 4.2);
    } else {
        test:assertFail(msg = result.toString());
    }
}

@test:Config {}
function testModelWithParameters() returns error? {
    np:Context context = { model: check new OllamaModel(model="llama3.2", timeout=180.0) };
    var result = getPersonInfo(context, johnPrompt);
    if result is Person {
        test:assertEquals(result.name, "John");
        test:assertEquals(result.age, 30);
    } else {
        test:assertFail(msg = result.toString());
    }
}

@test:Config {}
function testExtractArrayOfPersons() returns error? {
    np:Context context = { model: check new OllamaModel() };
    var result = extractMultiplePersons(context, multiplePersonsPrompt);
    if result is Person[] {
        test:assertEquals(result.length(), 3, "Expected 3 persons to be extracted");
        test:assertEquals(result[0].name, "Alice");
        test:assertEquals(result[0].age, 25);
        test:assertEquals(result[1].name, "Bob");
        test:assertEquals(result[1].age, 30);
        test:assertEquals(result[2].name, "Charlie");
        test:assertEquals(result[2].age, 40);
    } else {
        test:assertFail(msg = result.toString());
    }
}

@test:Config {}
function testNonEnglishPrompt() returns error? {
    np:Context context = { model: check new OllamaModel() };
    var result = getPersonInfo(context, nonEnglishPrompt);
    if result is Person {
        test:assertEquals(result.name, "María");
        test:assertEquals(result.age, 28);
    } else {
        test:assertFail(msg = result.toString());
    }
}

@test:Config {}
function testTimeout() returns error? {
    // Setting a very short timeout to force an error
    np:Context context = { model: check new OllamaModel(timeout=0.001) };
    var result = getPersonInfo(context, johnPrompt);
    test:assertTrue(result is error, msg = "Expected a timeout error");
}

@test:Config {}
function testModelContextSwitching() returns error? {
    np:Context context1 = { model: check new OllamaModel(model="llama3.2") };
    np:Context context2 = { model: check new OllamaModel(model="mistral") };
    
    var result1 = getPersonInfo(context1, johnPrompt);
    var result2 = getPersonInfo(context2, johnPrompt);
    
    if result1 is Person && result2 is Person {
        test:assertEquals(result1.name, "John", "Expected name to be John in context1");
        test:assertEquals(result1.age, 30, "Expected age to be 30 in context1");
        test:assertEquals(result2.name, "John", "Expected name to be John in context2");
        test:assertEquals(result2.age, 30, "Expected age to be 30 in context2");
    } else {
        test:assertFail(msg = "One or both models failed");
    }
}

@test:Config {}
function testParallelRequests() returns error? {
    np:Context context = { model: check new OllamaModel() };
    future<Person|error> f1 = start getPersonInfo(context, johnPrompt);
    future<Country|error> f2 = start getCountryInfo(context, canadaPrompt);
    
    var person = wait f1;
    var country = wait f2;
    
    if person is Person && country is Country {
        test:assertEquals(person.name, "John");
        test:assertEquals(country.name, "Canada");
    } else {
        test:assertFail(msg = "Parallel requests failed");
    }
}