# Complex Person Example

This example demonstrates a more complex interaction with the Ollama model. It fetches detailed information about a person, including their name, age, address, hobbies, work experience, education, and projects.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- Ollama installed and running locally (<https://ollama.com/>)
- At least one language model pulled in Ollama (e.g., `gemma3`)

    ```bash
    ollama pull gemma3
    ```

## Installation

Add the package as a dependency in your `Ballerina.toml` file:

```toml
[[dependency]]
org = "ballerinax"
name = "ollama.np"
version = "0.1.0"
repository="local"
```

## Configuration

The package can be configured using the following parameters:

```ballerina
configurable string ollama_service_url = "localhost:11434"; // Ollama service URL
configurable string ollama_default_model = "gemma3";        // Default model to use
configurable decimal ollama_service_timeout = 120;          // Timeout in seconds
```

You can override these configurations in your `Config.toml` file:

```toml
[ballerinax.ollama.np]
ollama_service_url = "localhost:11434"  
ollama_default_model = "gemma3"
ollama_service_timeout = 60.0
```

## Usage

This example fetches detailed information about a person, including their name, age, address, hobbies, work experience, education, and projects.

Run the following command to execute the example:

```sh
bal run
```

The output will display detailed information about the person, including their name, age, address, hobbies, work experience, education, and projects.
