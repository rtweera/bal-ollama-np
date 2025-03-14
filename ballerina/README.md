# Ballerina Ollama NP Package

This package provides Ballerina Natural Programming (NP) integration with Ollama, allowing you to use local language models in your Ballerina applications.

## Overview

The `ballerinax/ollama.np` package enables seamless interaction with Ollama's local LLMs through Ballerina's Natural Programming capabilities. It provides a convenient interface to query language models running locally on your machine through Ollama.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- Ollama installed and running locally (https://ollama.com/)
- At least one language model pulled in Ollama (e.g., `llama3.2`, `codellama`, etc.)

## Installation

Add the package as a dependency in your Ballerina.toml file:

```toml
[[dependency]]
org = "ballerinax"
name = "ollama.np"
version = "0.1.0"
```

## Configuration

The package can be configured using the following parameters:

```ballerina
configurable string ollama_service_url = "localhost:11434"; // Ollama service URL
configurable string ollama_default_model = "llama3.2";      // Default model to use
configurable decimal ollama_service_timeout = 120;          // Timeout in seconds
```

You can override these configurations in your `Config.toml` file:

```toml
[ballerinax.ollama.np]
ollama_service_url = "localhost:11434"  
ollama_default_model = "llama2"
ollama_service_timeout = 60.0
```

## Usage

### Basic Example

```ballerina
import ballerinax/ollama.np as ollama;
import ballerina/natural as np;
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

```

### Using with Different Models

```ballerina
// Use a specific model
final np:Context ollamaContext = {
    model: check new ollama:OllamaModel(model="mistral")
};
```

## API Reference

### ollamaModel

<!-- ```ballerina
function ollamaModel(string model, np:Prompt prompt, map<any>? options = ()) returns json|error
```

Parameters:
- `model`: Name of the Ollama model to use
- `prompt`: The input prompt/query to send to the model
- `options`: Optional parameters like output format

Returns:
- A JSON response containing the model's output or an error -->

## License

This project is licensed under the Apache License 2.0 - see the LICENSE file in the project root for details.
