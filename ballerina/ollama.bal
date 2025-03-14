import ballerina/http;
import ballerinax/np;

configurable string ollama_service_url = "localhost:11434";
configurable string ollama_default_model = "llama3.2";
configurable decimal ollama_service_timeout = 120;

public isolated client class OllamaModel {
    *np:Model;

    private final http:Client cl;
    private final string model;

    public function init(string url=ollama_service_url, string model=ollama_default_model, decimal timeout=ollama_service_timeout) returns error? {
        self.cl = check new (url, timeout = timeout);
        self.model = model;
    }

    isolated remote function call(string prompt, map<json> expectedResponseSchema) returns json|error {
        json payload = {
            model: self.model,
            messages: [{role: "user", content: prompt}],
            'stream: false,
            format: expectedResponseSchema
        };
        http:Response httpResponse = check self.cl->/api/chat.post(payload);
        OllamaResponse response = check (check httpResponse.getJsonPayload()).fromJsonWithType();
        return response.message.content.fromJsonString();
    }
}