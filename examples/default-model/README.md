# Default Model Example

This example demonstrates the simplest usage of the Ollama library to fetch information about a country.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- Ollama installed and running locally (<https://ollama.com/>)
- At least one language model pulled in Ollama (e.g., `llama3.2:3B`)

    ```bash
    ollama pull llama3.2:3B
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
configurable string ollama_default_model = "llama3.2:3B";   // Default model to use
configurable decimal ollama_service_timeout = 120;          // Timeout in seconds
```

You can override these configurations in your `Config.toml` file:

```toml
[ballerinax.ollama.np]
ollama_service_url = "localhost:11434"  
ollama_default_model = "llama3.2:3B"
ollama_service_timeout = 60.0
```

## Usage

This example fetches information about a country, including its name, capital, and languages.

Run the following command to execute the example:

```sh
bal run
```

The output will display information about the country, including its name, capital, and languages.
