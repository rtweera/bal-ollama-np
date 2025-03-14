import ballerina/io;
import ballerinax/np;
import ballerinax/ollama.np as ollamanp;

type Country record {|
    string name;
    string capital;
    string[] languages;
|};

# This function prompts LLM the to get information about a country.
#
# + context - model information  
# + prompt - prompt to be sent to the model
# + return - return in Country type
public isolated function getCountryInfo(
        np:Context context,
        np:Prompt prompt = `Tell me about Canada.`
) returns Country|error = @np:NaturalFunction external;

public function main() returns error? {
    final np:Context ollamaContext = {
        model: check new ollamanp:OllamaModel()
    };
    Country country = check getCountryInfo(ollamaContext);
    io:println("Country: ", country.name);
    io:println("Capital: ", country.capital);
    io:println("Languages: ", country.languages);
}
