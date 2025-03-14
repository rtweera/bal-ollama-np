type OllamaResponse record {|
    string model;
    string created_at;
    jsonMessage message;
    string done_reason;
    boolean done;
    int total_duration;
    int load_duration;
    int prompt_eval_count;
    int prompt_eval_duration;
    int eval_count;
    int eval_duration;
|};

type jsonMessage record {|
    string role;
    string content;
|};
